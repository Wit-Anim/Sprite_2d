pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--main--
function _init()
	klatki = 0
gracz()
wrog()
pocisk()
anim_src()
end

function _update()
	if p.koniec == true then
		koniec()
	end

	klatki+=1
if p.wcisniety == true and p.koniec == false then
	if czyflaga(p.x,p.y,5) then
ruch()
end
if czyflaga(p.x,p.y,2)then
ruch_platf()
end
if czyflaga(p.x,p.y,1)then
	cls(2)
	ruch_skok()
end
end
flagi()
ruch_pocisku()

if(p.zycia==0)then
p.dead=true
end

if(p.dead)then
	p.sprite=20
end
opadanie()
end

function _draw()


		if(btnp(🅾️))then
			p.wcisniety = true
		end
	if p.wcisniety == false then
intro()
	else
	if czysprite(p.x,p.y,26)then
cls(1)
elseif czysprite(p.x,p.y,25)then
cls(1)
elseif czysprite(p.x,p.y,107)then
	cls(3)
end

rysuj_mape()
if(po.kierunek!="") then
spr(po.sprite,po.x,po.y)
end
portal()
if p.dead == false then
animuj_gracza()
end
animacje()
dialogi()

--eq zawsze na koncu zeby rysowalo na wierzchu
eq()
end
end

-->8
--MAPA--
function rysuj_mape()
mapx=(p.x -60)
mapy=(p.y -60)
	camera(mapx,mapy)
map(0,0,0,0,128,64)
end
-->8
-------------------------------------------------------
--gracz--
function gracz()
p={}
p.x=63  --63
p.y=440   --440
p.sx=3
p.sy=3
p.g=2
p.meele=false
p.drzwi=false
p.drabina=false
p.j=0
p.skok_max=-8.9
p.skok_max2=-6
p.anim_stand={64,65,66,67}
p.anim_left={96,97,98,99}
p.anim_right={112,113,114,115}
p.anim_up={80,81,82,83}
p.zycia=4
p.dead=false
p.naziemi=true
p.stoi=true
p.keys=0
p.knieb=0
p.jnieb=false
p.kziel=0
p.jziel=false
p.kczer=0
p.jczer=false
p.kbial=0
p.jbial=false
p.nozyce=0
p.pociski=0
p.lewo = false
p.prawo = false
p.gora = false
p.dol = false
p.wcisniety = false
p.otwarte = false
p.koniec = false
p.test = false
end

function intro()
	cls()
rectfill(0, 0, 127, 127, 0)
rect(1,1,126,126,6)
print('Znajdujesz sie w ciemnym lochu',4,4,6)
print('na ktory trafil_s bladzac po',4,10,6)
print('ciemnych jaskiniach.',4,16,6)

print('Odkrywasz dziwny portal ,ktory',4,29,6)
print('znajduje sie za kratami. Aby',4,35,6)
print('sie do niego dostac musisz',4,41,6)
print('zdobyc klucze roznych barw.',4,47,6)

print('Klucze znajduja sie w roznych',4,60,6)
print('pomieszczeniach. Kazde z nich',4,66,6)
print('ma dla ciebie wyzwanie.',4,72,6)

print('Zasady gry zmieniaja sie wraz',4,85,6)
print('z pomieszczeniem w ktorym sie',4,91,6)
print('aktualnie znajdujesz.',4,97,6)

print('Powodzenia!',40,105,6)
spr(m.pochodnia[flr(klatki/4)%4+1],30,103)
spr(m.pochodnia[flr(klatki/4)%4+1],85,103)
	print('(Kliknij "c" aby kontynuowac)',4,115,6)
end

function koniec()
	cls()
	rectfill(0, 0, 127, 127, 0)
	rect(1,1,126,126,9)
	print('Udalo ci sie stawic czola ',4,16,6)
	print('wszystkim postawionym przed',4,29,6)
	print('toba wyzwaniom. Gratulacje!',4,35,6)
	print('Pod skarbem, ktory znalazles',4,41,6)
	print('znajdowal sie potral dzieki',4,47,6)
	print('ktoremu udalo ci sie wydostac',4,53,6)
	print('spowrotem na powierzchnie.',4,59,6)
spr(m.pochodnia[flr(klatki/4)%4+1],30,103)
	spr(m.pochodnia[flr(klatki/4)%4+1],85,103)
end

function anim_src()
m={}
m.pochodnia={68,69,70,71}
m.portal={84,85,86,87,100,101,102,103}
m.blokada={116,117,118,119}
m.skarb={72,73,74,88}
m.klejnoty={89,90,104,105,106,120,121,122}
end

function animacje()
spr(m.pochodnia[flr(klatki/4)%4+1],4*8,48*8)
spr(m.pochodnia[flr(klatki/4)%4+1],7*8,48*8)
spr(m.pochodnia[flr(klatki/4)%4+1],11*8,48*8)
spr(m.pochodnia[flr(klatki/4)%4+1],1*8,50*8)
spr(m.pochodnia[flr(klatki/4)%4+1],1*8,55*8)
spr(m.pochodnia[flr(klatki/4)%4+1],1*8,57*8)
spr(m.pochodnia[flr(klatki/4)%4+1],40*8,6*8)
spr(m.pochodnia[flr(klatki/4)%4+1],106*8,9*8)
end

function portal()
	spr(m.klejnoty[flr(klatki/4)%8+1],120*8,57*8)
	spr(m.klejnoty[flr(klatki/4)%8+1],121*8,56*8)
	spr(m.klejnoty[flr(klatki/4)%8+1],122*8,57*8)
	spr(m.klejnoty[flr(klatki/4)%8+1],123*8,56*8)
	spr(m.skarb[flr(klatki/4)%4+1],120*8,56*8)
	spr(m.skarb[flr(klatki/4)%4+1],121*8,57*8)
	spr(m.skarb[flr(klatki/4)%4+1],122*8,56*8)
spr(m.portal[flr(klatki/4)%8+1],18*8,54*8)
spr(m.portal[flr(klatki/4)%8+1],118*8,61*8)
--blokada
if p.otwarte == false then
	for x=52,56 do
spr(m.blokada[flr(klatki/4)%4+1],16*8,x*8)
end
else
	for c=52,56 do
	zamien(16*8,c*8,8,26)
end
end
end

function dialogi()
if p.dead == true then
	rectfill(p.x-37,p.y-19,p.x+25,p.y,0)
print("Przegrales!",p.x-35,p.y-17,6)
print("Nacisnij CRTL+R",p.x-35,p.y-11,6)
print("aby zresetowac.",p.x-35,p.y-5,6)
end
if czysprite_plus1(p.x,p.y,27)then
	if p.nozyce == 0 then
		rectfill(p.x-42,p.y-24,p.x+64,p.y-10,0)
print("nie posiadasz nozyc",p.x-40,p.y-	22,6)
print("potrzebnych do zniszczenia",p.x-40,p.y-16,6)
end
p.meele=true
else
	p.meele=false
end
--niebieski
if czysprite(p.x,p.y,43)then
	if p.knieb == 0 then
		rectfill(p.x-33,p.y-24,p.x+46,p.y-10,0)
	print("nie posiadasz",p.x-30,p.y-	22,6)
	print("niebieskiego klucza",p.x-30,p.y-16,6)
else
	sfx(8)
	zamien(p.x,p.y,43,59)
	p.jnieb=true
end
end
--zielony
if czysprite(p.x,p.y,44)then
	if p.kziel == 0 then
		rectfill(p.x-33,p.y-24,p.x+46,p.y-10,0)
	print("nie posiadasz",p.x-30,p.y-	22,6)
	print("zielonego klucza",p.x-30,p.y-16,6)
else
	sfx(8)
	zamien(p.x,p.y,44,60)
	p.jziel=true
end
end
--czerwony
if czysprite(p.x,p.y,45)then
	if p.kczer == 0 then
		rectfill(p.x-33,p.y-24,p.x+46,p.y-10,0)
	print("nie posiadasz",p.x-30,p.y-	22,6)
	print("czerwonego klucza",p.x-30,p.y-16,6)
else
	sfx(8)
	zamien(p.x,p.y,45,61)
	p.jczer=true
end
end
--bialy
if czysprite(p.x,p.y,46)then
	if p.kbial == 0 then
		rectfill(p.x-33,p.y-24,p.x+46,p.y-10,0)
	print("nie posiadasz",p.x-30,p.y-	22,6)
	print("bialego klucza",p.x-30,p.y-16,6)
else
	sfx(8)
	zamien(p.x,p.y,46,62)
	p.jbial=true
end
end
if (p.jziel == true and p.jczer == true and p.jbial == true and p.jnieb == true)then
	p.otwarte = true
end
--znaki
if p.dead == false then
if czysprite(p.x,p.y,91)then
	rectfill(p.x-50,p.y-24,p.x+50,p.y+1,0)
print("Poruszanie za pomoca",p.x-45,p.y-	22,6)
print("klawiszy lewo, prawo.",p.x-45,p.y-16,6)
print("Klikaj c by skakac",p.x-45,p.y-10,6)
print("oraz x aby oddac strzal.",p.x-45,p.y-4,6)
end
end
--znak skarb
if p.dead == false then
if czysprite(p.x,p.y,109)then
	rectfill(p.x-50,p.y-24,p.x+50,p.y-10,0)
print("Odnajdujesz skarb!",p.x-45,p.y-	22,6)
print("Gratulacje!",p.x-45,p.y-16,6)
end
end

if p.dead == false then
	if czysprite(p.x,p.y,30)then
		rectfill(p.x-50,p.y-24,p.x+60,p.y+13,0)
	print("Zbierz wszystkie klucze",p.x-47,p.y-	22,6)
	print("aby dostac sie do ukrytego",p.x-47,p.y-16,6)
	print("skarbu. Klucze znajduja",p.x-47,p.y-10,6)
	print("sie na roznych typach map",p.x-47,p.y-4,6)
	print("do ktorych dostaniesz sie",p.x-47,p.y+2,6)
	print("za pomoca portali ponizej.",p.x-47,p.y+8,6)
	end
	if czysprite(p.x,p.y,31)then
		rectfill(p.x-55,p.y-34,p.x+62,p.y+50,0)
		spr(m.portal[flr(klatki/4)%8+1],p.x-53,p.y-33)
		print("- Glowny potral do skarbu.",p.x-40,p.y-32,6)

		spr(1,p.x-53,p.y-24)
		print("- Skrzynia z przedmiotami.",p.x-40,p.y-23,6)

		spr(m.blokada[flr(klatki/4)%4+1],p.x-53,p.y-15)
		print("- Pole silowe.",p.x-40,p.y-14,6)

  spr(43,p.x-53,p.y-6)
		print("- Nieaktywny zamek.",p.x-40,p.y-5,6)

		spr(59,p.x-53,p.y+3)
		print("- Aktywowany zamek.",p.x-40,p.y+4,6)

		spr(15,p.x-53,p.y+12)
		print("- Znak informacyjny.",p.x-40,p.y+13,6)

		spr(11,p.x-53,p.y+21)
		print("- Nozyce do roslin.",p.x-40,p.y+22,6)

			spr(19,p.x-53,p.y+30)
			print("- Pocisk.",p.x-40,p.y+31,6)

			spr(52,p.x-53,p.y+39)
			print("- Kamien (mozna zniszcz).",p.x-40,p.y+40,6)
	end
end
if czysprite(p.x,p.y,124)then
p.koniec = true
end
end
 function pocisk()
po={}
po.sprite=19
po.x=2
po.y=2
po.sx=2
po.sy=2
po.w=8
po.h=8
po.istn=0
po.kierunek =""
	end

function eq()
	if(p.dead ==false)then
		spr(9,p.x+52,p.y-59)
		print(':'..p.zycia,p.x+59,p.y-58,6)
		if (p.pociski==0 and p.keys==0 and p.knieb==0 and p.kziel==0 and p.kczer==0 and p.kbial==0 and p.nozyce==0) then
			print('brak przedmiotow',p.x-40,p.y-58,6)
		else
			--nozyce gui
			rectfill(p.x-60,p.y-60,p.x-43,p.y-51,0)
			rect(p.x-60,p.y-60,p.x-43,p.y-51,6)
spr(11,p.x-59,p.y-59)
print(':'..p.nozyce,p.x-51,p.y-58,6)
--pociski gui
rectfill(p.x-41,p.y-60,p.x-25,p.y-51,0)
rect(p.x-41,p.y-60,p.x-25,p.y-51,6)
spr(19,p.x-40,p.y-59)
print(':'..p.pociski,p.x-33,p.y-58,6)
--klucze gui
if (p.knieb==0 and p.kziel==0 and p.kczer==0 and p.kbial==0)then
		rectfill(p.x-23,p.y-60,p.x+30,p.y-51,0)
	rect(p.x-23,p.y-60,p.x+30,p.y-51,6)
print('brak kluczy',p.x-19,p.y-58,6)
else
	rectfill(p.x-23,p.y-60,p.x+15,p.y-51,0)
	rect(p.x-23,p.y-60,p.x+15,p.y-51,6)
		if p.knieb==1 then
	spr(38,p.x-21,p.y-59)
end
if p.kziel == 1 then
  spr(40,p.x-12,p.y-59)
end
if p.kczer == 1 then
  spr(39,p.x-3,p.y-59)
end
if p.kbial == 1 then
	spr(56,p.x+6,p.y-59)
end

end--koniec elsa

end
end
end

function animuj_gracza()
	if(p.lewo)then
		spr(p.anim_left[flr(klatki/4)%4+1],p.x,p.y)
	elseif(p.prawo)then
		spr(p.anim_right[flr(klatki/4)%4+1],p.x,p.y)
	elseif(p.gora)then
		spr(p.anim_up[flr(klatki/4)%4+1],p.x,p.y)
	else
			spr(p.anim_stand[flr(klatki/4)%4+1],p.x,p.y)
	end
end

function wrog()
w={}
w.x=144
w.y=64
w.sprite=52
w.anim={8,9,10,11}
end

function rysuj_wroga(x,y)
spr(w.anim[flr(klatki/4)%4+1],x*8,y*8)
end

function jakisprite(x,y,rog)
rog.lg = mget(x / 8, y / 8)
rog.ld = mget(x / 8, (y+7) / 8 )
rog.pg = mget((x+7) / 8, y /8)
rog.pd = mget((x+7) / 8, (y+7) / 8)
return rog
end

function czysprite(x,y,sprite)
rog={}
rog.lg = mget(x / 8, y / 8)
rog.ld = mget(x / 8, (y+7) / 8 )
rog.pg = mget((x+7) / 8, y /8)
rog.pd = mget((x+7) / 8, (y+7) / 8)
if rog.lg==sprite then
	return true
elseif rog.ld==sprite then
	return true
elseif rog.pd==sprite then
	return true
elseif rog.pg==sprite then
	return true
end
end

function czysprite_plus1(x,y,sprite)
rog={}
rog.lg = mget((x-1) / 8, (y+1) / 8)
rog.ld = mget((x-1) / 8, (y+8) / 8 )
rog.pg = mget((x+8) / 8, (y+1) /8)
rog.pd = mget((x+8) / 8, (y+8) / 8)
if rog.lg==sprite then
	return true
elseif rog.ld==sprite then
	return true
elseif rog.pd==sprite then
	return true
elseif rog.pg==sprite then
	return true
end
end

function czysprite_srodek(x,y,sprite)
rog={}
rog.lg = mget((x+4) / 8, (y+4) / 8)
if rog.lg==sprite then
	return true
end
end

function czyflaga(x,y,num)
	r1=mget(x / 8 , y / 8)
	r2=mget((x+7) / 8, y /8)
	r3=mget(x / 8, (y+7) / 8 )
	r4=mget((x+7) / 8, (y+7) / 8)
	if fget(r1, num) then
	return true
elseif fget(r2, num) then
	return true
elseif fget(r3, num) then
	return true
elseif fget(r4, num) then
	return true
	end
end

function zniszcz(x,y,sprite)
		rog ={}
		rog = jakisprite(x,y,rog)

		if rog["lg"] == sprite then
			sfx(2)
			mset(x/8,y/8,(rog.lg+1))
		elseif rog["ld"] == sprite then
				sfx(2)
			mset(x/8,(y+7)/8,(rog.ld+1))
		elseif  rog["pg"] == sprite then
				sfx(2)
			mset((x+7)/8,y/8,(rog.pg+1))
		elseif  rog["pd"] == sprite then
				sfx(2)
			mset(((x+7)/8),((y+7)/8),(rog.pd+1))
		end
	end

	function zamien(x,y,spr1,spr2)
		rog ={}
		rog = jakisprite(x,y,rog)

		if rog["lg"] == spr1 then
			mset(x/8,y/8,(spr2))
		elseif rog["ld"] == spr1 then
			mset(x/8,(y+7)/8,(spr2))
		elseif  rog["pg"] == spr1 then
			mset((x+7)/8,y/8,(spr2))
		elseif  rog["pd"] == spr1 then
			mset(((x+7)/8),((y+7)/8),(spr2))
		end
	end


function ruch()
p.sx=p.x
p.sy=p.y
po.sx=po.x
po.sy=po.y
--ruch oraz zmiana obrazka
if(p.dead == false)then
if(btn(⬆️)) then
	p.y-=1
	p.sprite=12
	p.gora=true
	p.dol=false
	p.lewo=false
	p.prawo=false
	p.stoi=false
	--spr(p.anim_up[flr(klatki/4)%4+1],p.x,p.y)
elseif(btn(⬇️)) then
 p.y+=1
 --p.sprite=11
	p.dol=true
	p.gora=false
	p.lewo=false
	p.prawo=false
		p.stoi=false
	--spr(p.anim_stand[flr(klatki/4)%4+1],p.x,p.y)
else
	p.sprite=8
	p.stoi=true
end
if(btn(⬅️)) then
 p.x-=1
 p.sprite=9
	p.lewo=true
	p.prawo=false
	p.gora=false
	p.dol=false
		p.stoi=false
elseif(btn(➡️)) then
 p.x+=1
 p.sprite=10
	p.prawo=true
	p.lewo=false
	p.gora=false
	p.dol=false
		p.stoi=false
	else
		p.sprite=8
		p.stoi=true
end
end
--strzaわ🐱?
interakcja()
				if czyflaga(p.x,p.y,0) then
				p.x = p.sx
				end
				if czyflaga(p.x,p.y,0) then --------tutaj kolejnosc ma znaczenie... wykminic jak zrobic zeby slizgalo na x i na y
				p.y = p.sy
				end
end --koniec funkcji ruch


function interakcja()
	if(p.dead==false)then
			if(btnp(❎)) then
					if(p.meele == false) then
							if(p.pociski>0)then
										sfx(1)
										p.pociski-=1
													if(p.gora)then
																		po.kierunek="gora"
																		po.x=p.x
																		po.y=p.y
													elseif(p.dol)then
																		po.kierunek="dol"
																		po.x=p.x
																		po.y=p.y
												elseif(p.lewo)then
																	po.kierunek="lewo"
																	po.x=p.x
																	po.y=p.y
												elseif(p.prawo)then
																	po.kierunek="prawo"
																	po.x=p.x
																	po.y=p.y
													end
								elseif(p.pociski==0)then
									sfx(5)
								end--end pociskow
							elseif(p.meele==true)then
								if(p.nozyce>0)then
									sfx(7)
											p.nozyce-=1
											zamien(p.x,p.y,27,25)
										end
							end--end meele
							end --end btn
					end --p.dead
end--funkcji

function flagi()
	if czysprite_srodek(p.x,p.y,29)then
		p.drabina=true
	else
		p.drabina=false
	end
--OBSわ▒UGA SKRZYわ⬇️
if czysprite(p.x,p.y,1)then
	sfx(3)
p.pociski+=6
p.kziel+=1
zamien(p.x,p.y,1,2)
end

--zycia
if czysprite(p.x,p.y,12)then
p.zycia+=1
zamien(p.x,p.y,12,25)
end


--nozyce
if czysprite(p.x,p.y,13)then
	sfx(3)
p.nozyce+=1
zamien(p.x,p.y,13,26)
end
if czysprite(p.x,p.y,14)then
	sfx(3)
p.nozyce+=1
zamien(p.x,p.y,14,25)
end

--klucze
--niebieski
if czysprite(p.x,p.y,41)then
	sfx(3)
p.knieb+=1
zamien(p.x,p.y,41,25)
end
--czerwony
if czysprite(p.x,p.y,57)then
	sfx(3)
p.kczer+=1
zamien(p.x,p.y,57,76)
end
--zielony
if czysprite(p.x,p.y,42)then
	sfx(3)
p.kziel+=1
zamien(p.x,p.y,42,25)
end
--bialy
if czysprite(p.x,p.y,58)then
	sfx(3)
p.kbial+=1
zamien(p.x,p.y,58,25)
end

--kolce
if czysprite(p.x,p.y,28)  then
		sfx(9)
p.zycia-=1
p.x=6*8
p.y=6*8
if(p.dead)then
		sfx(4)
end
end
if czysprite(p.x,p.y,94) or czysprite(p.x,p.y,95)then
	sfx(9)
	p.zycia-=1
	p.x=56*8
	p.y=62*8
end
--kolce skok
if czyflaga(p.x,p.y,4)then
	sfx(9)
	p.zycia-=1
	p.x=44*8
	p.y=8*8
end
--znikanie kafelkow uderzonych przez pocisk
if czyflaga(po.x,po.y,6) then
	zniszcz(po.x,po.y,36)
	zniszcz(po.x,po.y,52)
		zniszcz(po.x,po.y,48)
 po.kierunek=""
end

if czyflaga(po.x,po.y,0)then
po.kierunek=""
end

--portale
--portal twierdza do platf
	if czysprite(p.x,p.y,54)then
p.x=6*8
p.y=6*8
sfx(6)
end
--portal platf do twierdza
if czysprite(p.x,p.y,55)then
p.x=6*8
p.y=58*8
sfx(6)
end

--portal end skarb
if czysprite(p.x,p.y,10)then
	sfx()
	p.x=120*8
	p.y=60*8
end
--portal skarb twierdza
if czysprite(p.x,p.y,108)then
	p.x=17*8
	p.y=55*8
end
--portal twierdza do skok
if czysprite(p.x,p.y,23)then
	sfx(6)
	p.x=44*8
	p.y=8*8
end
--portal skok do twierdza
if czysprite(p.x,p.y,24)then
	sfx(6)
	p.x=6*8
	p.y=56*8
end
if czysprite(p.x,p.y,50)then
sfx(6)
p.x=56*8
p.y=62*8
end
if czysprite(p.x,p.y,53)then
sfx(6)
p.x=4*8
p.y=53*8
end
--kolizja zawsze na koncu. W przeciwnym wypadku triggery nie bろ▥dろ✽ dziaわ🐱aろ♥.


--postac nie wyjdzie na ujemne koordy
if (p.x<0) then
	p.x=mid(0,newx,127)
	end
	if(p.y<0) then
	p.y=mid(0,newy,63)
end
end

function ruch_pocisku()
if(po.kierunek!="") then
 if(po.kierunek == "gora")then
				po.y-=3
	end
	if(po.kierunek == "dol")then
				po.y+=3
	end
	if(po.kierunek == "lewo")then
				po.x-=3
	end
	if(po.kierunek == "prawo")then
				po.x+=3
	end
end
end
------------------------------------------------------
function ruch_platf()
	p.sx=p.x
	p.sy=p.y
	po.sx=po.x
	po.sy=po.y
	if (p.dead == false)then
	if(btn(⬅️)) then
	 p.x-=2
	 p.sprite=9
		p.lewo=true
		p.prawo=false
		p.gora=false
		p.dol=false
			p.stoi=false
	elseif(btn(➡️)) then
	 p.x+=2
	 p.sprite=10
		p.prawo=true
		p.lewo=false
		p.gora=false
		p.dol=false
			p.stoi=false
		end
	end
		if (p.dead == false)then
			if (p.drabina) then
				cls(1)
					if(btn(⬆️)) then
						p.y-=1
						p.sprite=12
						p.gora=true
						p.dol=false
						p.lewo=false
						p.prawo=false
						p.stoi=false
						--spr(p.anim_up[flr(klatki/4)%4+1],p.x,p.y)
					elseif(btn(⬇️)) then
					 p.y+=1
					 --p.sprite=11
						p.dol=true
						p.gora=false
						p.lewo=false
						p.prawo=false
							p.stoi=false
			--spr(p.anim_right[flr(klatki/4)%4+1],p.x,p.y)
		else
			p.sprite=8
			p.stoi=true
		end
			--spr(p.anim_stand[flr(klatki/4)%4+1],p.x,p.y)
	end
end
	interakcja()
if czyflaga(p.x,p.y,0) then
p.x = p.sx
end
if(p.dead==false)then
	if(btnp(🅾️))then
		if p.naziemi == true then
			p.j = p.skok_max
		end
			end
			if p.drabina == false then
			p.y+= p.g + p.j
		end
end


if czyflaga(p.x,p.y,0) then --------tutaj kolejnosc ma znaczenie... wykminic jak zrobic zeby slizgalo na x i na y
p.y = p.sy
p.naziemi=true
else
	p.naziemi=false
end
end

function opadanie()
	if p.j < 0 then
		p.j+=1
	elseif p.j > 0 then
		p.j=0
	end
end

function ruch_skok()
	p.sx=p.x
	p.sy=p.y
	po.sx=po.x
	po.sy=po.y
	if (p.dead == false)then
		if(btn(⬅️)) then
			p.x-=1.5
			p.sprite=9
			p.lewo=true
			p.prawo=false
			p.gora=false
			p.dol=false
				p.stoi=false
	elseif(btn(➡️)) then
	 p.x+=1.5
	 p.sprite=10
		p.prawo=true
		p.lewo=false
		p.gora=false
		p.dol=false
			p.stoi=false

		end
	end
	interakcja()
if czyflaga(p.x,p.y,0) then
p.x = p.sx
end
if(p.dead==false)then
	if(btnp(🅾️))then
			p.j =-5
			end
			if p.drabina == false then
			p.y+= p.g + p.j
		end
end
if czyflaga(p.x,p.y,0) then --------tutaj kolejnosc ma znaczenie... wykminic jak zrobic zeby slizgalo na x i na y
p.y = p.sy
p.naziemi=true
else
	p.naziemi=false
end

end
--flaga 0 obiekty solidne, z kolizja
--flaga 1 mapa skok
--flaga 3 skrzynie
--flaga 4 kolc
--flaga 6 obiekty ktore mozna zniszczyc


__gfx__
0000000044444444444994440000000011c111111111111111111111000000005555555508808800000111009000000911111111955555599111111944444444
0000000044499444dd0000dd000000001c7c1cc111c1111111111111000000005115511588888880000101000900009011881881595555951911119145454554
0070070055555555d000000d00000000c717c77c11111c1111111111000000005115511588888880000111000090090018888888559559551191191145444454
0007700044499444d000000d0000000071117117111111111111111100000000555cc55588888880000100000009900018887888555995551119911144444444
0007700044444444444994440000000011111111111111111111111100000000555cc55508888800000100000009900018877888555995551119911100004000
007007004444444444444444000000001111cc111111111c11111111000000005115511500888000000100000990099011887881599559951991199100004000
00000000944444499444444900000000cc1c77cc1c11111111111111000000005115511500080000000100009090090911187811959559599191191900004000
0000000099444499994444990000000077c711771111111111111111000000005555555500000000000100000900009011118111595555951911119100004000
6516515641414616563334460000000080000008444545415544541455222255551111551111111155555555b1bb1b1116111111141114114444444444444444
46444444544445444543365400666000080000801776577177555111522222255111111511111111511551151bbbbb1b15111611144444114545455446464664
4433335163534363543334640667660000800800177657717765511152266225511661151111111151155115b111bb1116161511141114114544445446444464
55333331333333333333333406667600000880001665566166555111526886255168861511111111555115551bbbb11b16656611141114114444444444444444
1633334633333333333333330666660000088000155555515555511152688625516886151111111155511555bbbbbb1b16545461141114115551455555514555
5333335433333333333333330076600000800800177657717755111152688625516886151111111151155115111b1b1b64444446144444115115411551154115
6433336163444346333333330000000008000080177657717765111152266225511661151111111151155115b1bbb1b145445454141114115115411551154115
45333345454546543333333300000000800000084464464464514114522222255111111511111111555555551bb1bbb145454444141114115555455555554555
15433346333333334633344165165156111611111111111100000000000000000000000011111111111111115556556555565565555655655556556500000000
54433345333333335533365446444444115551111151111109000000090000000900000019111111191111116115511561155115611551156115511500000000
44533344333333336433344145454551655565111515151199900000999000009990000099911111999111115115511551155115511551155115511500000000
1643334633333333663334513353344115565651111111119c99999998999999939999999c99999993999999655cc55665533556655885566557755600000000
4443336633333333543334543333354615565556115111119990090999900909999009099991191999911919555cc55555533555555885555557755500000000
15533345333333334433344633333454155566511111115109000009090000090900000919111119191111195115511551155115511551155115511500000000
64433354333333335633545145335461115555111151111100000000000000000000000011111111111111115115511551155115511551155115511500000000
15433345333333336433346454333445111611611111111100000000000000000000000011111111111111115556556555565565555655655556556500000000
222622222222222255cccc55651651560006000055cccc5555cccc5555cccc550000000022222222111111115556556555565565555655655556556500000000
22555222225222225cccccc546445444005550005cccccc55cccccc55cccccc50900000029222222191111116995599569955995699559956995599500000000
65556522252525225cc66cc544454454655565005cc66cc55cc66cc55cc66cc59990000099922222999111115995599559955995599559955995599500000000
25565652222222225c6776c555433343055656505c6776c55c6cc6c55c6cc6c5979999999899999997999999655cc55665533556655885566557755600000000
25565556225222225c6776c516533333055655565c6776c55c6cc6c55c6cc6c5999009099992292999911919555cc55555533555555885555557755500000000
25556652222222525c6776c555333333055566505c6776c55c6cc6c55c6cc6c50900000929222229191111195995599559955995599559955995599500000000
22555522225222225cc66cc564433545005555005cc66cc55cc66cc55cc66cc50000000022222222111111115995599559955995599559955995599500000000
22262262222222225cccccc54545335400060060511111155cccccc55cccccc50000000022222222111111115556556555565565555655655556556500000000
09a9aa0009a9a90009a9aa0009aa9a00000900000090000000009000000900000000000000000000000000005d555d5522222222222262226666666600000000
0ac7c9000ac7c9000ac7c9000ac7c900009aa000000a000000a000000090a000000000000000000000000000ddd555dd22222222222656226565565600000000
a9fffa90a9fff9a0a9fff990a9fffa90009a9900009a9000000a9000000a090000000000000000000000000055d5555522222222226556226555655600000000
0028200000282000002820000028200004a9940004a9940004a9940004a994000000000000000000000007005555ddd522222222226565626655665600000000
0287620002876200028862000288620004595400045954000459540004595400000999000009970000097770555555d522222222265565562265656200000000
0f2824000f2824000f2724000f27240004555400045554000455540004555400009997900099777000977777d55555dd22222222655666562226556200000000
00b0100000b0100000b0100000b0100000454000004540000045400000454000099999990999979909997779dddd555522222222656565562226562200000000
0080200000802000008020000080200000040000000400000004000000040000999999999999999999999799555d5d5522222222656656562222622200000000
0099a00000a9a0000099a00000a9a000dddddddddddddddddddddddddddddddd000000000c0000000c0000004444444400000000656556561111611166666666
099a99000a99a9000a99990009a99900d555555dd555555dd556655dd566665d00000000ccc00080c7c000804545455400000000566556551116561165655656
0a999a000a9a9a000aa99a000a9aaa00d555555dd556655dd56cc65dd6cccc6d00000000c7c00888777008884544445400000000665555561165561165556556
00222000002220000022200000222000d55cc55dd56cc65dd6cccc6dd6cccc6d000000000c000888070008884444444400000000555555551165656166556656
02222200022222000222220002222200d55cc55dd56cc65dd6cccc6dd6cccc6d00099700000b0080000b00802222422200000000555555651655655611656561
04222f0004222f0004222f0004222f00d555555dd556655dd56cc65dd6cccc6d0099777000bbb00000bbb0002222422200000000566555656556665611165561
0010b0000010b0000010b0000010b000d555555dd555555dd556655dd566665d0999979900bbb00000bbb0002222422200000000665555666565655611165611
00208000000080000020000000208000dddddddddddddddddddddddddddddddd99999999000b0000000b00002222422200000000655556566566565611116111
009a9000009a900000a9900000999000dddddddddddddddddddddddddddddddd0c0000000c0000000c0000005555555500111000444444440000000000000000
0afc9a0009fca9000afc9a0009fca900d566665dd556655dd555555dd555555dccc00080ccc00080ccc000805335533500100110454545540000000000000000
09ffaaa009ff9a900affa9a00affaa90d6cccc6dd56cc65dd556655dd555555dc7c00888ccc00888ccc008885395593500100010454444540000000000000000
00282000002820000028200000282000d6cccc6dd6cccc6dd56cc65dd55cc55d0c0008880c0008880c0008885553355500100010444444440000000000000000
02876200028762000287620002876200d6cccc6dd6cccc6dd56cc65dd55cc55d000b0080000b0070000b00805553355500100010555345550000000000000000
04282f0004282f0004282f0004282f00d6cccc6dd56cc65dd556655dd555555d00bbb07000bbb77700bbb0705395593500100010539549350000000000000000
0010b0000010b0000010b0000010b000d566665dd556655dd555555dd555555d00bbb00000bbb07007bbb0005335533500100110533543350000000000000000
00208000020080000028000000208000dddddddddddddddddddddddddddddddd000b0000000b0000000b00005555555500111000555545550000000000000000
00a9900000aa900000a9900000a9a000555c65555556655555566555555665550c0000000c0000000c0000000000000055555555000000000000000000000000
0a9cfa000a9cfa000a9cfa000a9cfa00511c6115511c61155116611551166115ccc00080ccc00080ccc000800000000053355335000000000000000000000000
999ff9009a9ff90099aff9009a9ff9005116c1155116c1155116611551166115ccc00888ccc00888ccc008880000000053955935000000000000000000000000
00282000002820000028200000282000555665555556c5555556c555555665550c0008880c0008880c0008880000000055599555000000000000000000000000
0287620002876200028762000287620055566555555c6555555c655555566555000b0080000b0080000b00800000000055599555000000000000000000000000
0f2824000f2824000f2824000f2824005116611551166115511c6115511c611507bbb00000bbb00000bbb0000000000053955935000000000000000000000000
00b0100000b0100000b0100000b0100051166115511661155116c1155116c115777bb00007bbb00000bbb0000000000053355335000000000000000000000000
008020000080020000082000008020005556655555566555555665555556c555070b0000000b0000000b00000000000055555555000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4b4b4b491e5b4b4b4b4b4
e591f5919191919191919191d5e5b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4f5f5b4b4b4b491f591b4
b4e59191919191919191b4b4b4b4b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b49191f591919191919191
b4b49191919191919191f5f5f5f5b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
91f5919191919191e5e591919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191919191b4b4b4b4b491919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191e59191
9191919191f59191f5f591919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191d59191
919191e5e5919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191b4b4b4b4b4b4
b4b4b4b4b4919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
91f5d5d591919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4e5e59191919191919191
9191f5d591919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4b4b4b491919191919191
919191f59191e591919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b49191f591919191919191
91919191e591d591919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4919191e5e59191919191
9191e5e5d5e5d5e5e59191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4919191b4b4b4b4b49191
91e5b4b4b4b4b4b4b49191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191b4b4b4
91b4f5f5f5919191b49191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4919191919191919191b4
9191919191919191f59191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000b4919191919191919191b4
9191919191919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a170000000000000000000000000000000000000000000000000000000000000000000000000b4919191919191919191b4
b4b4b4b4b4919191919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070a1a1a1d0a1a1b2a1c2a1d2a1e2a170000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
91919191b4b4e591919191919191b400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070a1e1a1a1a1a1a1a1a1a1a1a1a1a170707070707000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191e59191b4b491919191919191b400000000000000000000000000000000000000000000000000000000000000000000707070707070707070707070707070
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a180a1a1a1a17000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191d5e5e591b4b4919191919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a180a1a1a1a17000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191b4b4b4b4b4f591919191e5c0b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6c7b670
0070a123a1a1f1a1a1a1a1a1a1a1a1a180a1a0a1a17000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191f5f5f5f5f5919191b4b4b4b4b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a180a1a1a1a17000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
91919191919191919191f5f59191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0070a171a1a1a1a1a1a1a1a1a1a1a1a180a1a1a1a17000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
919191919191919191e591919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6c7c7c7c7b6b6b670
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a170707070707000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191b4b4b4b4b4b4b4b491919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6d6b6b6b6c7c7c7c7b6b6b670
0070a163a1a1a1a1a1a1a1a1a110a1a170000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
919191919191919191f591919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0070a1a1a1a1a1a1a1a1a1a1a1a1a1a170000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
e5e5e59191919191919191919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191b4b4b4
b4b4b49191919191919191919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b491919191919191919191
9191919191919191919191919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6c6b6b6b6b6b6b6b6b670
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b453919191919191919191
9191919191919191919191919191b40000000000000000000000000000000000000000000000000000000000000000000070b6b6b6b6b6b6b6b6b6b6b6b6b670
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b4b4b4b4b4b4b4b4b4b4b4
b4b4b4b4b4b4b4b4b4b4b4b4b4b4b400000000000000000000000000000000000000000000000000000000000000000000707070707070707070707070707070
__label__
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddmmddmdddddddmmdmdddmmdmddddddddddmddddddddddddddddmdmddddddddddmdmdmddddddmmdddmdddmdddmdmmddddddddmddddmdddddd
ddddddddddddmddddddmddddmddddmddmdddmdddmddmmdmddmdddmdddmddmmdddddmddddddddddmddddddddddmddddmddmddddmddddddddmddddmddddmdddddd
dmddddmmmdddmddddddddddmdddddmddmmddmddddmdmddddddmdmddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

__gff__
0028200101010101010000200420040001010180000000202004204100042020010001014104000000040420202020004102200100202004000420202020200000000000010101010000000102101000000000000000000000000002001010100000000000000000000000200020000000000000202020200000000020000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0707070707070707070707070707070707070707070707070707070707070000000000000000000707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000
071919191919191919191919191919191919071919191907191919191907000000000000000000075d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d070000000000000000000000000000000000000000
071919191919191919191919191919191919071919191907191919191907000000000000000000074e4e4e4e4e4e4e4e5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4e4e4e4e5d5d5d5d5d5d5d5d5d5d5d4e4e4e4e4e4e5d5d5d5d5d5d5d5d070000000000000000000000000000000000000000
071919191919191919191919191919191919071919191907191919191907000000000000000000074b4c4c4c4c4c4c4c4e5d5d5d4e5d5d5d5d5d5d5d5d5d5d5d4e4e4e4e5d5d5d5d5d4e4e4e5d4e4c4c4c4c4e4e4e4e5d5d5d5d5d5d5d4c4c4c4c4c4c4e4e5d5d5d5d5d5d070000000000000000000000000000000000000000
071919191919191919191919191919191919071919191907191919191907000000000000000000074b4c4c4c4c4c4c4c4c5d5d5d4c4e5d5d5d5d5d5d5d4e4e4e4c4c4c4c4e4e5d4e4e4c4c4c4e4c4c4c4c4c4c4c4c4c4e5d5d5d5d5d4e4c4c4c4c4c4c4c4c4e5d5d5d5d5d070000000000000000000000000000000000000000
071919191919191919191919191919191919071919191907191919191907000000000000000000074b4c4c4c4c4c4c4c4c5d5d4e4c4c4e5d5d5d5d4e4e4c4c4c4c4c4c4c4c4c4e4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4e5d4e4e4c4c4c4c4c4c4c4c4c4c4e4e4e4e5d070000000000000000000000000000000000000000
0719191937191919191919191919101919191b191d19191b191919291907000000000000000000074b4c4c4c4c4c4c4c4c5d4e4c4c4c4c5d4e5d4e4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4e4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4e070000000000000000000000000000000000000000
11111111111111111111111111111211111111231d331111111111111107000000000000000000074b4c4c4c4c4c4c4c4c4e4c4c4c4c4c4e4c4e4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c070000000000000000000000000000000000000000
07191919191919191919191919191919191919191d191919191919191907000000000000000000074b184c5b4c4c4c4c4c4c4c4c4c4c4c4c4c304c4c4c4c4c4c4c4c4d4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4c4d4d4d4c4c4c4c4c4c4c4c4b070000000000000000000000000000000000000000
07191919191919191919191919191919191919191d191919191919191907000000000000000000074b4b4b4b4b4b4c4c4c4c4c4c4c4c4c4c4c304c4c4c4c4c4d4d4d5d4d4c4c4c4c4c4c4c4d4d4c4c4c4d4d4d4c4c4c4c4c4c4c4c4c4c4d4d5d5d5d4d4c4c4c4c4c4c4c4b070000000000000000000000000000000000000000
07191919191919191919241919191919191919191d191919191919191907000000000000000000074c4c4c4c4c4c4c4d4c4c4c4c4c4c4c4c4c304c4c4c4c4d5d5d5d5d5d4d4c4c4c4c4c4d5d5d4d4c4d5d5d5d4d4d4c4c4c4c4c4c4c4d5d5d5d5d5d5d4d4c4c4c4c394c4b070000000000000000000000000000000000000000
07190e19191919191919241919191919191919191d191919191919190c07000000000000000000074c4c4c4c4c4c4d5d4c4c4c4c4d4c4c4c4c304c4d4d4d5d5d5d5d5d5d5d4d4c4c4c4d5d5d5d5d4d5d5d5d5d5d5d4d4d4d4c4c4c4d5d5d5d5d5d5d5d5d4d4c4c4b4b4b4b070000000000000000000000000000000000000000
071111111111111111111111231919331111111111111123191919331107000000000000000000074c4c4c4c4c4d5d5d4c4d4c4d5d4d4c4c4d4d4d5d5d5d5d5d5d5d5d5d5d5d4d4d4d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4d4c4d5d5d5d5d5d5d5d5d5d5d4d4c4d4d4c4c070000000000000000000000000000000000000000
071919191919191919191919221919201919191919191922191919221907000000000000000000074d4d4d4d4d5d5d5d4d5d4d5d5d5d4d4d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4d5d5d5d5d5d5d5d5d5d5d5d5d4d5d5d4d4d070000000000000000000000000000000000000000
071919191919191919191919221c1c2019191919191919221c1c1c221907000000000000000000075d5d5d5d4d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d070000000000000000000000000000000000000000
0719191919191919191919191111111119191919191919111111111119070000000000000000000707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000
0000000000000000000000000000000000140000000000000000000000000000000014000000000000000000000000000000001400000000000000000000000000000000140000000000000000000000000000000014000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b4b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b1919191919191919191919191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b1919191919191919191919191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b191919195e191919191919191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b191919195d5e1919191919191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b191919195d5d35193a1919191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b191919194b4b4b4b4b4b19191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b19191919191919195f4b4b191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b1919191919191919195d19191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b1919191919191919195f19191919191919191919191919194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b19191919191919191919194b4b4b4b4b4b19191919195e194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004b19191919195e5e5e5e5e19195d1919191919191919195d194b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000300010c0501b000060001d0000a0000d000100001400017002190031a0021b0011900317001160021200310000100001200015000150001700017000000000000000000000000000000000000000000000000
000200002c0302a03027030220301e0301a03014030120002a1002610020100191001210011100123001230012300123001430018300183001d1001d1001d1001d1001d1001c1001c1001c1001c1001c1002a700
000200002713024130201301b1301713013130101301a700197001970018700177001670016700167001670017700197001b7001c7001d7001e7001f700217002270023700247002470025700257002570025700
0103000005750067500675007750097500b7500e750107501275013750157500f1000f1000f1000b2000b2000c2000e2000f200102000e2000e2000e20018300193001e300000001740018400114000000000000
991800001315011150101500e1500c150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0110000013050110502870027700277000000026700257002570024700247002370022700227002170000000207001f7001f7001f7001e7001e7001e7001e7001e7002070022700257002d700000000000000000
010a00000e41010410154101741000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011400001f61423614000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000180301c030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003a020310202a020220201e02016020120300e0300b0300a0300703006030190001a0001c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 07024344
