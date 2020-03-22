using System;
using System.Diagnostics;
using LiveSplit.ComponentUtil;

namespace TR3Gold
{
    class GameData : MemoryWatcherList
    {
        public MemoryWatcher<byte> level { get; } = new MemoryWatcher<byte>(new DeepPointer(0xC05FE));
        public MemoryWatcher<bool> isTitle { get; } = new MemoryWatcher<bool>(new DeepPointer(0x29AA04));
        public MemoryWatcher<bool> isLevelComplete { get; } = new MemoryWatcher<bool>(new DeepPointer(0x22CE38));
        public MemoryWatcher<int> currentLevelTime { get; } = new MemoryWatcher<int>(new DeepPointer(0x2CB3EF));
    }

    class GameMemory
    {
        public Process game = null;
        public GameData gd = new GameData();
        public int gameTime = 0;
        private int _idxLvlTime = 0;
        const int IGTTicksPerSecond = 30;
        IntPtr firstLevelTime = (IntPtr)0x6CAF46;
        public bool ILsettings = false;
        private int updateCount = 0;
        public event EventHandler start;
        public event EventHandler reset;
        public event EventHandler split;

        public bool GetGameProcess()
        {
            Process[] gameP = Process.GetProcessesByName("tr3gold");
            if (gameP.Length != 0)
            {
                game = gameP[0];
                return true;
            }
            return false;
        }

        public void Update()
        {
            if (game == null || game.HasExited)
            {
                game = null;
                if (!GetGameProcess())
                {
                    return;
                }
                gd.ResetAll();
                updateCount = 0;
            }

            gd.level.Update(game);
            gd.isTitle.Update(game);
            gd.isLevelComplete.Update(game);
            gd.currentLevelTime.Update(game);

            updateCount++;

            if (updateCount >= 2)
            {
                if (ILsettings)
                {
                    if (gd.currentLevelTime.Old == 0 && gd.currentLevelTime.Current != 0)
                        start?.Invoke(this, EventArgs.Empty);
                }
                else if (gd.level.Current == 1 && gd.currentLevelTime.Old == 0 && gd.currentLevelTime.Current != 0)
                {
                    start?.Invoke(this, EventArgs.Empty);
                }

                if (gd.isTitle.Current && !gd.isTitle.Old)
                {
                    reset?.Invoke(this, EventArgs.Empty);
                }

                if (gd.isLevelComplete.Current && !gd.isLevelComplete.Old)
                {
                    split?.Invoke(this, EventArgs.Empty);
                }

                if (ILsettings)
                    gameTime = gd.currentLevelTime.Current / IGTTicksPerSecond;
                else
                {
                    int finishedLevelsTime = 0;
                    // The game stores statistics (including time) for each completed level on separate addresses.
                    for (int i = 0; i < (gd.level.Current - 1); i++)
                    {
                        ExtensionMethods.ReadValue<int>(game, (IntPtr)(firstLevelTime + (i * 0x33)), out _idxLvlTime);
                        finishedLevelsTime += _idxLvlTime;
                    }
                    gameTime = (gd.currentLevelTime.Current + finishedLevelsTime) / IGTTicksPerSecond;
                }
            }
        }
    }
}
