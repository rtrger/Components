using System;
using System.Xml;
using LiveSplit.Model;
using LiveSplit.UI;
using LiveSplit.UI.Components;
using TR3Gold;

namespace LiveSplit.TR3GComponent
{
    public class TR3GComponent : LogicComponent
    {
        public ComponentSettings compSettings = new ComponentSettings();
        private GameMemory _gm = new GameMemory();
        private TimerModel _tm = new TimerModel();

        public TR3GComponent(LiveSplitState state)
        {
            _tm.CurrentState = state;
            _gm.start += do_start;
            _gm.reset += do_reset;
            _gm.split += do_split;
        }

        // Text that is displayed in the white area of the Layout Editor.
        public override string ComponentName => "Tomb Raider: The Lost Artifact";

        // Loads the settings of this component from XML. This might happen more than once
        // (e.g. when the settings dialog is cancelled, to restore previous settings).
        // The XML file is the "<game name - category>.lss" file in your LiveSplit folder.
        // See the links below how to use it.
        public override void SetSettings(XmlNode settings)
        {
            compSettings.ilMode = (settings["ilMode"].InnerText == "True");
            if (compSettings.ilMode)
            {
                compSettings.indivLevelsMode.Checked = true;
                compSettings.fullGameMode.Checked = false;
            }
            else
            {
                compSettings.indivLevelsMode.Checked = false;
                compSettings.fullGameMode.Checked = true;
            }
        }

        // Writes out your component's settings into the .lss file.
        // Examples of usage: https://github.com/LiveSplit/LiveSplit.ScriptableAutoSplit/blob/7e5a6cbe91569e7688fdb37446d32326b4b14b1c/ComponentSettings.cs#L70
        // https://github.com/CapitaineToinon/LiveSplit.DarkSoulsIGT/blob/master/LiveSplit.DarkSoulsIGT/UI/DSSettings.cs#L25
        public override XmlNode GetSettings(XmlDocument document)
        {
            // Even if you don't have any settings, you can't return with null.
            // If you do, LiveSplit spams the Event Viewer with the "Object reference not set to an instance of an object." error message.
            XmlElement settingsNode = document.CreateElement("Settings");
            settingsNode.AppendChild(SettingsHelper.ToElement(document, nameof(compSettings.ilMode), compSettings.ilMode));
            return settingsNode;
        }

        // Shows a dialog where the user can configure the component.
        public override System.Windows.Forms.Control GetSettingsControl(LayoutMode mode)
        {
            // compSettings must contain at least an empty TableLayoutPanel otherwise the Layout Settings menu doesn't show up!
            return compSettings;
        }

        // This is always called while the component is added to your LiveSplit layout.
        public override void Update(IInvalidator invalidator, LiveSplitState state, float width, float height, LayoutMode mode)
        {
            _gm.ILsettings = compSettings.ilMode;

            _gm.Update();

            if (state.CurrentPhase == TimerPhase.Running)
            {
                state.SetGameTime(new TimeSpan(0, 0, 0, _gm.gameTime, 0));
            }
        }

        // Releases all game-related resources (unhooks the game for example).
        public override void Dispose()
        {
            _gm.game = null;
        }

        void do_start(object sender, EventArgs e)
        {
            _tm.Start();
        }

        void do_split(object sender, EventArgs e)
        {
            _tm.Split();
        }

        void do_reset(object sender, EventArgs e)
        {
            _tm.Reset();
        }

    }
}

// Notes to the LCGoL component - https://github.com/fatalis/LiveSplit.LaraCroftGoL:
// Timer class = System.Windows.Forms Timer
// TimerModel class - https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit/LiveSplit.Core/Model/TimerModel.cs
// How the component works:
// It instantiates "_updateTimer = new Timer() { Interval = 15, Enabled = true }" which is Winform's Timer class: https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.timer?view=netframework-4.8
// Then it adds the updateTimer_Tick method to the Tick event of _updateTimer (_updateTimer.Tick += updateTimer_Tick line).
// updateTimer_Tick contains the call to _gameMemory.Update().
// Update() updates the MemoryWatcherList and calls the gameMemory_OnFirstLevelStarted, gameMemory_OnFirstLevelLoading
// and the other gameMemory_... methods in GoLSplitComponent.cs. 
// These methods are responsible for starting/splitting/stopping LiveSplit's timer.
// The Tick method is called constantly by some code in LiveSplit's ComponentManager class.

// Notes to CapitaineToinon's DS1 component:
// No autostart or autoreset. It only displays IGT and resets inventory indexes.
// The IGT display is done through the "state" variable, using the SetGameTime call in the Update method.
