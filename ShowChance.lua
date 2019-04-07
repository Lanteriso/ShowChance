ShowChance_UpdateInterval = 1.0; -- how often to update the info

-- init variables
playerClass, englishClass = UnitClass("player");
if not LD_iCurrent then
	LD_iCurrent = 1
end
if not LD_iCurrent2 then
	LD_iCurrent2 = 1
end
if not LD_iCurrent3 then
	LD_iCurrent3 = 28
end
if not LD_iCurrent4 then
	LD_iCurrent4 = 28
end
if not RecordHigh then
	RecordHigh = {[1] = 0, [2] = 0}
end


skillTable = {
	[1]="unused", --Weapon Skill
	[2]="unused", --Defense
	[3]="躲闪",
	[4]="招架",
	[5]="格挡",
	[6]="Melee Hit",
	[7]="Ranged Hit",
	[8]="Spell Hit",
	[9]="Melee 爆击",
	[10]="Ranged 爆击",
	[11]="Spell 爆击",
	[12]="Mana 法力回复",
	[13]="精通",
	[14]="unused", --CR_HIT_TAKEN_SPELL 
	[15]="PvP Resilience",--"Melee Resilience", --COMBAT_RATING_RESILIENCE_CRIT_TAKEN 
	[16]="unused",--"Ranged Resilience", --COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN 
	[17]="unused", --"Spell Resilience", --CR_CRIT_TAKEN_SPELL 
	[18]="Melee 急速",
	[19]="Ranged 急速",
	[20]="Spell 急速",
	[21]="unused", --Mainhand Skill
	[22]="unused", --Offhand Skill
	[23]="unused", --Ranged Skill
	[24]="Expertise",
	[25]="Armor Penetration",
	[26]="unused",--CR_MASTERY
	[27]="PvP Power",

	[28]="爆击",
	[29]="急速",
	[30]="精通"
}

-- OnLoad event
function ShowChance_OnLoad()
  ChatFrame1:AddMessage("+ |cFFFF0000ShowChance |开启.");
end

-- Config Panel Code
 MyAddon = {};
 MyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
 -- Register in the Interface Addon Options GUI
 -- Set the name for the Category for the Options Panel
 MyAddon.panel.name = "ShowChance";
 -- Add the panel to the Interface Options
 --InterfaceOptions_AddCategory(MyAddon.panel);
 
 function LiveDamagConfig_Frame_OnShow()
	-- read settings from profile, and change our checkbuttons and slider to represent them
 -- 	getglobal(this:GetName().."CheckButtonOn"):SetChecked( myClockConfig[myClockRealm][myClockChar].on );
 -- 	getglobal(this:GetName().."CheckButtonTime24"):SetChecked( myClockConfig[myClockRealm][myClockChar].time24 );		
 -- 	getglobal(this:GetName().."SliderOffset"):SetValue( myClockConfig[myClockRealm].offset );
 end
 

function ShowChance_OnUpdate(self, elapsed)

	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;


--	if PlayerSettings then
--		for index,value in pairs(PlayerSettings) do 
--			
--		end
--	end


	if (self.TimeSinceLastUpdate > ShowChance_UpdateInterval) then
		--jany3
		janycoloredText={};
		if not janyRecordHigh then
			janyRecordHigh = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0}
		end
		if(LD_iCurrent3 == 28) then
			N =UnitName("player")
			IL_C = {GetAverageItemLevel()}
			IL = "物品等级"..string.format("%.1f", IL_C[2])		--	物品等级
					
			S_C = UnitStat("player",1)							-- 力量
			AG_C = UnitStat("player",2)							-- 敏捷
			IN_C = UnitStat("player",4)							-- 智力
			if S_C > AG_C and S_C > IN_C then
				if (S_C> janyRecordHigh[1]) then
					janyRecordHigh[1] = S_C;
					janycoloredText[1] = "|cFF00FF00";
				elseif (S_C< janyRecordHigh[1]) then
					janyRecordHigh[1] = S_C;
					janycoloredText[1] = "|cFFFF0000";
				else
					janyRecordHigh[1] = S_C;
					janycoloredText[1] = "";
				end
				S = "力量"..janycoloredText[1]..S_C
			elseif AG_C > S_C and AG_C > IN_C then
				if (AG_C> janyRecordHigh[1]) then
					janyRecordHigh[1] = AG_C;
					janycoloredText[1] = "|cFF00FF00";
				elseif (AG_C< janyRecordHigh[1]) then
					janyRecordHigh[1] = AG_C;
					janycoloredText[1] = "|cFFFF0000";
				else
					janyRecordHigh[1] = AG_C;
					janycoloredText[1] = "";
				end
				S = "敏捷"..janycoloredText[1]..AG_C
			elseif IN_C > S_C and IN_C > AG_C then
				if (IN_C> janyRecordHigh[1]) then
					janyRecordHigh[1] = IN_C;
					janycoloredText[1] = "|cFF00FF00";
				elseif (IN_C< janyRecordHigh[1]) then
					janyRecordHigh[1] = IN_C;
					janycoloredText[1] = "|cFFFF0000";
				else
					janyRecordHigh[1] = IN_C;
					janycoloredText[1] = "";
				end
				S = "智力"..janycoloredText[1]..IN_C
			end
			A_C = {UnitArmor("player")}
			if (A_C[2]> janyRecordHigh[2]) then
				janyRecordHigh[2] = A_C[2];
				janycoloredText[2] = "|cFF00FF00";
			elseif (A_C[2]< janyRecordHigh[2]) then
				janyRecordHigh[2] = A_C[2];
				janycoloredText[2] = "|cFFFF0000";
			else
				janyRecordHigh[2] = A_C[2];
				janycoloredText[2] = "";
			end
			A = "护甲"..janycoloredText[2]..A_C[2]

			if (GetCritChance()> janyRecordHigh[3]) then
				janyRecordHigh[3] = GetCritChance();
				janycoloredText[3] = "|cFF00FF00";
			elseif (GetCritChance()< janyRecordHigh[3]) then
				janyRecordHigh[3] = GetCritChance();
				janycoloredText[3] = "|cFFFF0000";
			else
				janyRecordHigh[3] = GetCritChance();
				janycoloredText[3] = "";
			end
			CC = "暴击"..janycoloredText[3]..string.format("%.1f", GetCritChance()).."%"			--	暴击


			if (GetHaste()> janyRecordHigh[4]) then
				janyRecordHigh[4] = GetHaste();
				janycoloredText[4] = "|cFF00FF00";
			elseif (GetHaste()< janyRecordHigh[4]) then
				janyRecordHigh[4] = GetHaste();
				janycoloredText[4] = "|cFFFF0000";
			else
				janyRecordHigh[4] = GetHaste();
				janycoloredText[4] = "";
			end
			H = "急速"..janycoloredText[4]..string.format("%.1f", GetHaste()).."%"--	 急速
			if (GetMasteryEffect()> janyRecordHigh[5]) then
				janyRecordHigh[5] = GetMasteryEffect();
				janycoloredText[5] = "|cFF00FF00";
			elseif (GetMasteryEffect()< janyRecordHigh[5]) then
				janyRecordHigh[5] = GetMasteryEffect();
				janycoloredText[5] = "|cFFFF0000";
			else
				janyRecordHigh[5] = GetMasteryEffect();
				janycoloredText[5] = "";
			end
			M = "精通"..janycoloredText[5]..string.format("%.1f", GetMasteryEffect()).."%"--	 精通
			V  = " 全能"..string.format("%.1f", GetCombatRatingBonus(29)).."%"			-- 全能
			LS  = " 吸血"..string.format("%.1f", GetCombatRatingBonus(17)).."%"			-- 吸血	
			DC = " 躲闪"..string.format("%.1f", GetDodgeChance()).."%"		--	躲闪
			PC = " 招架"..string.format("%.1f", GetParryChance()).."%"			--	招架
			BC = " 格挡"..string.format("%.1f", GetBlockChance()).."%"			-- 格挡	
			--print(N..IL..S..A..CC..H..M..V..LS..DC..PC..BC)
		end		

	
		-- get the data
		if(LD_iCurrent2 == 1) then
			classtype = "caster";
			line1text = GetSpellBonusDamage(3);
		else
			classtype = "melee";
			base, posBuff, negBuff = UnitAttackPower("player");

			iAttackPower = base + posBuff;
			line1text = iAttackPower;
		end
		if(LD_iCurrent == 9) then
			line2text = numberToPercent(GetCritChance());--爆击
		elseif(LD_iCurrent == 10) then
			line2text = numberToPercent(GetRangedCritChance());
		elseif(LD_iCurrent == 11) then
			line2text = numberToPercent(GetSpellCritChance(3));
		elseif(LD_iCurrent == 12) then
			base, casting = GetManaRegen();
			line2text = floor( (base * 5)  + .5 );
		elseif(LD_iCurrent == 13) then
			line2text = round(GetMastery(), 2);
		elseif(LD_iCurrent == 24) then
			expertise, offhandExpertise = GetExpertise();
			line2text = expertise;
		else
			line2text = GetCombatRating(LD_iCurrent);
		end
--/script ChatFrame1:AddMessage(GetCombatRating(12)
		
		-- format the text for output
		if (classtype == "melee") then
			line1label = "力量: ";
			iRH = 2;
		else
			line1label = "智力: ";
			iRH = 1;
		end

		coloredText = {};
		if (line1text > RecordHigh[iRH]) then

			RecordHigh[iRH] = line1text;
			newRecordMessage = "+ |cFFFF0000ShowChance :: |rNew Highest "..line1label.." |cFFFF7F50"..line1text;
			--ChatFrame1:AddMessage(newRecordMessage);--力晕有新高时
			coloredText[1] = "|cFFFF7F50";
		else

			coloredText[1] = "";
			--DEBUG--ChatFrame1:AddMessage("line1text: "..line1text..", RecordHigh[1]: "..RecordHigh[1]);
		end
		
		line1forOutput = line1label..coloredText[1]..comma_value(line1text);

		
		-- actual output
		--ShowChance_FrameText:SetText(line1forOutput.."\n|r"..skillTable[LD_iCurrent]..": "..comma_value(line2text).."\n|r"..skillTable[LD_iCurrent3]..": "..line3text.."%");
		ShowChance_FrameText:SetText(N.."\n|r"..IL.."\n|r"..S.."\n|r"..A.."\n|r"..CC.."\n|r"..H.."\n|r"..M.."\n|r"..V.."\n|r"..LS.."\n|r"..DC.."\n|r"..PC.."\n|r"..BC);
		-- reset update counter
		self.TimeSinceLastUpdate = 0;
	end --end if updating

end--end ShowChance_OnUpdate()

function numberToPercent(x)
	return format("%.2f%%", x);
end

function ShowChance_flip1()
	if(LD_iCurrent < 27) then
		LD_iCurrent = LD_iCurrent + 1;
		if(skillTable[LD_iCurrent] == "unused") then
			while(skillTable[LD_iCurrent] == "unused") do
				LD_iCurrent = LD_iCurrent + 1;
			end
		end
	else
		LD_iCurrent = 3;
	end
end

function ShowChance_flip2()
	if(LD_iCurrent2 == 2) then
		LD_iCurrent2 = 1;
	else
		LD_iCurrent2 = 2;
	end
end
function ShowChance_flip3()

end


function SetInterval(val)
	ShowChance_UpdateInterval = val / 1000;
end


function showHighScore()--显示高分
	if(LD_iCurrent2 == 1) then
		recordText = "最高法术力量: ";
		iRH = 1;
	else
		recordText = "最高攻击力: ";
		iRH = 2;
	end
	highRecordMessage = "+ |cFFFF0000ShowChance :: |r"..recordText.." |cFFFF7F50"..comma_value(RecordHigh[iRH]);
	ChatFrame1:AddMessage(highRecordMessage);
end

SLASH_ShowChance1, SLASH_ShowChance1 = "/sc", "/ShowChance";
SlashCmdList["ShowChance"] = function(msg, editBox)
--	InterfaceOptionsFrame_OpenToCategory("ShowChance");
	showHighScore();
	print("showHighScore")
end

---============================================================
-- rounds a number to the nearest decimal places
--
function round(val, decimal)
  if (decimal) then
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
  else
    return math.floor(val+0.5)
  end
end

-- add comma to separate thousands
-- 
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end



-- EOF --
