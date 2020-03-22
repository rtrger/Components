// Notes for building with Visual Studio:
// You can only compile LiveSplit related projects properly with Visual Studio 2015!
// Both LiveSplit.Model and LiveSplit.UI.Components are in LiveSplit.Core.dll.
// Right click on Solution Explorer's Dependencies, click Add Reference, 
// click Browse on the bottom right corner, then add LiveSplit.Core.dll from your LiveSplit folder.
// Make sure both UpdateManager.dll and LiveSplit.Core.dll are ticked.

// Building with csc:
// Get out the developer console for VS2015 and type:
// csc /reference:<where your LiveSplit.Core.dll is> /reference:<where your UpdateManager.dll is> /t:library /out:C:\MyComponent.dll <path to your 1st source file> <path to your 2nd source file> etc.

// Note: if the component is listed in LiveSplit.AutoSplitters.xml, then you won't see the component showing up in the Layout Editor!

// Contains the Version class.
using System;
// Contains the LiveSplitState class.
using LiveSplit.Model;
// Contains IComponentFactory, IComponent, InfoTextComponent, ComponentCategory.
using LiveSplit.UI.Components;
// Needed for the [assembly:...] line.
using LiveSplit.TR3GComponent;
using System.Reflection;

// Without this the component doesn't appear in the Layout Editor's "+" menu.
[assembly: ComponentFactory(typeof(TR3GComponentFactory))] 

namespace LiveSplit.TR3GComponent
{
	// Need to implement every definition in the IComponentFactory interface otherwise the compiler will show an error.
	// Definitions in IComponentFactory: 
	// https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit/LiveSplit.Core/UI/Components/IComponentFactory.cs
	// IComponentFactory has to implement IUpdatable too:
	// https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit/UpdateManager/IUpdateable.cs
	public class TR3GComponentFactory : IComponentFactory
    	{
		// IComponentFactory implementations:
		
		// Text you see in the menu which you see after pressing + in the Layout Editor.
        	public string ComponentName => "Tomb Raider: The Lost Artifact";

		// If you hover over "My first component." in the "+" menu this is the help text that's gonna be displayed.
        	public string Description => "Game time, autostart, autoreset and autosplit for Tomb Raider 3 Gold.";

		// This will make the component appear in the "Timer" section of the "+" menu.
        	public ComponentCategory Category => ComponentCategory.Timer;

		// Loads in our own autosplitter/load remover/UI code to LiveSplit.
       		public IComponent Create(LiveSplitState state)
       		{
            	return new TR3GComponent(state);
        	}

		// IUpdatable implementations:

		// The constructor Version(Int32, Int32) works fine, Version(String) gives an error in the Event Viewer!
		public Version Version => Assembly.GetExecutingAssembly().GetName().Version;

        	public string UpdateName => ComponentName;

        	// URL pointing to the repository that contains the source code of the component.
        	// It has to be the raw github link!
        	public string UpdateURL => "https://raw.githubusercontent.com/rtrger/Components/master/TombRaider3Gold/";

		// XML which is checked to see whether it's needed to update the component or not.
        	public string XMLURL => UpdateURL + "Component/update.xml"; // value should be: UpdateURL + "file path to the XML file relative to UpdateURL"
    	}
}
