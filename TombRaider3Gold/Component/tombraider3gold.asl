state("tr3gold")
{
	byte level: 0xC05FE;
	bool isTitle: 0x29AA04;
	bool isLevelComplete: 0x22CE38;
	uint currentLevelTime: 0x2CB3EF;
}

startup
{
	settings.Add("IL", false, "Individual levels mode.");
}

start
{
	if (settings["IL"])
	{
		return (old.currentLevelTime == 0 && current.currentLevelTime != 0);
	}
	else
	{
		return (current.level == 1 && old.currentLevelTime == 0 && current.currentLevelTime != 0);
	}
}

reset
{
	return (current.isTitle && !old.isTitle);
}

split
{
	return (current.isLevelComplete && !old.isLevelComplete);
}

isLoading
{
	return false;
}

gameTime
{
	const int ticksPerSecond = 30;

	if (settings["IL"])
	{
		return TimeSpan.FromSeconds(current.currentLevelTime / ticksPerSecond);
	}
	else
	{
		var firstLevelTime = (IntPtr)0x6CAF46;
		int finishedLevelsTime = 0;
		// The game stores statistics (including time) for each completed level on separate addresses.
		for (int i = 0; i < (current.level - 1); i++)
		{
			finishedLevelsTime += memory.ReadValue<int>((IntPtr)(firstLevelTime + (i * 0x33)));
		}
		return TimeSpan.FromSeconds((current.currentLevelTime + finishedLevelsTime) / ticksPerSecond);
	}
}