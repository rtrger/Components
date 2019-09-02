state("Mask", "Disc")
{
	bool loading: 0x21DA28;
	bool saving: 0x21DBC0;
	byte miniMapID: 0x1B6B20;
	bool deadLucreto: 0x1B991C, 0x34;
}

state("Mask", "GOG")
{
	bool loading: 0x21E840;
	bool saving: 0x21EA18;
	byte miniMapID: 0x1BE8C8;
	bool deadLucreto: 0x1BD674, 0x34;
}

startup
{
	settings.Add("split", true, "Split at entering:");
	settings.Add("Castle", false, "Castle Daventry", "split");
	settings.Add("Death", false, "Dimension of Death", "split");
	settings.Add("Swamp", false, "The Swamp", "split");
	settings.Add("Gnomes", false, "Underground Realm of the Gnomes", "split");
	settings.Add("Barren", false, "The Barren Region", "split");
	settings.Add("Frozen", false, "The Frozen Reaches", "split");
	settings.Add("Paradise", false, "Paradise Lost", "split");
	settings.Add("RotS1", false, "Realm of the Sun Level 1", "split");
	settings.Add("RotS2", false, "Realm of the Sun Level 2", "split");
	settings.Add("RotS3", false, "Realm of the Sun Level 3", "split");
	settings.Add("RotSAR", false, "Realm of the Sun Altar Room", "split");
}

init
{
	string exePath = proc.MainModule.FileName;
	string hashInHex = "0";
	using (var md5 = System.Security.Cryptography.MD5.Create())
    	{
        	using (var stream = File.Open(exePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        	{
            		var hash = md5.ComputeHash(stream);
			hashInHex = BitConverter.ToString(hash).Replace("-", "");
        	}
    	}
	
	if(hashInHex == "28CCCC57D30210070B6A544D7BA8D22F")
		version = "Disc";
	else version = "GOG";
	
	vars.prevMapID = vars.currMapID = 0;
}

isLoading
{
	return (current.loading || current.saving);
}

start
{
	vars.prevMapID = vars.currMapID = 0;
}

split
{
	// During loading, the game sets miniMapID to the currently loaded level's miniMapID value. Splitting is based on that.
	if(old.loading && !current.loading) {
		vars.prevMapID = vars.currMapID;
		vars.currMapID = current.miniMapID;
		if((vars.prevMapID == 0 && vars.currMapID == 14 && settings["Castle"])   ||
		   (vars.prevMapID == 0 && vars.currMapID == 1 && settings["Death"])     ||
		   (vars.prevMapID == 1 && vars.currMapID == 2 && settings["Swamp"])     ||
		   (vars.prevMapID == 2 && vars.currMapID == 3 && settings["Gnomes"])    ||
		   (vars.prevMapID == 3 && vars.currMapID == 4 && settings["Barren"])    ||
		   (vars.prevMapID == 4 && vars.currMapID == 6 && settings["Frozen"])    ||
		   (vars.prevMapID == 6 && vars.currMapID == 15 && settings["Paradise"]) ||
		   (vars.prevMapID == 15 && vars.currMapID == 7 && settings["RotS1"])    ||
		   (vars.prevMapID == 7 && vars.currMapID == 8 && settings["RotS2"])	 ||
		   (vars.prevMapID == 8 && vars.currMapID == 9 && settings["RotS3"]) 	 ||
		   (vars.prevMapID == 9 && vars.currMapID == 10 && settings["RotSAR"]))
				return true;
	}

	if(!old.deadLucreto && current.deadLucreto && vars.currMapID == 10)
		return true;
	
}

/*
miniMapID values:
0: Kingdom of Daventry
1: Dimension of Death
2: The Swamp
3: Underground Realm of the Gnomes
4: The Barren Region
6: The Frozen Reaches
7: Realm of the Sun Level 1
8: Realm of the Sun Level 2
9: Realm of the Sun Level 3
10: Realm of the Sun Altar Room
14: Castle Daventry
15: Paradise Lost
*/
