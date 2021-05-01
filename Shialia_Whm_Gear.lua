-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.fc_jse_cape = {name="Alaunus's Cape",augments={'MND+20','"Fast Cast"+10',}}

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Izcalli",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Izcalli",sub="Nehushtan"}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		--main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		--head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		--body="Inyanga Jubbah +2",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
		--back="Perimede Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		--ammo="Sapience Orb", --2
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2", --14
		hands="Fanatic Gloves", --7
		legs="Aya. Cosciales +2", --6
		feet="Regal Pumps +1", --7
		neck="Baetyl Pendant", --4
		ear1="Loquacious Earring", --2
		ear2="Etiolation Earring", --1
		ring1="Lebeche Ring",
		ring2="Weather. Ring", --6(4)
		back=gear.fc_jse_cape, --10
		waist="Embla Sash", --5
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +1"})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		--feet="Hygieia Clogs +1"
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Thuellaic Ecu +1"})

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Briault +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Piety Briault +1",hands="Telchine Gloves",
		waist="Chaac Belt",back="Aurist's Cape +1"}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Buquwik Cape",waist="Fotia Belt",legs="Inyanga Shalwar +2",feet="Gende. Galosh. +1"}
		
	sets.precast.WS.Dagan = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Kaykaus Bliaut",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Buquwik Cape",waist="Fotia Belt",legs="Inyanga Shalwar +2",feet="Gende. Galosh. +1"}
		
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

	--sets.precast.WS['Flash Nova'] = {}

	--sets.precast.WS['Mystic Boon'] = {}

	-- Midcast Sets

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=gear.chironic_treasure_hands,feet=gear.chironic_treasure_feet})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {
		--neck="Phalaina Locket",
		ring1="Kunaji Ring",
		--ring2="Asklepian Ring",
		waist="Gishdubar Sash"
	}
	sets.Cure_Received = {
		--neck="Phalaina Locket",
		ring1="Kunaji Ring",
		--ring2="Asklepian Ring",
		waist="Gishdubar Sash"
	}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {
		main=gear.grioavolr_fc_staff,
		--sub="Umbra Strap",
		--ammo="Hasty Pinion +1",
		head="Vanya Hood",
		neck="Incanter's Torque",
		--ear1="Gifted Earring",
		ear2="Gwati Earring",
		--body="Vedic Coat",
		hands="Shrieker's Cuffs",
		--ring1="Kishar Ring",
		--ring2="Prolix Ring",
		back="Solemnity Cape",
		waist="Austerity Belt",
		legs="Vanya Slops",
		--feet="Medium's Sabots"
	}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}

	sets.midcast.FastRecast = {
		--main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		--head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		--body="Inyanga Jubbah +2",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		--back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		head="Nahtirah Hat",
		neck="Baetyl Pendant",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",
		hands="Fanatic Gloves",
		ring1="Lebeche Ring",
		ring2="Weather. Ring",
		waist="Witful Belt",
		legs="Aya. Cosciales +2",
		feet="Regal Pumps +1"
	}
		
	-- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Theo. Briault +2",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		main="Queller Rod", --15(+2)/(-15)
		sub="Sors Shield", --3/(-5)
		--ammo="Esper Stone +1", --0/(-5)
		ammo="Hydrocera",
		head="Gende. Caubeen +1", --18/(-8)
		body="Theo. Briault +1",
		hands="Theophany Mitts +2", --(+4)/(-7)
		legs="Ebers Pant. +1",
		-- feet="Piety Duckbills +1", --10/(-5)
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		ear1="Glorious Earring", -- (+2)/(-5)
		ear2="Nourish. Earring +1",
		--ear2="Meili Earring",
		ring1="Lebeche Ring", --3/(-5)
		ring2={name="Haoma's Ring", bag="wardrobe2"},
		back=gear.fc_jse_cape,
		--waist="Bishop's Sash",
		waist="Cleric's Belt",
	}
		
	sets.midcast.CureSolace = {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Ebers Bliaud +1",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		main="Queller Rod", --15(+2)/(-15)
		sub="Sors Shield", --3/(-5)
		--ammo="Esper Stone +1", --0/(-5)
		ammo="Hydrocera",
		head="Gende. Caubeen +1", --18/(-8)
		body="Ebers Bliaud +1",
		hands="Theophany Mitts +2", --(+4)/(-7)
		legs="Ebers Pant. +1",
		-- feet="Piety Duckbills +1", --10/(-5)
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		ear1="Glorious Earring", -- (+2)/(-5)
		ear2="Nourish. Earring +1",
		--ear2="Meili Earring",
		ring1="Lebeche Ring", --3/(-5)
		ring2={name="Haoma's Ring", bag="wardrobe2"},
		back=gear.fc_jse_cape,
		--waist="Bishop's Sash",
		waist="Cleric's Belt",
	}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
		--main="Chatoyant Staff",sub="Curatio Grip",ammo="Esper Stone +1",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		--body="Kaykaus Bliaut",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Lebeche Ring",
		--back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		main="Iridal Staff", --10
		sub="Achaq Grip", --0/(-4)
		hands="Kaykaus Cuffs", --17
		back="Twilight Cape",
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, {
		--main="Chatoyant Staff",sub="Curatio Grip",ammo="Esper Stone +1",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Ebers Bliaud +1",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Lebeche Ring",
		--back="Alaunus's Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		main="Iridal Staff", --10
		sub="Achaq Grip", --0/(-4)
		hands="Kaykaus Cuffs", --17
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Ebers Bliaud +1",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Alaunus's Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		--body="Theo. Briault +2",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		back="Twilight Cape",
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Theo. Briault +2",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"
	})

	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {
		--main="Chatoyant Staff",sub="Curatio Grip",ammo="Esper Stone +1",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		--body="Kaykaus Bliaut",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Lebeche Ring",
		--back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		main="Iridal Staff", --10
		sub="Achaq Grip", --0/(-4)
		hands="Kaykaus Cuffs", --17
		back="Twilight Cape",
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {
		--main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		--body="Theo. Briault +2",hands="Theophany Mitts +3",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		back="Twilight Cape",
		--waist="Hachirin-no-Obi",
	})

	sets.midcast.Cure.DT = {main="Queller Rod",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Ayanmo Corazza +2",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.fc_jse_cape,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Gende. Galosh. +1"}
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {
		--ammo="Pemphredo Tathlum",
		--head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Glorious Earring",
		--body="Theo. Briault +2",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Lebeche Ring",
		--back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"
		ammo="Hydrocera",
		head="Gende. Caubeen +1", --18/(-8)
		body="Theo. Briault +1",
		hands="Theophany Mitts +2", --(+4)/(-7)
		legs="Ebers Pant. +1",
		-- feet="Piety Duckbills +1", --10/(-5)
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		ear1="Glorious Earring", -- (+2)/(-5)
		ear2="Nourish. Earring +1",
		--ear2="Meili Earring",
		ring1="Lebeche Ring", --3/(-5)
		ring2={name="Haoma's Ring", bag="wardrobe2"},
		back=gear.fc_jse_cape,
		--waist="Bishop's Sash",
		waist="Cleric's Belt",
	}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {
		--main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		--head="Ebers Cap +1",neck="Debilis Medallion",ear1="Meili Earring",ear2="Malignance Earring",
		--body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		--back="Alaunus's Cape",waist="Witful Belt",legs="Th. Pant. +3",feet="Vanya Clogs"
		--main="Yagrush",
		--sub="Chanter's Shield",
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Fanatic Gloves", --15
		legs="Theo. Pant. +1", --17
		feet="Vanya Clogs", --5
		neck="Malison Medallion", --10
		ear1="Beatific Earring",
		ear2="Meili Earring",
		ring1="Ephedra Ring",
		ring2={name="Haoma's Ring", bag="wardrobe2"},
		back=gear.fc_jse_cape,
		--waist="Bishop's Sash",
		waist="Cleric's Belt",
	}

	sets.midcast.StatusRemoval = {
		--main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		--head="Ebers Cap +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		--body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		--back="Swith Cape +1",waist="Witful Belt",legs="Ebers Pant. +1",feet="Regal Pumps +1"
		--main="Yagrush",
		--sub="Chanter's Shield",
		head="Ebers Cap +1",
		body="Inyanga Jubbah +2",
		hands="Fanatic Gloves",
		legs="Aya. Cosciales +2",
		feet="Regal Pumps +1",
		neck="Baetyl Pendant",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		ring1="Ephedra Ring",
		ring2={name="Haoma's Ring", bag="wardrobe2"},
		back=gear.fc_jse_cape,
		waist="Witful Belt",
	}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		--main=gear.gada_enhancing_club,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		--head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		--body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Perimede Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Theo. Duckbills +3"
		main=gear.gada_enhancing_club,
		--sub="Ammurapi Shield",
		sub="Thuellaic Ecu +1",
		head=gear.telchine_enh_head,
		body=gear.telchine_enh_body,
		--hands="Dynasty Mitts",
		hands=gear.telchine_enh_hands,
		legs=gear.telchine_enh_legs,
		feet="Theo. Duckbills +2",
		neck="Incanter's Torque",
		ear1="Mimir Earring",
		ear2="Andoaa Earring",
		--ring1={name="Stikini Ring", bag="wardrobe3"},
		ring2="Stikini Ring",
		--back="Fi Follet Cape +1",
		waist="Embla Sash",
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		--ear2="Earthcry Earring",
		--waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})
	
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		--sub="Ammurapi Shield",
		--hands="Regal Cuffs",
		--waist="Emphatikos Rope",
		--legs="Shedir Seraweels"
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Inyanga Tiara +2",body="Piety Briault +1",hands="Ebers Mitts",legs="Theo. Pant. +1",})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Theo. Duckbills +2",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Theo. Duckbills +2",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Embla Sash"})
	
	sets.midcast.BarElement = {main="Beneficus",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Ebers Cap +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Ebers Bliaud +1",hands="Ebers Mitts",ring1="Stikini Ring +1",ring2="Stikini Ring",
		back="Alaunus's Cape",waist="Olympus Sash",legs="Piety Pantaln. +1",feet="Ebers Duckbills"}

	sets.midcast.Impact = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Twilight Cloak",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back="Toro Cape",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head=empty,
		body="Twilight Cloak",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Shiva Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Crematio Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Divine Magic'] = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="C. Palug Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}
		
	sets.midcast.Holy = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,legs="Gyve Trousers",feet=gear.chironic_nuke_feet}

	sets.midcast['Dark Magic'] = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Inyanga Jubbah +2",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}

	sets.midcast.Drain = {
		--main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Inyanga Jubbah +2",hands=gear.chironic_enfeeble_hands,ring1="Evanescence Ring",ring2="Archon Ring",
		--back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back=gear.fc_jse_cape,
	}

	sets.midcast.Drain.Resistant = {
		--main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Chironic Doublet",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back=gear.fc_jse_cape,
	}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Dispel = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Nahtirah Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Theophany Briault +2",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Uk'uxkaj Boots"
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body="Theophany Briault +2",hands="Theophany Mitts +3",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Theo. Duckbills +3"
		main="Daybreak",
		sub="Thuellaic Ecu +1",
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs=gear.chironic_enfeeble_legs,
		feet="Theo. Duckbills +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.fc_jse_cape,
	}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Porous Rope"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Porous Rope"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back=gear.fc_jse_cape})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back=gear.fc_jse_cape})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		--main="Chatoyant Staff",sub="Oneiros Grip",ammo="Homiliary",
		--head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		--body="Ebers Bliaud +1",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		--back="Umbra Cape",waist="Fucho-no-obi",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet
		main="Iridal Staff",
		--waist="Shinjutsu-no-Obi +1",
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		--main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		--head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		--body="Witching Robe",hands=gear.chironic_refresh_hands,ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Moonlight Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Inyanga Tiara +2",
		body="Shamash Robe",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Aya. Gambieras +1",
		neck="Bathy Choker +1",
		--ear1="Genmei Earring",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
		--ring1={name="Stikini Ring", bag="wardrobe3"},
		--ring2="Sheltered Ring",
		ring1="Gelatinous Ring +1",
		ring2="Inyanga Ring",
		back="Solemnity Cape",
		--waist="Slipor Sash",
	}

	sets.idle.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet}
		
	sets.idle.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet}
		
	sets.idle.Weak = {
		--main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		--head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		--body="Witching Robe",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		--back="Umbra Cape",waist="Witful Belt",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Inyanga Tiara +2",
		body="Shamash Robe",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Aya. Gambieras +1",
		neck="Bathy Choker +1",
		--ear1="Genmei Earring",
		ear1="Moonshade Earring",
		ear2="Etiolation Earring",
		--ring1={name="Stikini Ring", bag="wardrobe3"},
		--ring2="Sheltered Ring",
		ring1="Gelatinous Ring +1",
		ring2="Inyanga Ring",
		back="Solemnity Cape",
		--waist="Slipor Sash",
	}

	-- Defense sets

	sets.defense.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet=gear.chironic_refresh_feet}

	sets.defense.MDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Flax Sash",legs="Th. Pant. +3",feet="Gende. Galosh. +1"}

	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Telchine Cap",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
		-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Basic set for if no TP weapon is defined.
	sets.engaged = {ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
		back="Kayapa Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

	sets.engaged.Acc = {ammo="Hasty Pinion +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
		back="Kayapa Cape",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

	sets.engaged.DW = {ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
		back="Kayapa Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

	sets.engaged.DW.Acc = {ammo="Hasty Pinion +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
		back="Kayapa Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",legs="Shedir Seraweels",feet=""}

	sets.HPCure = {main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Blistering Sallet +1",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Alaunus's Cape",waist="Eschan Stone",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end

function user_job_lockstyle()
	if player.sub_job == 'SCH' or player.sub_job == 'BLM' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 1')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 1')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 1')
	else
		windower.chat.input('/lockstyleset 1')
	end
end