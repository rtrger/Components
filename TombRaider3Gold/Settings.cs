using System;
using System.Windows.Forms;

// Have to inherit UserControl otherwise compiler outputs "Cannot convert type 'ComponentSettings' to 'System.Windows.Forms.Control'".
public class ComponentSettings : UserControl
{
    public System.Windows.Forms.TableLayoutPanel tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
    private GroupBox modeSelector;
    public RadioButton indivLevelsMode;
    public RadioButton fullGameMode;
    public bool ilMode = false;

    public ComponentSettings()
    {
        InitializeComponent();
    }

    private void InitializeComponent()
    {
            this.modeSelector = new System.Windows.Forms.GroupBox();
            this.indivLevelsMode = new System.Windows.Forms.RadioButton();
            this.fullGameMode = new System.Windows.Forms.RadioButton();
            this.modeSelector.SuspendLayout();
            this.SuspendLayout();
            // 
            // modeSelector
            // 
            this.modeSelector.Controls.Add(this.indivLevelsMode);
            this.modeSelector.Controls.Add(this.fullGameMode);
            this.modeSelector.Location = new System.Drawing.Point(3, 3);
            this.modeSelector.Name = "modeSelector";
            this.modeSelector.Size = new System.Drawing.Size(454, 43);
            this.modeSelector.TabIndex = 0;
            this.modeSelector.TabStop = false;
            this.modeSelector.Text = "Mode Selector";
            // 
            // indivLevelsMode
            // 
            this.indivLevelsMode.AutoSize = true;
            this.indivLevelsMode.Location = new System.Drawing.Point(111, 16);
            this.indivLevelsMode.Name = "indivLevelsMode";
            this.indivLevelsMode.Size = new System.Drawing.Size(129, 17);
            this.indivLevelsMode.TabIndex = 1;
            this.indivLevelsMode.Text = "Individual levels mode";
            this.indivLevelsMode.UseVisualStyleBackColor = true;
            this.indivLevelsMode.CheckedChanged += new System.EventHandler(this.indivLevelsMode_CheckedChanged);
            // 
            // fullGameMode
            // 
            this.fullGameMode.AutoSize = true;
            this.fullGameMode.Location = new System.Drawing.Point(6, 16);
            this.fullGameMode.Name = "fullGameMode";
            this.fullGameMode.Size = new System.Drawing.Size(99, 17);
            this.fullGameMode.TabIndex = 0;
            this.fullGameMode.Text = "Full game mode";
            this.fullGameMode.UseVisualStyleBackColor = true;
            this.fullGameMode.CheckedChanged += new System.EventHandler(this.fullGameMode_CheckedChanged);
            // 
            // ComponentSettings
            // 
            this.Controls.Add(this.modeSelector);
            this.Name = "ComponentSettings";
            this.Size = new System.Drawing.Size(460, 49);
            this.modeSelector.ResumeLayout(false);
            this.modeSelector.PerformLayout();
            this.ResumeLayout(false);

    }

    private void fullGameMode_CheckedChanged(object sender, EventArgs e)
    {
        ilMode = false;
    }

    private void indivLevelsMode_CheckedChanged(object sender, EventArgs e)
    {
        ilMode = true;
    }
}
