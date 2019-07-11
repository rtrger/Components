state("TRAOD", "TRAOD.exe, v39")
{
	byte gameAction: 0x439AB8;
	string30 mapName: 0x4887EA;
}

state("TRAOD_P3", "TRAOD_P3.exe, v39")
{
	byte gameAction: 0x372A64;
	string30 mapName: 0x41CDAA;
}

state("TRAOD_P4", "TRAOD_P4.exe, v39")
{
	byte gameAction: 0x3833E4;
	string30 mapName: 0x42D72A;
}

state("TRAOD", "TRAOD.exe, v42")
{
	byte gameAction: 0x4506C8;
	string30 mapName: 0x49F3EA;
}

state("TRAOD_P3", "TRAOD_P3.exe, v42")
{
	byte gameAction: 0x37CDE4;
	string30 mapName: 0x42712A;
}

state("TRAOD_P4", "TRAOD_P4.exe, v42")
{
	byte gameAction: 0x38D724;
	string30 mapName: 0x437A6A;
}

state("TRAOD", "TRAOD.exe, v49")
{
	byte gameAction: 0x46D348;
	string30 mapName: 0x4BC06A;
}

state("TRAOD_P3", "TRAOD_P3.exe, v49")
{
	byte gameAction: 0x3A5104;
	string30 mapName: 0x44F44A;
}

state("TRAOD_P4", "TRAOD_P4.exe, v49")
{
	byte gameAction: 0x3B5A44;
	string30 mapName: 0x45FD8A;
}

state("TRAOD", "TRAOD.exe, v52")
{
	byte gameAction: 0x46E208;
	string30 mapName: 0x4BCF2A;
}

state("TRAOD_P3", "TRAOD_P3.exe, v52")
{
	byte gameAction: 0x3A5144;
	string30 mapName: 0x44F48A;
}

state("TRAOD_P4", "TRAOD_P4.exe, v52")
{
	byte gameAction: 0x3B6A84;
	string30 mapName: 0x460DCA;
}

state("TRAOD", "TRAOD.exe, v52J")
{
	byte gameAction: 0x4A25FC;
	string30 mapName: 0x4F138A;
}

state("TRAOD_P3", "TRAOD_P3.exe, v52J")
{
	byte gameAction: 0x3E0B04;
	string30 mapName: 0x48AE0A;
}

state("TRAOD_P4", "TRAOD_P4.exe, v52J")
{
	byte gameAction: 0x3F1344;
	string30 mapName: 0x49B64A;
}

start
{
	// Documentation of the magic constants can be found at the bottom of this script file.
	return (old.gameAction == 1 && current.gameAction == 0);
}

reset
{
	return (old.gameAction == 0 && current.gameAction == 1);
}

split
{
	if(vars.newLevelLoading)
	{
		for(int i = 0; i < vars.levelInfo.Length; i++)
		{
			if(settings[vars.levelInfo[i].Item2] == true && old.mapName == vars.levelInfo[i].Item3 && current.mapName == vars.levelInfo[i].Item4 && vars.hasSplit[i] == false)
			{
				vars.hasSplit[i] = true;
				return true;
			}
		}
	}
	
	// Final split (doesn't occur when vars.newLevelLoading == 1 so has to be handled separately).
	return (settings["eckhardt"] && old.mapName == "PRAGUE6.GMX" && current.mapName == "FRONTEND.GMX"); 
}

startup
{
	// This is for writing TC instead of Tuple.Create.
	Func<string, string, string, string, Tuple<string, string, string, string>> TC = Tuple.Create;

	// Data for autosplitting (except for the final split point). If you want a new split point, just add a new tuple to this array.
	// Each tuple is built the following way: TC(<levelname shown in LS' settings>, <settings name>, <file name of the map you leave>, <file name of the map you enter>).
	vars.levelInfo = new Tuple<string, string, string, string>[]
	{
		TC("Parisian Back Streets", "backstreets", "PARIS1.GMX", "PARIS1A.GMX"),
		TC("Derelict Apartment Block", "derelict", "PARIS1A.GMX", "PARIS1C.GMX"),
		TC("Industrial Roof Tops", "industrial", "PARIS1C.GMX", "PARIS1B.GMX"),
		TC("Margot Carvier's Apartment", "carvier", "PARIS1B.GMX", "PARIS2_1.GMX"),
		TC("The Serpent Rouge", "serpent", "PARIS2B.GMX", "PARIS2_1.GMX"),
		TC("St. Aicard's Graveyard", "aicard", "PARIS2G.GMX", "PARIS2H.GMX"),
		TC("Bouchard's Hideout", "bouchard", "PARIS2H.GMX", "PARIS2E.GMX"),
		TC("Rennes' Pawnshop", "rennes", "CUTSCENE\\CS_2_51A.GMX", "PARIS3.GMX"),
		TC("Louvre Storm Drains", "stormdrains", "PARIS3.GMX", "PARIS4.GMX"),
		TC("Louvre Galleries", "galleries", "PARIS4.GMX", "PARIS5A.GMX"),
		TC("The Archaeological Dig", "dig", "PARIS5A.GMX", "PARIS5.GMX"),
		TC("Tomb of Ancients", "ancients", "PARIS5.GMX", "PARIS5_1.GMX"),
		TC("Neptune's Hall", "neptune", "PARIS5_2.GMX", "PARIS5_1.GMX"),
		TC("Wrath of the Beast", "beast", "PARIS5_3.GMX", "PARIS5_1.GMX"),
		TC("The Sanctuary of Flame", "flame", "PARIS5_4.GMX", "PARIS5_1.GMX"),
		TC("The Breath of Hades", "hades", "PARIS5_5.GMX", "PARIS5_1.GMX"),
		TC("The Hall of Seasons", "seasons", "PARIS5_1.GMX", "PARIS5.GMX"),
		TC("Tomb of Ancients (flooded)", "ancients2", "PARIS5.GMX", "PARIS5A.GMX"),
		TC("The Archaeological Dig", "dig2", "PARIS5A.GMX", "PARIS4A.GMX"),
		TC("Galleries Under Siege", "siege", "CUTSCENE\\CS_6_21B.GMX", "PARIS6.GMX"),
		TC("Von Croy's Apartment", "voncroy", "CUTSCENE\\CS_7_19.GMX", "PRAGUE1.GMX"),
		TC("The Monstrum Crimescene", "crimescene", "CUTSCENE\\CS_9_1.GMX", "PRAGUE2.GMX"),
		TC("The Strahov Fortress", "strahov", "PRAGUE2.GMX", "PRAGUE3.GMX"),
		TC("The Bio-Research Facility", "biores", "CUTSCENE\\CS_10_14.GMX", "PRAGUE4.GMX"), 
		TC("The Sanitarium", "sanitarium", "PRAGUE4.GMX", "PRAGUE4A.GMX"),
		TC("Maximum Containment Area", "containment", "CUTSCENE\\CS_12_1.GMX", "PRAGUE3A.GMX"),
		TC("Aquatic Research Area", "aqua", "PRAGUE3A.GMX", "PRAGUE5.GMX"),
		TC("Vault of Trophies", "vault", "CUTSCENE\\CS_13_9.GMX", "PRAGUE5A.GMX"),
		TC("Boaz Returns", "boaz", "CUTSCENE\\CS_14_6.GMX", "PRAGUE6A.GMX"),
		TC("The Lost Domain", "domain", "PRAGUE6A.GMX", "PRAGUE6.GMX")
	};

	settings.Add("autosplit", true, "Split automatically at the end of:");
	foreach(var levelTuple in vars.levelInfo)
	{
		settings.Add(levelTuple.Item2, false, levelTuple.Item1, "autosplit");
	}
	settings.Add("eckhardt", true, "Eckhardt's Lab", "autosplit");
	settings.SetToolTip("boaz", "This is Vault of Trophies' end in the any% route.");
	settings.SetToolTip("dig", "Tick this if you're heading to Tomb of Ancients and you want a split point as The Archaeological Dig level ends.");
	settings.SetToolTip("dig2", "Tick this if you're heading to Galleries Under Siege and you want a split point as The Archaeological Dig level ends.");
	settings.SetToolTip("bouchard", "Tick this if you want a split point as you leave to St. Aicard's Church from Bouchard's Hideout.");

	// This array is for preventing splitting multiple times on the same split point.
	vars.hasSplit = new bool[vars.levelInfo.Length];

	// This variable is used to prevent splits during loads started from loading a save file.
	vars.newLevelLoading = new bool();
	
	// See the update block why this is needed.
	vars.currPhase = timer.CurrentPhase;
	
	// This dictionary contains the SHA256 hashes for all known AoD executables.
	var exeVersions = new Dictionary<string, string>{
		{"F2564F2CAF957EAC507164D03375527688B09D40B6BEB6E4A8F8C65C67832016", "TRAOD.exe, v39"},
		{"104A40F706AEA8D4576019608DBCBD6C61E4516CC2EC666ED01E7680B244B22A", "TRAOD_P3.exe, v39"},
		{"AEDCED942368BBCB2E4B53641C1BFC6575A5F0C2AAFD3BFFEE42D4A6566A6B2C", "TRAOD_P4.exe, v39"},
		{"3D9D892DE236D533F0E619C1AC4A5C258B1192CB4034333F0FAB957C7FD5C879", "TRAOD.exe, v42"},
		{"4494B17D051078D23A5EC8FFE2E534C3BFF7990FC426C2F7A32A70614369E1A7", "TRAOD_P3.exe, v42"},
		{"AB0133965470BFA1D7D923D8615BF65A3EE2C11A53ABE8BB187F63EC4FA837A6", "TRAOD_P4.exe, v42"},
		{"13BB9733D08B08C47EE2CD13738C65640BE303646955DE0F2B463CDD879F9BFA", "TRAOD.exe, v49"},
		{"E8F9A7FE42058DE8D4F10672EBA5DBFA3C34EDB2D1F1BA12ADB93321C8F2A7E0", "TRAOD_P3.exe, v49"},
		{"24E557D61536C486208C072B45DE09E8463F93AFBA6B74BF3EA0DE9A3C4FE68C", "TRAOD_P3.exe, v49"}, // AMD fix
		{"2F0FBA16B2B766C39625E88714670B8E5BB464FBFA0185C1B59F473E4AA755B1", "TRAOD_P4.exe, v49"},
		{"0BE26792C46A7BFDDD232F8FBE5AD18110D9E6DE0D031CE71D0E68A26559E68F", "TRAOD.exe, v52"},
		{"E221D8E2644B8364CF92FCF6B2F9A2160902C5CAAF2D7EB2B8BA60AE303A1AD3", "TRAOD_P3.exe, v52"},
		{"4B9CDFF3745480F25EECD4F865EE51CC3480599089B41A4B908B90C6CB45C63B", "TRAOD_P4.exe, v52"},
		{"885E50D8D59A9ACF20D07B7122902E0C175018D0DE16C00B72FF733853C7F23F", "TRAOD.exe, v52J"},
		{"AD691745992E4A646AF9C58495828466D7BCC42D087B6A89109EB8B0E09BAD1F", "TRAOD_P3.exe, v52J"},
		{"6CAD85F5C287762CCC5F355AE86BD644AD5423B30CEC262538CF69FDFFE499A9", "TRAOD_P4.exe, v52J"}
	};

	// Rest of the startup block contains various function declarations.

	vars.DetermineVersion = (Func<Process, string>)(proc =>
	{
		string exePath = proc.ModulesWow64Safe().First(mod => mod.FileName.ToLower().EndsWith(".exe")).FileName;
		string hashInHex = "0";
		using (var sha256 = System.Security.Cryptography.SHA256.Create())
    		{
        		using (var stream = File.Open(exePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        		{
            			var hash = sha256.ComputeHash(stream);
				hashInHex = BitConverter.ToString(hash).Replace("-", "");
        		}
    		}
		
		foreach(KeyValuePair<string, string> kvp in exeVersions)
		{
			if(kvp.Key == hashInHex)
			{
				return kvp.Value;
			}
		}
		
		return "Unrecognized";
	});

	vars.SetPointers = (Action<string>)(gameVer =>
	{
		if(gameVer == "TRAOD.exe, v39")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x5027D6), new IntPtr(0x500278)};
			vars.sysBeginLoadingScreen = new IntPtr(0x4244C0);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x5027F2), new IntPtr(0x5002AA)};
			vars.sysEndLoadingScreen = new IntPtr(0x424890);
		}
		else if(gameVer == "TRAOD_P3.exe, v39")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x52C01E), new IntPtr(0x529D34)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42B4EC);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52C3E2), new IntPtr(0x529D69)};
			vars.sysEndLoadingScreen = new IntPtr(0x42B598);
		}
		else if(gameVer == "TRAOD_P4.exe, v39")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x531522), new IntPtr(0x52F1F7)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42C9B0);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x531902), new IntPtr(0x52F22C)};
			vars.sysEndLoadingScreen = new IntPtr(0x42CA5C);
		}
		else if(gameVer == "TRAOD.exe, v42")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x5039C6), new IntPtr(0x501468)};
			vars.sysBeginLoadingScreen = new IntPtr(0x4254C0);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x5039E2), new IntPtr(0x50149A)};
			vars.sysEndLoadingScreen = new IntPtr(0x425890);
		}
		else if(gameVer == "TRAOD_P3.exe, v42")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x52D3EA), new IntPtr(0x52B100)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42C84C);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52D7AE), new IntPtr(0x52B135)};
			vars.sysEndLoadingScreen = new IntPtr(0x42C8F8);
		}
		else if(gameVer == "TRAOD_P4.exe, v42")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x532A2A), new IntPtr(0x5306FB)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42DB20);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x532E0A), new IntPtr(0x530730)};
			vars.sysEndLoadingScreen = new IntPtr(0x42DBCC);
		}
		else if(gameVer == "TRAOD.exe, v49")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x504F36), new IntPtr(0x5029E8)}; 
			vars.sysBeginLoadingScreen = new IntPtr(0x425630);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x504F52), new IntPtr(0x502A1A)};
			vars.sysEndLoadingScreen = new IntPtr(0x425A00);
		}
		else if(gameVer == "TRAOD_P3.exe, v49")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x52EE7A), new IntPtr(0x52CB90)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42CAC8);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52F20E), new IntPtr(0x52CBC5)};
			vars.sysEndLoadingScreen = new IntPtr(0x42CB74);
		}
		else if(gameVer == "TRAOD_P4.exe, v49")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x5345E2), new IntPtr(0x5322B3)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42E368);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x534992), new IntPtr(0x5322E8)};
			vars.sysEndLoadingScreen = new IntPtr(0x42E414);
		}
		else if(gameVer == "TRAOD.exe, v52")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x504C36), new IntPtr(0x5026F8)};
			vars.sysBeginLoadingScreen = new IntPtr(0x425510);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x504C52), new IntPtr(0x50272A)};
			vars.sysEndLoadingScreen = new IntPtr(0x4258E0);
		}
		else if(gameVer == "TRAOD_P3.exe, v52")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x52C98C), new IntPtr(0x52EC72)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42C9F4);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52F002), new IntPtr(0x52C9C1)};
			vars.sysEndLoadingScreen = new IntPtr(0x42CAA0);
		}
		else if(gameVer == "TRAOD_P4.exe, v52")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x5320AF), new IntPtr(0x5343DA)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42E1F8);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x5320E4), new IntPtr(0x534786)};
			vars.sysEndLoadingScreen = new IntPtr(0x42E2A4);
		}
		else if(gameVer == "TRAOD.exe, v52J")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x502CA6), new IntPtr(0x5009C7)};
			vars.sysBeginLoadingScreen = new IntPtr(0x424DB0);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x502CC2), new IntPtr(0x5009F9)};
			vars.sysEndLoadingScreen = new IntPtr(0x425180);
		}
		else if(gameVer == "TRAOD_P3.exe, v52J")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x52A030), new IntPtr(0x52C046)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42BFA8);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52A072), new IntPtr(0x52C39E)};
			vars.sysEndLoadingScreen = new IntPtr(0x42C054);
		}
		else if(gameVer == "TRAOD_P4.exe, v52J")
		{
			vars.sBLSCalls = new IntPtr[]{new IntPtr(0x53191A), new IntPtr(0x52F8F8)};
			vars.sysBeginLoadingScreen = new IntPtr(0x42D630);
			vars.sELSCalls = new IntPtr[]{new IntPtr(0x52F92D), new IntPtr(0x531C86)};
			vars.sysEndLoadingScreen = new IntPtr(0x42D6DC);
		}
	});

	vars.CreateBLSDetourBytes = (Func<byte[], byte[]>)(loading =>
	{
		var sBLSCallDetour = new List<byte>(){0xC7, 0x05}; // MOV opcode.
		sBLSCallDetour.AddRange(loading);
		sBLSCallDetour.AddRange(new byte[]{1, 0, 0, 0});
		sBLSCallDetour.AddRange(new byte[]{0xFF, 0xFF, 0xFF, 0xFF, 0xFF}); // CALL placeholder.
		sBLSCallDetour.AddRange(new byte[]{0xFF, 0xFF, 0xFF, 0xFF, 0xFF}); // JMP placeholder.
		return sBLSCallDetour.ToArray();
	});

	vars.CreateELSDetourBytes = (Func<byte[], byte[]>)(loading =>
	{
		var sELSCallDetour = new List<byte>(){0xFF, 0xFF, 0xFF, 0xFF, 0xFF}; // CALL placeholder.
		sELSCallDetour.AddRange(new byte[]{0xC7, 0x05});
		sELSCallDetour.AddRange(loading);
		sELSCallDetour.AddRange(new byte[]{0, 0, 0, 0});
		sELSCallDetour.AddRange(new byte[]{0xFF, 0xFF, 0xFF, 0xFF, 0xFF}); // JMP placeholder.
		return sELSCallDetour.ToArray();
	});

	vars.InstallLoadRemovalHooks = (Action<Process>)(proc =>
	{
		proc.Suspend();

		vars.sBLSDetFuncPtrs = new IntPtr[2];
		vars.sELSDetFuncPtrs = new IntPtr[2];
		vars.loadingPtr = proc.AllocateMemory(sizeof(int));
		vars.loadingPtrBytes = BitConverter.GetBytes((uint)vars.loadingPtr);
		byte[] sBLSDetBy = vars.CreateBLSDetourBytes(vars.loadingPtrBytes);
		byte[] sELSDetBy = vars.CreateELSDetourBytes(vars.loadingPtrBytes);

		// There is one sysBeginLoadingScreen-sysEndLoadingScreen call pair for cutscene level loads and one for normal level loads.
		for(int i = 0; i < 2; i++)
		{
			vars.sBLSDetFuncPtrs[i] = proc.AllocateMemory(sBLSDetBy.Length); // Deallocated in shutdown.
			proc.WriteBytes((IntPtr)vars.sBLSDetFuncPtrs[i], sBLSDetBy);
			proc.WriteCallInstruction(IntPtr.Add((IntPtr)vars.sBLSDetFuncPtrs[i], 10), (IntPtr)vars.sysBeginLoadingScreen); // Writing the CALL to the CALL placeholder.
			proc.WriteJumpInstruction(IntPtr.Add((IntPtr)vars.sBLSDetFuncPtrs[i], 15), IntPtr.Add((IntPtr)vars.sBLSCalls[i], 5)); // Replacing the JMP placeholder.
			proc.WriteJumpInstruction((IntPtr)vars.sBLSCalls[i], (IntPtr)vars.sBLSDetFuncPtrs[i]);
			
			vars.sELSDetFuncPtrs[i] = proc.AllocateMemory(sELSDetBy.Length);
			proc.WriteBytes((IntPtr)vars.sELSDetFuncPtrs[i], sELSDetBy);
			proc.WriteCallInstruction((IntPtr)vars.sELSDetFuncPtrs[i], (IntPtr)vars.sysEndLoadingScreen);
			proc.WriteJumpInstruction(IntPtr.Add((IntPtr)vars.sELSDetFuncPtrs[i], 15), IntPtr.Add((IntPtr)vars.sELSCalls[i], 5));
			proc.WriteJumpInstruction((IntPtr)vars.sELSCalls[i], (IntPtr)vars.sELSDetFuncPtrs[i]);
		}

		proc.Resume();
	});
}

init
{
	version = vars.DetermineVersion(game);
		
	// Version is unrecognized = we don't know where the functions are. So we do nothing in that case.
	if(version != "Unrecognized")
	{
		vars.SetPointers(version);
		vars.InstallLoadRemovalHooks(game);
	}
}

update
{
	if(version == "Unrecognized")
	{
		return false;
	}

	vars.isLoading = game.ReadValue<bool>((IntPtr)vars.loadingPtr);

	if(old.gameAction != 3 && current.gameAction == 3)
	{
		vars.newLevelLoading = true;
	}
	
	if(old.gameAction == 3 && current.gameAction != 3)
	{
		vars.newLevelLoading = false;
	}
	
	// We want to initialize values whenever the timer stopped, both at auto and non-auto resets.
	vars.prevPhase = vars.currPhase;
	vars.currPhase = timer.CurrentPhase;
	
	if(vars.prevPhase == TimerPhase.Running && vars.currPhase == TimerPhase.NotRunning)
	{
		for(int i = 0; i < vars.hasSplit.Length; i++)
		{
			vars.hasSplit[i] = false;
		}
	}
}

isLoading
{
	return vars.isLoading;
}

shutdown
{
	// Restoring game code and freeing all allocated memory.
	if(version != "Unrecognized" && game != null)
	{
		game.Suspend();

		foreach(IntPtr calls in vars.sBLSCalls)
		{
			game.WriteCallInstruction(calls, (IntPtr)vars.sysBeginLoadingScreen);
		}

		foreach(IntPtr calls in vars.sELSCalls)
		{
			game.WriteCallInstruction(calls, (IntPtr)vars.sysEndLoadingScreen);
		}

		foreach(var allocPtr in vars.sBLSDetFuncPtrs)
		{
			game.FreeMemory((IntPtr)allocPtr);
		}

		foreach(var allocPtr in vars.sELSDetFuncPtrs)
		{
			game.FreeMemory((IntPtr)allocPtr);
		}

		game.FreeMemory((IntPtr)vars.loadingPtr);

		game.Resume();
	}
}

// gameAction (the name comes from the symbol files) values:
	// 0: In every menu (main, paused, inventory, exit game etc.), in-game, during conversations, during cutscenes, during the intro FMVs before the menu, and during the Karel reveal FMV.
	// 1: After pressing New Game, during the FMV and during the loading screen following the FMV.
	// 2: During savegame loads.
	// 3: During the FMV at the end of Siege, during loads which are after a level's EoL trigger, and during the fadeouts after activating an EoL trigger with Lara or Kurtis.
	// 4: During exiting to the main menu.
	// 5: During loads after cutscene levels.
	// 6: Cutscene level loads and during the fadeouts before cutscenes.
	// 7: During the fadeout leading up to conversations.
	// 8: Just before the inventory shows up.
	// 9: Unknown (searching for MOV [gameAction], 9's bytecode in CE shows no results).
	// 10: Just before the Paused menu shows up.
	// 11: Just before the Game Over menu shows up.
	// 12: Just before the inventory screen shows up when you sell items to Rennes.
