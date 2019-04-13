
local ShowChance = CreateFrame("Frame")
-- 首次登陆加载

local ShowChance_Load = CreateFrame("Frame")
ShowChance_Load:RegisterEvent("ADDON_LOADED")
ShowChance_Load:SetScript("OnEvent", function(_, event, addon)
	if event == "ADDON_LOADED" and addon == "ShowChance" then
		if SFF == nil then SFF = 20 end 

		--设置开关
		if ST_Lock == nil then ST_Lock = false end --锁
		

		

		if ST_InterruptLists == nil then ST_InterruptLists = {} end
		if ST_InterruptLists["玩家名称"] == nil then ST_InterruptLists["玩家名称"] = false end   --玩家名称
		if ST_InterruptLists["装等"] == nil then ST_InterruptLists["装等"] = false end   --装等
		if ST_InterruptLists["项链等级"] == nil then ST_InterruptLists["项链等级"] = false end--项链等级
		if ST_InterruptLists["种族天赋"] == nil then ST_InterruptLists["种族天赋"] = false end--种族天赋
		if ST_InterruptLists["HP"] == nil then ST_InterruptLists["HP"] = false end--血
		if ST_InterruptLists["MP"] == nil then ST_InterruptLists["MP"] = false end--蓝
		if ST_InterruptLists["CB"] == nil then ST_InterruptLists["CB"] = false end--连击点
		if ST_InterruptLists["攻强"] == nil then ST_InterruptLists["攻强"] = false end--攻强
		if ST_InterruptLists["主属性"] == nil then ST_InterruptLists["主属性"] = true end   --主属性
		if ST_InterruptLists["护甲"] == nil then ST_InterruptLists["护甲"] = true end   --护甲
		if ST_InterruptLists["暴击"] == nil then ST_InterruptLists["暴击"] = true end   --暴击
		if ST_InterruptLists["急速"] == nil then ST_InterruptLists["急速"] = true end   --急速
		if ST_InterruptLists["精通"] == nil then ST_InterruptLists["精通"] = true end   --精通
		if ST_InterruptLists["全能"] == nil then ST_InterruptLists["全能"] = false end   --全能
		if ST_InterruptLists["吸血"] == nil then ST_InterruptLists["吸血"] = false end   --吸血
		if ST_InterruptLists["躲闪"] == nil then ST_InterruptLists["躲闪"] = false end   --躲闪
		if ST_InterruptLists["招架"] == nil then ST_InterruptLists["招架"] = false end   --招架
		if ST_InterruptLists["格挡"] == nil then ST_InterruptLists["格挡"] = false end   --格挡
		if ST_InterruptLists["移速"] == nil then ST_InterruptLists["移速"] = true end   --移动速度
		if ST_InterruptLists["攻速"] == nil then ST_InterruptLists["攻速"] = true end   --攻击速度

		--[[
		if ST_TextList == nil then ST_TextList = {} end
		if ST_TextList[1] == nil then ST_TextList[1] = "玩家名称" end   --玩家名称
		if ST_TextList[2] == nil then ST_TextList[2] = "装等" end   --装等
		if ST_TextList[3] == nil then ST_TextList[3] = "主属性" end   --主属性
		if ST_TextList[4] == nil then ST_TextList[4] = "护甲" end   --护甲
		if ST_TextList[5] == nil then ST_TextList[5] = "暴击" end   --暴击
		if ST_TextList[6] == nil then ST_TextList[6] = "急速" end   --急速
		if ST_TextList[7] == nil then ST_TextList[7] = "精通" end   --精通
		if ST_TextList[8] == nil then ST_TextList[8] = "全能" end   --全能
		if ST_TextList[9] == nil then ST_TextList[9] = "吸血" end   --吸血
		if ST_TextList[10] == nil then ST_TextList[10] = "躲闪" end   --躲闪
		if ST_TextList[11] == nil then ST_TextList[11] = "招架" end   --招架
		if ST_TextList[12] == nil then ST_TextList[12] = "格挡" end   --格挡
		if ST_TextList[13] == nil then ST_TextList[13] = "移动速度" end --移动速度
		if ST_TextList[14] == nil then ST_TextList[14] = "攻速" end --移动速度
		]]

		if janycoloredText == nil then janycoloredText={} end
		if janyRecordHigh == nil then janyRecordHigh ={} end

	end
end)
-- 添加设置界面
local ST_Options = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
ST_Options:Hide()
ST_Options.name = "ShowChance"
ST_Options:SetScript("OnShow", function(self)
	if self.show then return end
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(ST_SETTINGS)
	
	local website = self:CreateFontString(nil, "ARTWORK")
	website:SetFont(GameFontNormal:GetFont(), 12)
	website:SetWidth(500)
	website:SetPoint("BOTTOMLEFT", 32, 32)
	website:SetJustifyH("LEFT")
	website:SetText("|cff298F00GitHub:|r:https://github.com/janyroo/ShowChance")
	
	local thanksto = self:CreateFontString(nil, "ARTWORK")
	thanksto:SetFont(GameFontNormal:GetFont(), 20)
	thanksto:SetWidth(500)
	thanksto:SetPoint("BOTTOMLEFT", website, "TOPLEFT", 0, 8)
	thanksto:SetJustifyH("LEFT")
	thanksto:SetText("修改字体大小方法：在聊天框输入例如/sc 30\n|r提示：字体大小默认是20，/sc 字体大小可能随便填")	

	local lockframes = CreateFrame("CheckButton", "ST_Locks", ST_Options, "InterfaceOptionsCheckButtonTemplate")
	lockframes:SetPoint("TOPRIGHT", -132, -52)
	getglobal(lockframes:GetName().."Text"):SetText("开关")
	if ST_Lock == true then 
		lockframes:SetChecked(true) 
	else 
		lockframes:SetChecked(false)

	end
	

	local count,countx=0,0
	for key,value in pairs(ST_InterruptLists) do
		count=count+1
		if count>12 then countx,count=countx+1,0 end
		local button = CreateFrame("CheckButton", "ST_InterruptLists_"..key, ST_Options, "InterfaceOptionsCheckButtonTemplate")
		button:SetPoint("TOPLEFT", 32+150*countx, -32-32*count)
		getglobal(button:GetName().."Text"):SetText(key)
		--print(getglobal(button:GetName().."Text"))
		if value == true then button:SetChecked(true) else button:SetChecked(false) end
	end	
	
	self.show = true
	ST_Options:SetScript("OnHide", function(self)
		if _G["ST_Locks"]:GetChecked() then
			if ST_Lock ~= true then
				

				print("设置: 现在可移动框体")

				
                   			ShowChance_Frame:SetSize(100,100)
                            ShowChance_Frame:EnableMouse(true)
                            ShowChance_Frame:SetMovable(true)
                            ST_Lock = true

				
			end
		else

			if ST_Lock ~= false then
				

				print("设置: 现在不可移动框体")
				
							ShowChance_Frame:SetSize(1,1)
                            ShowChance_Frame:EnableMouse(true)
                            ShowChance_Frame:SetMovable(true)
                            ST_Lock = false


                  
				
			end
		end

		for key,value in pairs(ST_InterruptLists) do
			if _G["ST_InterruptLists_"..key]:GetChecked() then
				if ST_InterruptLists[(key)] ~= true then
					ST_InterruptLists[(key)] = true
					print("设置: "..key.."打开")
					
				end
			else
				if ST_InterruptLists[(key)] ~= false then
					ST_InterruptLists[(key)] = false
					print("设置: "..key.."关闭")
				end
			end
		end
	end)
end)



InterfaceOptions_AddCategory(ST_Options)


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
  ChatFrame1:AddMessage("|cFFFF0000【ShowChance】属性显示已开启,祝你波波有爆发,天天出泰坦.");

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
--JANY进入战斗离开战斗
ShowChance:RegisterEvent("PLAYER_REGEN_DISABLED")
ShowChance:RegisterEvent("PLAYER_REGEN_ENABLED")   
ShowChance:SetScript("OnEvent", function (self,event)
	if event == "PLAYER_REGEN_ENABLED" then
		ShowChance_UpdateInterval = 1.0--没进战斗刷新频率
		UIFrameFadeOut(ShowChance_FrameText, 2, 1, 0.5)--淡入
	elseif event == "PLAYER_REGEN_DISABLED" then
		ShowChance_UpdateInterval = 1.0--进战斗刷新频率
		UIFrameFadeOut(ShowChance_FrameText, 2, 0.5, 1)--淡入
				
	end	
end);

local function StatReport_TalentData() --获取天赋
	local curT = GetSpecialization() 
	local tname,duties 
	if curT then
		_, tname, _, _, duties = GetSpecializationInfo(curT)
	end
	local TalentStat = duties and _G[duties];

	return tname, TalentStat;
end 
local function GetAzeriteLevel()--项链等级
	local level
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		level = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	else
		level = 0
	end
	return level
end	
function ShowChance_GetColor(janydatacontrast,janyserialnumber)
	if janycoloredText[janyserialnumber] == nil then janycoloredText[janyserialnumber]="|cFFFFFFFF" end

	if janyRecordHigh[janyserialnumber] then
		if (janydatacontrast>janyRecordHigh[janyserialnumber]) then
			janyRecordHigh[janyserialnumber] = janydatacontrast;
			janycoloredText[janyserialnumber] = "|cFF00FF00";
		elseif (janydatacontrast<janyRecordHigh[janyserialnumber]) then
			janyRecordHigh[janyserialnumber] = janydatacontrast;
			janycoloredText[janyserialnumber] = "|cFFFF0000";
		else
			janyRecordHigh[janyserialnumber] = janydatacontrast;
			janycoloredText[janyserialnumber] = "|cFFFFFFFF";
		end
	else
		janyRecordHigh[janyserialnumber] = janydatacontrast;
	end

	return janycoloredText[janyserialnumber]
end

function ShowChance_OnUpdate(self, elapsed,event)

	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;


--	if PlayerSettings then
--		for index,value in pairs(PlayerSettings) do 
--			
--		end
--	end

	if (self.TimeSinceLastUpdate > ShowChance_UpdateInterval) then

		if(LD_iCurrent3 == 28) then
			if ST_InterruptLists["玩家名称"] then
				N =UnitName("player").."\n|r"
			else
				N =""
			end
			
			if ST_InterruptLists["装等"] then
				IL_C = {GetAverageItemLevel()}
				IL = "物品等级 "..string.format("%.1f", IL_C[2]).."\n|r"		--	物品等级
			else
				IL = ""
			end	

			if ST_InterruptLists["项链等级"] then

				AL = "项链等级 "..string.format("%.1f", GetAzeriteLevel()).."\n|r"		--	物品等级
			else
				AL = ""
			end	
			if ST_InterruptLists["种族天赋"] then

				TF = "种族天赋 "..UnitRace("player",1)..StatReport_TalentData(1).."\n|r"		--	种族天赋
			else
				TF = ""
			end	
			if ST_InterruptLists["HP"] then
				HP = "HP  "..ShowChance_GetColor(UnitHealthMax("player"),"HP")..UnitHealthMax("player").."\n|r" 
			else
				HP =""
			end
			if ST_InterruptLists["MP"] then
				MP = "MP  "..ShowChance_GetColor(UnitPower("player"),"MP").. UnitPower("player").."\n|r" 
			else
				MP =""
			end
			if ST_InterruptLists["CB"] then
				CB = "CB  "..ShowChance_GetColor(UnitPower("player", 4),"CB")..UnitPower("player", 4).."\n|r" 
			else
				CB =""
			end
			if ST_InterruptLists["攻强"] then	
				base, posBuff, negBuff = UnitAttackPower("player");
				effectiveA = base + posBuff + negBuff;
				effectiveB = GetSpellBonusDamage(2);
				effectiveC = GetSpellBonusHealing();
				if effectiveA > effectiveB and effectiveA > effectiveC then
					GQ = "攻强 "..ShowChance_GetColor(effectiveA,"攻强")..effectiveA.."\n|r"
				elseif effectiveB >= effectiveA and effectiveB >= effectiveC then
					GQ = "法强 "..ShowChance_GetColor(effectiveB,"攻强")..effectiveB.."\n|r"
				else
					GQ = "奶强 "..ShowChance_GetColor(effectiveC,"攻强")..effectiveC.."\n|r"
				end
			else
				GQ = ""
			end
			if ST_InterruptLists["主属性"] then	
				S_C = UnitStat("player",1)							-- 力量
				AG_C = UnitStat("player",2)							-- 敏捷
				IN_C = UnitStat("player",4)							-- 智力
				if S_C > AG_C and S_C > IN_C then
					S = "力量 "..ShowChance_GetColor(S_C,"力量")..S_C.."\n|r"
				elseif AG_C > S_C and AG_C > IN_C then
					S = "敏捷 "..ShowChance_GetColor(AG_C,"敏捷")..AG_C.."\n|r"
				elseif IN_C > S_C and IN_C > AG_C then
					S = "智力 "..ShowChance_GetColor(IN_C,"智力")..IN_C.."\n|r"
				end
			else
				S = ""
			end
			if ST_InterruptLists["护甲"] then	
				A_C = {UnitArmor("player")}
				A = "护甲 "..ShowChance_GetColor(A_C[2],"护甲")..A_C[2].."\n|r"
			else
				A = ""
			end
			

			if ST_InterruptLists["暴击"] then 
				CC = "暴击 "..ShowChance_GetColor(GetCritChance(),"暴击")..string.format("%.1f", GetCritChance()).."%\n|r" 
			else
				CC =""
			end

			if ST_InterruptLists["急速"] then
				H = "急速 "..ShowChance_GetColor(GetHaste(),"急速")..string.format("%.1f", GetHaste()).."%\n|r" --	 急速
			else
				H = ""
			end
			if ST_InterruptLists["精通"] then
				M = "精通 "..ShowChance_GetColor(GetMasteryEffect(),"精通")..string.format("%.1f", GetMasteryEffect()).."%\n|r" --	 精通
			else
				M = ""
			end
				
			if ST_InterruptLists["全能"] then
				V  = "全能 "..ShowChance_GetColor(GetCombatRatingBonus(29),"全能")..string.format("%.1f", GetCombatRatingBonus(29)).."%\n|r"			-- 全能
			else
				V = ""
			end
			if ST_InterruptLists["吸血"] then
				LS  = "吸血 "..ShowChance_GetColor(GetCombatRatingBonus(17),"吸血")..string.format("%.1f", GetCombatRatingBonus(17)).."%\n|r"			-- 吸血	

			else
				LS =""
			end
			if ST_InterruptLists["躲闪"] then
				DC = "躲闪 "..ShowChance_GetColor(GetDodgeChance(),"躲闪")..string.format("%.1f", GetDodgeChance()).."%\n|r"		--	躲闪
			else
				DC = ""
			end
			if ST_InterruptLists["招架"] then
				PC = "招架 "..ShowChance_GetColor(GetParryChance(),"招架")..string.format("%.1f", GetParryChance()).."%\n|r"		--	招架
			else
				PC =""
			end

			if ST_InterruptLists["格挡"] then
				BC = "格挡 "..ShowChance_GetColor(GetBlockChance(),"格挡")..string.format("%.1f", GetBlockChance()).."%\n|r"			-- 格挡	
			else
				BC = ""
			end

			if ST_InterruptLists["移速"] then
				MS = "移速 "..ShowChance_GetColor(GetUnitSpeed("player",1),"移速")..string.format("%.1f", GetUnitSpeed("player",1)).."m/s\n|r" --移动速度
			else
				MS = ""
			end

			if ST_InterruptLists["攻速"] then
				GS = "攻速 "..ShowChance_GetColor(UnitAttackSpeed("player",1),"攻速")..string.format("%.1f", UnitAttackSpeed("player",1)).."/s\n|r" --攻速
			else
				GS = ""
			end

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


		ShowChance_FrameText:SetJustifyH("LEFT")
		ShowChance_FrameText:SetFont(GameFontNormal:GetFont(), SFF)
		ShowChance_FrameText:SetText(N..IL..AL..TF..HP..MP..CB..GQ..S..A..CC..H..M..V..LS..DC..PC..BC..MS..GS);
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
	--showHighScore();
		hendlers(msg);
		
end

function hendlers(msg, ... )--命令行
	msg=msg:lower()
	local command, rest = msg:match("^(%S*)%s*(.-)$")
	if command == msg then
		SFF = msg
		ShowChance_FrameText:SetFont(GameFontNormal:GetFont(), SFF)
        print("大小"..SFF)
	elseif command=="lock" then

        print("锁定框体")
	elseif command=="unlock" then

        print("解锁框体")
    else
    	print("/sc 数字\n|r","/sc lock\n|r","/sc unlock")
	end
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


UIFrameFadeOut(ShowChance_FrameText, 1, 0.2, 0.8)

