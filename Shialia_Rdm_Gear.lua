function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc','FullAcc')
	state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal','PDT','MDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Naegling','Sequence','DualWeapons','DualWeaponsAcc','DualEvisceration','DualClubs','DualAeolian','DualProcDaggers','EnspellOnly')
	state.UnlockWeapons = M(true, 'Unlock Weapons')

	gear.da_jse_back = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10',}}
	gear.nuke_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	gear.wsd_jse_back = {name="Sucellos's Cape",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.enfeeble_jse_back = {name="Sucellos's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Enmity-10','Phys. dmg. taken-10%',}}

	include('User/Global-RDM-Binds.lua')

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +1"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Homiliary",
		head="Atro. Chapeau +2",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Viti. Tabard +1",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.enfeeble_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet=gear.merlinic_conservemp_feet}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		range=empty,ammo="Voluspa Tathlum",
		head="Viti. Chapeau +3",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.wsd_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}
		
	sets.precast.WS.Proc = 	{range=empty,ammo="Hasty Pinion +1",
		head="Malignance Chapeau",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Nyame Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.wsd_jse_back,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {range=empty,ammo="Regal Gem",
		head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Rufescent Ring",
		back=gear.wsd_jse_back,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.precast.WS['Chant Du Cygne'] = {range=empty,ammo="Voluspa Tathlum",
		head="Malignance Chapeau",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Ayanmo Corazza +2",hands="Jhakri Cuffs +2",ring1="Begrudging Ring",ring2="Ilabrat Ring",
		back=gear.wsd_jse_back,waist="Fotia Belt",legs="Carmine Cuisses +1",feet="Thereoid Greaves"}
		
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {ammo="Regal Gem",
		head="Jhakri Coronal +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Sherida Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Metamor. Ring +1",ring2="Rufescent Ring",
		back=gear.wsd_jse_back,waist="Prosilio Belt +1",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
		
	sets.precast.WS['Sanguine Blade'] = {range=empty,ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Jhakri Cuffs +2",ring1="Metamor. Ring +1",ring2="Archon Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}
		
	sets.precast.WS['Seraph Blade'] = {range=empty,ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}
		
	sets.precast.WS['Aeolian Edge'] = {range=empty,ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Jhakri Cuffs +2",ring1="Metamor. Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=gear.chironic_treasure_hands,feet=gear.merlinic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {
		--main=gear.grioavolr_nuke_staff,
		--sub="Alber Strap",
		head="Nyame Helm",
		neck="Mizu. Kubikazari",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--ring1="Mujin Band",
		legs="Ea Slops",
		feet="Jhakri Pigaches +2"
	}
	
	sets.midcast.FastRecast = {ammo="Homiliary",
		head="Atro. Chapeau +2",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Viti. Tabard +1",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.enfeeble_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet=gear.merlinic_conservemp_feet}

	sets.midcast.Cure = {main="Daybreak",sub="Sors Shield",ammo="Hydrocera",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +1",hands="Kaykaus Cuffs",ring1="Lebeche Ring",ring2="Janniston Ring",
		back=gear.enfeeble_jse_back,waist="Sacro Cord",legs="Atrophy Tights +1",feet="Vanya Clogs"}
		
	sets.midcast.LightWeatherCure = {main="Iridal Staff",sub="Achaq Grip",ammo="Regal Gem",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +1",hands="Kaykaus Cuffs",ring1="Lebeche Ring",ring2="Janniston Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Atrophy Tights +1",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {main="Iridal Staff",sub="Achaq Grip",ammo="Regal Gem",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +1",hands="Kaykaus Cuffs",ring1="Lebeche Ring",ring2="Janniston Ring",
		back="Twilight Cloak",waist="Hachirin-no-Obi",legs="Atrophy Tights +1",feet="Vanya Clogs"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		neck="Malison Medallion",
		--hands="Hieros Mittens",
		--back="Oretan. Cape +1",
		ring1="Ephedra Ring",
		ring2="Haoma's Ring",
		waist="Witful Belt",
		feet="Vanya Clogs"
	})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {
		--neck="Phalaina Locket",
		--ear1="Etiolation Earring",
		--hands="Buremte Gloves",
		--ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Cure_Received = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		--ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Self_Refresh = {
		--back="Grapevine Cape",
		waist="Gishdubar Sash"
	}

	sets.midcast['Enhancing Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Hydrocera",
		head=gear.telchine_enh_head,neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body=gear.telchine_enh_body,hands="Atrophy Gloves +2",ring1="Lebeche Ring",ring2="Stikini Ring",
		back="Ghostfyre Cape",waist="Embla Sash",legs=gear.telchine_enh_legs,feet="Leth. Houseaux +1"}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {
		head="Leth. Chappel +1",
		body="Lethargy Sayon +1",hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +1",feet="Leth. Houseaux +1"}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {main="Pukulatmuj +1",
		head="Befouled Crown",
		neck="Incanter's Torque",
		body="Viti. Tabard +1",
		ear1="Mimir Earring",hands="Viti. Gloves +1",
		back="Ghostfyre Cape",
		--waist="Olympus Sash",
		legs="Atrophy Tights +1"
	}
	sets.midcast.Refresh = {head="Amalric Coif",body="Atrophy Tabard +2",legs="Leth. Fuseau +1"}
	sets.midcast.Aquaveil = {
		head="Amalric Coif",
		--hands="Regal Cuffs",
		--waist="Emphatikos Rope",
		--legs="Shedir Seraweels"
	}
	sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {sub="Pukulatmuj"})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {sub="Pukulatmuj"})
	sets.midcast.BoostStat = {hands="Viti. Gloves +1"}
	sets.midcast.Stoneskin = {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		--legs="Shedir Seraweels"
	}
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	
	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Regal Gem",
		head="Atro. Chapeau +2",neck="Dls. Torque +1",ear1="Regal Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Stikini Ring",ring2="Kishar Ring",
		back=gear.enfeeble_jse_back,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",
		head="Atro. Chapeau +2",neck="Dls. Torque +1",ear1="Regal Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enfeeble_jse_back,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}
		
	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {body="Atrophy Tabard +2",range="Regal Gem",ring2="Kishar Ring"})
		
	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling,{waist="Acuity Belt +1"})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{waist="Acuity Belt +1"})
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling,{waist="Acuity Belt +1"})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{waist="Acuity Belt +1"})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling,{waist="Acuity Belt +1"})
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,{waist="Acuity Belt +1"})
	
	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'], {ear1="Vor Earring",hands="Leth. Gantherots +1",ring2="Stikini Ring"})
	
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {waist="Chaac Belt"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt"})

	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Shamash Robe",hands=gear.chironic_treasure_hands,ring1="Metamor. Ring +1",ring2="Tamas Ring",
		back=gear.enfeeble_jse_back,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Dls. Torque +1",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}
		
	sets.midcast['Elemental Magic'].Fodder = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo="Dosis Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Jhakri Pigaches +2"}

	sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,range=empty,ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Zendik Robe",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {ammo="Pemphredo Tathlum",ear1="Regal Earring",ring1="Metamor. Ring +1"})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {ear1="Regal Earring",ring1="Metamor. Ring +1"})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {ammo="Pemphredo Tathlum",ear1="Regal Earring",ring1="Metamor. Ring +1"})
		
	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",
		head=empty,neck="Dls. Torque +1",ear1="Regal Earring",ear2="Snotra Earring",
		body="Twilight Cloak",hands="Leth. Gantherots +1",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enfeeble_jse_back,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Regal Gem",
		head="Atro. Chapeau +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.enfeeble_jse_back,waist="Fucho-no-Obi",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}

	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Regal Gem",
		head="Atro. Chapeau +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.enfeeble_jse_back,waist="Fucho-no-Obi",legs=gear.chironic_enfeeble_legs,feet="Jhakri Pigaches +2"}

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atrophy Chapeau +3",neck="Dls. Torque +1",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Sailfi Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atrophy Chapeau +3",neck="Dls. Torque +1",ear1="Regal Earring",ear2="Malignance Earring",
		body="Atrophy Tabard +3",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {
		head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +2"}
		
	sets.HPCure = {main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
		head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +3",hands="Kaykaus Cuffs",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
		back="Solemnity Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Iridal Staff",sub="Oneiros Grip",range=empty,ammo="Impatiens",
		head="Viti. Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Lengo Pants",feet=gear.chironic_refresh_feet}

	-- Idle sets
	sets.idle = {main="Daybreak",sub="Sacro Bulwark",ammo="Homiliary",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.enfeeble_jse_back,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.PDT = {main="Sakpata's Sword",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.idle.MDT = {main="Sakpata's Sword",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.Weak = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Homiliary",
		head="Viti. Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Lengo Pants",feet=gear.chironic_refresh_feet}

	sets.idle.DTHippo = set_combine(sets.idle.PDT, {back="Solemnity Cape",legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})

	-- Defense sets
	sets.defense.PDT = {main="Sakpata's Sword",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.MDT = {main="Sakpata's Sword",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MEVA = {main="Daybreak",sub="Sacro Bulwark",range=empty,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Sequence = {main="Sequence",sub="Sacro Bulwark"}
	sets.weapons.Naegling = {main="Naegling",sub="Sacro Bulwark"}
	sets.weapons.Almace = {main="Almace",sub="Sacro Bulwark"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Machaera +2"}
	sets.weapons.DualWeaponsAcc = {main="Naegling",sub="Almace"}
	sets.weapons.DualEvisceration = {main="Tauret",sub="Almace"}
	sets.weapons.DualAeolian = {main="Tauret",sub="Daybreak"}
	sets.weapons.DualProcDaggers = {main="Blurred Knife +1",sub="Atoyac"}
	sets.weapons.EnspellOnly = {main="Wind Knife",sub="Wind Knife",range="Kaja Bow",ammo="Beetle Arrow"}
	sets.weapons.DualClubs = {main="Nehushtan",sub="Nehushtan"}
	sets.weapons.DualBlackHalo = {main="Kaja Rod",sub="Thibron"}
	sets.weapons.DualAlmace = {main="Almace",sub="Sequence"}
	sets.weapons.DualBow = {main="Naegling",sub="Tauret",range="Kaja Bow"}
	sets.weapons.BowMacc = {range="Kaja Bow",ammo=empty}
	
	sets.buff.Sublimation = {}
	sets.buff.DTSublimation = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Ayanmo Ring",ring2="Petrov Ring",
		back=gear.da_jse_back,waist="Kentarch Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.EnspellOnly = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.da_jse_back,waist="Kentarch Belt +1",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Carmine Greaves +1"}	
		
	sets.engaged.FullAcc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Carmine Greaves +1"}

	sets.engaged.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Windbuffet Belt +1",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.FullAcc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.DW = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Ayanmo Ring",ring2="Petrov Ring",
		back=gear.da_jse_back,waist="Kentarch Belt +1",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
	sets.engaged.DW.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
	sets.engaged.DW.FullAcc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
	sets.engaged.DW.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Ilabrat Ring",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Ilabrat Ring",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DW.FullAcc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		body="Malignance Tabard",hands="Bunzi's Gloves",ring1="Defending Ring",ring2="Ramuh Ring +1",
		back="Solemnity Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 2)
	else
		set_macro_page(1, 2)
	end
end

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 2')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 2')
			else
				windower.chat.input('/lockstyleset 2') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 2')
			else
				windower.chat.input('/lockstyleset 2') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 2')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 2')
			else
				windower.chat.input('/lockstyleset 2') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 2')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 2')
	else
		windower.chat.input('/lockstyleset 2')
	end
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
		{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Always'},
		{Name='Reraise',		Buff='Reraise',		SpellID=135,	When='Always'},
	},
	
	AutoMelee = {
		{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Engaged'},
		{Name='Temper II',		Buff='Multi Strikes',SpellID=895,	When='Engaged'},
	},
	
	Default = {
		{Name='Refresh III',	Buff='Refresh',		SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',		SpellID=511,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Shell V',		Buff='Shell',		SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',		SpellID=47,		Reapply=false},
	},

	MageBuff = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Gain-MND',		Buff='MND Boost',		SpellID=491,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	FullMeleeBuff = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Barfire',		Buff='Barfire',			SpellID=60,		Reapply=false},
		{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
	},
	
	MeleeBuff = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Barblizzard',	Buff='Barblizzard',		SpellID=61,		Reapply=false},
		{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
	},

	Odin = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Enaero',			Buff='Enaero',			SpellID=102,	Reapply=false},
		--{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
	
	HybridCleave = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Enthunder II',	Buff='Enthunder II',	SpellID=316,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
}
