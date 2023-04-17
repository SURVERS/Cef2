/*
	Данный сервер создавался, для портфолио, и для резюме чтобы выслать его в компанию ARIZONA GAMES
	Автор: by SURVERS FAMILY (EMAIL: gumballfamilytop@gmail.com VK: vk.com/vladkorobov)
*/

#include <a_samp>
#include <Pawn.CMD>
#include <sscanf2>
#include <cef>
#include <streamer>

#define SCM SendClientMessage

#define COLOR_SUCCESS 0x41EB4CFF
#define COLOR_ERROR 0xEB4C42FF

#define MAX_BOTTLES 		(109)       // Максимальное количество бутылок
main(){}

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward GivePlayerBottles(playerid);
forward UpdateBottles();
// -------------------- | Таймеры | -------------------- //
new PlayerTimerBottler[MAX_PLAYERS];
// -------------------- | URL Для браузера | -------------------- //
new URL_Progress[27 + 1] = "http://wh225.web1.bhweb.ru/";
// -------------------- | Переменные | -------------------- //
new Bottles[MAX_BOTTLES];
new Text3D:Bottles3DText[MAX_BOTTLES];
enum bottlesenums{
	bool:bBottlesActive,
	Float:bBottlesX,
	Float:bBottlesY,
	Float:bBottlesZ
}
new BottlesInfo[][bottlesenums] = {
	{true, 1948.547729, -2045.651611, 12.836882},
	{true, 1894.676147, -2035.131103, 12.836878},
	{true, 1895.522338, -2040.412353, 12.856881},
	{true, 1873.156982, -2007.804687, 12.826876},
	{true, 1898.168090, -1991.875488, 12.836873},
	{true, 1898.487060, -1995.761962, 12.836873},
	{true, 1883.294555, -1939.292846, 12.842846},
	{true, 1883.294555, -1940.963500, 12.842846},
	{true, 1854.727905, -1918.057617, 14.265438},
	{true, 1904.931030, -1924.346679, 12.856877},
	{true, 1935.206542, -1901.785278, 14.311799},
	{true, 1936.524902, -1900.558715, 14.311799},
	{true, 1968.423461, -1844.090698, 12.836880},
	{true, 1949.045654, -1801.877685, 12.816876},
	{true, 1897.862304, -1824.041015, 3.194374},
	{true, 1897.862304, -1825.250854, 3.274374},
	{true, 1902.249511, -1825.850708, 3.284374},
	{true, 1828.606079, -1822.503173, 12.878463},
	{true, 1828.606079, -1823.663452, 12.878463},
	{true, 1802.966308, -1846.850708, 12.858127},
	{true, 1813.136230, -1759.255249, 12.786876},
	{true, 1839.256835, -1738.426025, 12.652092},
	{true, 1839.256835, -1739.476806, 12.652092},
	{true, 1837.846313, -1739.382202, 12.652092},
	{true, 1876.509399, -1744.806396, 12.826876},
	{true, 1911.665405, -1768.446289, 12.672819},
	{true, 1975.286010, -1783.291625, 12.843681},
	{true, 1975.945190, -1785.571411, 12.843681},
	{true, 1983.804321, -1759.906005, 12.826881},
	{true, 1979.812744, -1732.835937, 15.258756},
	{true, 1975.132934, -1733.886230, 15.258756},
	{true, 1979.040649, -1737.224487, 15.258756},
	{true, 2013.403320, -1713.854614, 12.846878},
	{true, 2018.207885, -1740.409301, 12.846878},
	{true, 2043.894042, -1728.123901, 12.836875},
	{true, 2043.894042, -1724.644165, 12.836875},
	{true, 2040.474975, -1727.413574, 12.836875},
	{true, 2041.548828, -1735.127441, 12.836875},
	{true, 2054.177734, -1732.863891, 12.836877},
	{true, 2074.017578, -1725.206665, 12.846880},
	{true, 2067.787353, -1697.765625, 12.836879},
	{true, 2061.779296, -1685.377807, 12.836878},
	{true, 2073.657714, -1639.532836, 12.836876},
	{true, 2062.362304, -1619.754638, 12.836879},
	{true, 2039.839111, -1629.925781, 12.856880},
	{true, 2040.264526, -1631.607177, 12.856880},
	{true, 2032.215576, -1581.635009, 11.728933},
	{true, 2058.036132, -1604.149291, 12.746876},
	{true, 2105.804687, -1605.149169, 12.781026},
	{true, 2105.804687, -1606.279296, 12.781026},
	{true, 2126.683105, -1593.180297, 13.661567},
	{true, 2159.773925, -1614.168579, 13.563378},
	{true, 2180.687011, -1630.902954, 14.283645},
	{true, 2154.705322, -1659.689941, 14.375942},
	{true, 2154.705322, -1662.700317, 14.375942},
	{true, 2195.355957, -1685.408569, 13.254843},
	{true, 2208.721435, -1709.806640, 12.753155},
	{true, 2162.411621, -1727.366821, 12.790149},
	{true, 2157.792724, -1725.425292, 12.790149},
	{true, 2176.797607, -1761.276855, 12.836878},
	{true, 2126.934570, -1760.326416, 12.912505},
	{true, 2180.732421, -1916.239624, 12.787790},
	{true, 2271.694091, -1883.755981, 13.506882},
	{true, 2283.565673, -1877.541503, 13.534378},
	{true, 2293.249267, -1912.019042, 12.796874},
	{true, 2289.871582, -1935.403930, 12.836809},
	{true, 2245.703613, -1941.601318, 12.858914},
	{true, 2231.243896, -1930.886352, 12.816880},
	{true, 2280.222412, -1979.611572, 12.796187},
	{true, 2315.815673, -1988.164672, 12.887989},
	{true, 2313.736083, -1989.807006, 12.887989},
	{true, 2327.633789, -2002.781616, 15.309075},
	{true, 2337.549804, -2008.205444, 12.846883},
	{true, 2388.686279, -1978.897216, 12.806878},
	{true, 2406.034912, -1944.773559, 12.776872},
	{true, 2421.679199, -1887.664428, 12.806879},
	{true, 2373.763671, -1828.593750, 8.573440},
	{true, 2381.977050, -1838.285034, 0.938714},
	{true, 2224.949951, -1823.760742, 12.851336},
	{true, 2237.250732, -1635.589843, 14.989688},
	{true, 2245.161132, -1648.437744, 14.728892},
	{true, 2287.386474, -1678.425292, 13.664058},
	{true, 2278.678466, -1646.396972, 14.598209},
	{true, 2328.784667, -1666.055053, 13.130467},
	{true, 2364.774169, -1650.880981, 12.846881},
	{true, 2377.879638, -1639.281494, 12.819024},
	{true, 2374.395019, -1644.394287, 12.819024},
	{true, 2372.934570, -1640.214477, 12.819024},
	{true, 2415.472656, -1652.148681, 12.783245},
	{true, 2442.736083, -1669.606567, 12.783212},
	{true, 2474.385009, -1651.083740, 12.768754},
	{true, 2475.909423, -1651.711547, 12.768754},
	{true, 2493.345214, -1646.840454, 12.776597},
	{true, 2505.805175, -1649.765258, 13.060637},
	{true, 2512.387451, -1667.738891, 12.859413},
	{true, 2512.151123, -1686.884765, 12.859473},
	{true, 2479.852783, -1699.792968, 12.787016},
	{true, 2472.223144, -1714.358398, 12.797608},
	{true, 2456.498779, -1739.030639, 12.920475},
	{true, 2397.770019, -1721.924682, 12.880596},
	{true, 2382.546630, -1717.359741, 12.873986},
	{true, 2425.230712, -1771.147583, 12.836880},
	{true, 2531.783935, -1810.054809, 12.796879},
	{true, 2541.155517, -1742.710327, 12.856879},
	{true, 2543.638916, -1705.810546, 12.651976},
	{true, 2345.051757, -1743.466674, 12.846880},
	{true, 2276.316894, -1756.610229, 12.836879},
	{true, 2253.060302, -1784.756958, 12.816881},
	{true, 2269.173095, -1820.173339, 12.856880}
};

enum pInfo{
	pName[MAX_PLAYER_NAME],
	pMoney
}
new PI[MAX_PLAYERS][pInfo];
public OnGameModeInit()
{
 	LoadBottles(); // Загружает бутылки по всему штату Los Santos
	
	SetGameModeText("SURVERS RP");
	AddPlayerClass(0, 1654.3615,-1837.7924,13.5465,0.7620, 0, 0, 0, 0, 0, 0);
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);

	return 1;
}
public OnPlayerConnect(playerid){
	SendClientMessage(playerid, 0x41EB4CFF, "[Информация]: {FFFFFF}Данный сервер создавался, для портфолио, и для резюме чтобы выслать его в компанию ARIZONA GAMES");
	SendClientMessage(playerid, 0x41EB4CFF, "[Информация]: {FFFFFF}Автор: by SURVERS FAMILY (EMAIL: gumballfamilytop@gmail.com VK: vk.com/vladkorobov)");
	SendClientMessage(playerid, 0x41EB4CFF, "[Информация]: {FFFFFF}Добро пожаловать.");
	return SpawnPlayer(playerid);
}
public OnPlayerDisconnect(playerid, reason){
	ClearUserInfo(playerid);
}
public OnPlayerRequestSpawn(playerid) return 1;
public OnGameModeExit() return 1;
public OnPlayerSpawn(playerid) return PreloadAllAnimLibs(playerid);
public OnPlayerDeath(playerid, killerid, reason) return 1;
public OnVehicleSpawn(vehicleid) return 1;
public OnVehicleDeath(vehicleid, killerid) return 1;
public OnPlayerText(playerid, text[]) return 1;
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) return 1;
public OnPlayerExitVehicle(playerid, vehicleid) return 1;
public OnPlayerStateChange(playerid, newstate, oldstate) return 1;
public OnPlayerEnterCheckpoint(playerid) return 1;
public OnPlayerLeaveCheckpoint(playerid) return 1;
public OnPlayerEnterRaceCheckpoint(playerid) return 1;
public OnPlayerLeaveRaceCheckpoint(playerid) return 1;
public OnObjectMoved(objectid) return 1;
public OnPlayerObjectMoved(playerid, objectid) return 1;
public OnPlayerPickUpPickup(playerid, pickupid) return 1;
public OnVehicleMod(playerid, vehicleid, componentid) return 1;
public OnVehiclePaintjob(playerid, vehicleid, paintjobid) return 1;
public OnVehicleRespray(playerid, vehicleid, color1, color2) return 1;
public OnPlayerSelectedMenuRow(playerid, row) return 1;
public OnPlayerExitedMenu(playerid) return 1;
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) return 1;
public OnRconLoginAttempt(ip[], password[], success) return 1;
public OnPlayerUpdate(playerid) return 1;
public OnPlayerStreamIn(playerid, forplayerid) return 1;
public OnPlayerStreamOut(playerid, forplayerid) return 1;
public OnVehicleStreamIn(vehicleid, forplayerid) return 1;
public OnVehicleStreamOut(vehicleid, forplayerid) return 1;
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) return SetPlayerPos(playerid, fX, fY, fZ);
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	switch(dialogid){
	    case 1:{
	        if(!response) return 1;
			if(GetPVarInt(playerid, "BottlesPlayer") == 0) return 1; // Если бутылок у игрока не найдено, то действие отменяется
			GiveMoney(playerid, GetPVarInt(playerid, "BottlesPlayer") * 100); // Выдаём количество денег за бутылки
			DeletePVar(playerid, "BottlesPlayer"); // Удаляем все собранные бутылки у игрока
			// Рандомное сообщение которое отправится игроку, после успешной продажи
			switch(random(3)){
			    case 0: SCM(playerid, 0xCCCCCCFF, "[Джо]: Спасибо друг, за бутылки, удачи :3");
			    case 1: SCM(playerid, 0xCCCCCCFF, "[Джо]: На, держи денюжку!");
				default: SCM(playerid, 0xCCCCCCFF, "[Джо]: Удачи!");
			}
	    }
	}
	return 1;
}
public UpdateBottles(){
    for(new i; i < MAX_BOTTLES; i++){
        if(BottlesInfo[i][bBottlesActive] == true) continue;
        BottlesInfo[i][bBottlesActive] = true;
   	    Bottles[i] = CreateDynamicObject(3119, BottlesInfo[i][bBottlesX], BottlesInfo[i][bBottlesY], BottlesInfo[i][bBottlesZ], 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
        Bottles3DText[i] = CreateDynamic3DTextLabel("Две бутылки\nНажмите [ {EB4C42}ALT{FFFFFF} ] чтобы подобрать их", 0xFFFFFFFF, BottlesInfo[i][bBottlesX], BottlesInfo[i][bBottlesY], BottlesInfo[i][bBottlesZ], 20);
    }
    return 1;
}
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return 1;
	}
	return 0;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys == KEY_WALK){
		for(new i; i < MAX_BOTTLES; i++){
		    if(PlayerToPoint(1.0, playerid, BottlesInfo[i][bBottlesX], BottlesInfo[i][bBottlesY], BottlesInfo[i][bBottlesZ])){
				if(BottlesInfo[i][bBottlesActive] == false || GetPVarInt(playerid, "IDBottle") == i) return 1; // Если данного объекта нету, или же игрок уже собирает бутылки, то действие не будет выполнено
				if(GetPVarInt(playerid, "BottlesPlayer") == 10) return SCM(playerid, COLOR_ERROR, "[Ошибка]: {FFFFFF}Нехватает мест для бутылок, продайте все бутылки Джо!"); // Проверка
				SetPVarInt(playerid, "IDBottle", i); // Устанавливаем ID объекта, чтобы в дальнейшем удалить объект
				cef_create_browser(playerid, 1, URL_Progress, false, false); // Создаём прогресс бар
				TogglePlayerControllable(playerid, false); // Отключаем доступ к управлению персонажа
				PlayerTimerBottler[playerid] = SetTimerEx("GivePlayerBottles", 5500, false, "d", playerid); // Через 5.5 секунд, персонаж подберёт бутылки
				ApplyAnimation(playerid, !"BOMBER", !"BOM_Plant", 4.0, true, 1, 0, 0, 0, 1); // Включаем анимацию
				break; // Break нужен чтобы случайно два объекта за раз не собрать
		    }
		}
		if(PlayerToPoint(1.0, playerid, -97.5865,-302.7859,1.4297)){
			new string_dialog[256];
			if(GetPVarInt(playerid, "InitialInformation") == 0)
		    	SCM(playerid, 0xCCCCCCFF, "[Джо]: Привет, меня зовут Джо, я скупаю у граждан бутылки, для завода...");
			else
				SCM(playerid, 0xCCCCCCFF, "[Джо]: Привет, ещё раз, ты пришёл продать мне бутылки?");
		    SCM(playerid, 0xCCCCCCFF, "[Джо]: Стоимость одной бутылки - 100$.");
		    SetPVarInt(playerid, "InitialInformation", 1);
		    if(GetPVarInt(playerid, "BottlesPlayer") > 0){
		    	format(string_dialog, sizeof(string_dialog), "{FFFFFF}Вы уверены что хотите продать {EB4C42}%d {FFFFFF}бутылок за {EB4C42}%d$?", GetPVarInt(playerid, "BottlesPlayer"), 100 * GetPVarInt(playerid, "BottlesPlayer"));
		    	ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "{FFFFFF}Продажа бутылок || {EB4C42}Джо", string_dialog, "Далее", "Закрыть");
			}
			else
			    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "{FFFFFF}Продажа бутылок || {EB4C42}Джо", "{FFFFFF}У вас нету бутылок, собрать их можно в городе Los-Santos.", "Закрыть", "");
		}
	}
	return true;
}
public GivePlayerBottles(playerid){
    new str[83];
    BottlesInfo[GetPVarInt(playerid, "IDBottle")][bBottlesActive] = false;  // Даём статус данному объекту false, чтобы в будующем никто не мог по новой собрать две бутылки, пока они не зареспавнятся
	SetPVarInt(playerid, "BottlesPlayer", GetPVarInt(playerid, "BottlesPlayer") + 2); // Даём игроку +2 бутылки
	DestroyDynamicObject(Bottles[GetPVarInt(playerid, "IDBottle")]); // Удаляем объект с сервера
	DestroyDynamic3DTextLabel(Bottles3DText[GetPVarInt(playerid, "IDBottle")]); // Удаляем 3D Text возле объекта с бутылками
	DeletePVar(playerid, "IDBottle"); // Удаляем ID объекта, который игрок поднял
	TogglePlayerControllable(playerid, true); // Даём разморозку игроку, чтобы он мог двигаться
	cef_destroy_browser(playerid, 1); // Удаляем браузер
	format(str, sizeof(str), "[Информация]: {FFFFFF}Вы подобрали две бутылки. Всего вы собрали %d из 10 бутылок", GetPVarInt(playerid, "BottlesPlayer"));
	SCM(playerid, COLOR_SUCCESS, str);
	return SCM(playerid, COLOR_SUCCESS, "[Информация]: {FFFFFF}Чтобы продать бутылки, вы должны отнести их Джо, он находится возле входа в завод");
}

stock GiveMoney(playerid, value){
	PI[playerid][pMoney] += value;
	return GivePlayerMoney(playerid, value);
}
stock ClearUserInfo(playerid){
	PI[playerid][pMoney] = 0;

	return KillTimer(PlayerTimerBottler[playerid]);
}
stock LoadBottles(){
	for(new i; i < MAX_BOTTLES; i++){
	    Bottles[i] = CreateDynamicObject(3119, BottlesInfo[i][bBottlesX], BottlesInfo[i][bBottlesY], BottlesInfo[i][bBottlesZ], 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
        Bottles3DText[i] = CreateDynamic3DTextLabel("Две бутылки\nНажмите [ {EB4C42}ALT{FFFFFF} ] чтобы подобрать их", 0xFFFFFFFF, BottlesInfo[i][bBottlesX], BottlesInfo[i][bBottlesY], BottlesInfo[i][bBottlesZ], 20);
	}
	SetTimer("UpdateBottles", 3600 * 1000, true);
	CreateActor(6, -97.5865,-302.7859,1.4297,140.6158); // Джо
	CreateDynamic3DTextLabel("{EB4C42}Джо\n{FFFFFF}Нажмите [ {EB4C42}ALT{FFFFFF} ] чтобы продать бутылки\n\n{CCCCCC}Покупатель бутылок", 0xFFFFFFFF, -97.5865,-302.7859,1.4297, 20);
	return printf("[Load System]: LoadBottles загрузил %d бутылок.", MAX_BOTTLES);
}
stock PreloadAnimLib(playerid, animlib[]) return ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
stock PreloadAllAnimLibs(playerid)
{
    PreloadAnimLib(playerid, !"BOMBER");
    PreloadAnimLib(playerid, !"RAPPING");
    PreloadAnimLib(playerid, !"SHOP");
    PreloadAnimLib(playerid, !"BEACH");
    PreloadAnimLib(playerid, !"SMOKING");
    PreloadAnimLib(playerid, !"FOOD");
    PreloadAnimLib(playerid, !"ON_LOOKERS");
    PreloadAnimLib(playerid, !"DEALER");
    PreloadAnimLib(playerid, !"CRACK");
    PreloadAnimLib(playerid, !"CARRY");
    PreloadAnimLib(playerid, !"COP_AMBIENT");
    PreloadAnimLib(playerid, !"PARK");
    PreloadAnimLib(playerid, !"INT_HOUSE");
    PreloadAnimLib(playerid, !"FOOD");
    PreloadAnimLib(playerid, !"CRIB");
    PreloadAnimLib(playerid, !"ROB_BANK");
    PreloadAnimLib(playerid, !"JST_BUISNESS");
    PreloadAnimLib(playerid, !"PED");
    PreloadAnimLib(playerid, !"OTB");
    PreloadAnimLib(playerid, !"SCRATCHING");
    PreloadAnimLib(playerid, !"BSKTBALL");
    return PreloadAnimLib(playerid, !"CASINO");
}
