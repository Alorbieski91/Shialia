-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

	gear.fc_jse_cape = {name="Alaunus's Cape",augments={'MND+20','"Fast Cast"+10',}}
	gear.enf_jse_cape = {name="Alaunus's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity-10',}}

	include('User/Global-WHM-Binds.lua')

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
	
	sets.buff.Sublimation = {}
	sets.buff.DTSublimation = {}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Nahtirah Hat",neck="Baetyl Pendant",ear1="Loquacious Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.fc_jse_cape,waist="Embla Sash",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +1"})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Bliaut +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Piety Bliaut +1",hands="Telchine Gloves",
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
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=gear.chironic_treasure_hands})
	
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
	
	sets.ConserveMP = {main="Rubicundity",sub="Ammurapi Shield",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Gwati Earring",
		hands="Shrieker's Cuffs",
		back="Solemnity Cape",waist="Austerity Belt",legs="Vanya Slops",feet="Medium's Sabots"}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}

	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Nahtirah Hat",neck="Baetyl Pendant",ear1="Loquacious Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.fc_jse_cape,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}
		
	-- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {main="Queller Rod",sub="Sors Shield",ammo="Hydrocera",
		head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourish. Earring +1",
		body="Theo. Bliaut +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Janniston Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs="Ebers Pant. +1",feet="Vanya Clogs"}
		
	sets.midcast.CureSolace = {main="Queller Rod",sub="Sors Shield",ammo="Hydrocera",
		head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourish. Earring +1",
		body="Ebers Bliaut +1",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Janniston Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs="Ebers Pant. +1",feet="Vanya Clogs"}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Iridal Staff",sub="Achaq Grip",hands="Kaykaus Cuffs",back="Twilight Cape",waist="Hachirin-no-Obi",})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, {main="Iridal Staff",sub="Achaq Grip",hands="Kaykaus Cuffs",waist="Hachirin-no-Obi",})

	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, {waist="Hachirin-no-Obi",})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi",})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {main="Iridal Staff",sub="Achaq Grip",hands="Kaykaus Cuffs",back="Twilight Cape",waist="Hachirin-no-Obi"})

	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi",})

	sets.midcast.Cure.DT = {main="Queller Rod",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Ayanmo Corazza +2",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.enf_jse_cape,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Gende. Galosh. +1"}
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {ammo="Hydrocera",
		head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourish. Earring +1",
		body="Theo. Bliaut +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Janniston Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs="Ebers Pant. +1",feet="Vanya Clogs"}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",
		head="Ebers Cap +1",neck="Malison Medallion",ear1="Beatific Earring",ear2="Meili Earring",
		body="Ebers Bliaut +1",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Haoma's Ring",
		back=gear.fc_jse_cape,waist="Sacro Cord",legs="Theo. Pant. +1",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = {
		head="Ebers Cap +1",neck="Baetyl Pendant",ear1="Loquacious Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Haoma's Ring",
		back=gear.fc_jse_cape,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",
		head=gear.telchine_enh_head,neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body=gear.telchine_enh_body,hands=gear.telchine_enh_hands,ring2="Stikini Ring",
		waist="Embla Sash",legs=gear.telchine_enh_legs,feet="Theo. Duckbills +2"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})
	
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		sub="Ammurapi Shield",
		--hands="Regal Cuffs",
		--waist="Emphatikos Rope",
		--legs="Shedir Seraweels"
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Inyanga Tiara +2",body="Piety Bliaut +1",hands="Ebers Mitts +1",legs="Theo. Pant. +1",})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Theo. Duckbills +2",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Theo. Duckbills +2",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",waist="Embla Sash"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",waist="Embla Sash"})
	
	sets.midcast.BarElement = {main="Beneficus",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Ebers Cap +1",neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body="Ebers Bliaut +1",hands="Ebers Mitts +1",ring1="Stikini Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Olympus Sash",legs="Piety Pantaln. +1",feet="Ebers Duckbills +1"}

	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Twilight Cloak",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Shiva Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist="Sacro Cord",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Crematio Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist="Sacro Cord",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Hydrocera",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}
		
	sets.midcast.Holy = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist="Sacro Cord",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}

	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.enf_jse_cape,waist="Fucho-no-Obi",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}

	sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.enf_jse_cape,waist="Fucho-no-Obi",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Kishar Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Erra Pendant",ear1="Digni. Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Dispel = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Theo. Bliaut +2",hands="Inyan. Dastanas +2",ring1="Stikini Ring",ring2="Kishar Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Theo. Bliaut +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.enf_jse_cape,waist="Sacro Cord",legs=gear.chironic_enfeeble_legs,feet="Theo. Duckbills +2"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Sacro Cord"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Sacro Cord"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back=gear.fc_jse_cape})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back=gear.fc_jse_cape})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		main="Iridal Staff",
		--waist="Shinjutsu-no-Obi +1",
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Inyanga Tiara +2",neck="Bathy Choker +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Inyanga Ring",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Inyanga Shalwar +2",feet="Inyan. Crackows +2"}

	sets.idle.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet="Aya. Gambieras +2"}
		
	sets.idle.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Inyanga Shalwar +2",feet="Inyan. Crackows +2"}
		
	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Inyanga Tiara +2",neck="Bathy Choker +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Inyanga Ring",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Inyanga Shalwar +2",feet="Aya. Gambieras +2"}

	-- Defense sets

	sets.defense.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Flax Sash",legs="Inyanga Shalwar +2",feet="Aya. Gambieras +2"}

	sets.defense.MDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Shadow Ring",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Th. Pant. +3",feet="Inyan. Crackows +2"}

	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Telchine Cap",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Aurist's Cape +1",waist="Carrier's Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
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
	sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",legs="Shedir Seraweels",feet="Inyan. Crackows +2"}

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

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	When='Always'},
		{Name='Haste',			Buff='Haste',		SpellID=57,		When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Always'},
		{Name='Refresh',		Buff='Refresh',		SpellID=109,	When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		When='Always'},
	},
	Default = {
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	Reapply=false},
		{Name='Haste',			Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',		SpellID=53,		Reapply=false},
		{Name='Regen IV',		Buff='Regen',		SpellID=477,	Reapply=false},
		{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	Reapply=false},
		{Name='Boost-STR',		Buff='STR Boost',	SpellID=479,	Reapply=false},
		{Name='Shellra V',		Buff='Shell',		SpellID=134,	Reapply=false},
		{Name='Protectra V',	Buff='Protect',		SpellID=129,	Reapply=false},
		{Name='Barthundra',		Buff='Barthunder',	SpellID=70,		Reapply=false},
		{Name='Baramnesra',		Buff='Baramnesia',	SpellID=85,		Reapply=false},
		{Name='Auspice',		Buff='Auspice',		SpellID=96,		Reapply=false},
	},
	Melee = {
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	Reapply=false},
		{Name='Haste',			Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Boost-STR',		Buff='STR Boost',	SpellID=479,	Reapply=false},
		{Name='Shellra V',		Buff='Shell',		SpellID=134,	Reapply=false},
		{Name='Protectra V',	Buff='Protect',		SpellID=129,	Reapply=false},
		{Name='Auspice',		Buff='Auspice',		SpellID=96,		Reapply=false},
	},
	Lilith = {
		{Name='Reraise IV',		Buff='Reraise',		SpellID=848,	Reapply=false},
		{Name='Haste',			Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Regen IV',		Buff='Regen',		SpellID=477,	Reapply=false},
		{Name='Boost-STR',		Buff='STR Boost',	SpellID=479,	Reapply=false},
		{Name='Shellra V',		Buff='Shell',		SpellID=134,	Reapply=true},
		{Name='Protectra V',	Buff='Protect',		SpellID=129,	Reapply=true},
		{Name='Barfira',		Buff='Barfire',		SpellID=66,		Reapply=true},
		{Name='Baramnesra',		Buff='Baramnesia',	SpellID=85,		Reapply=true},
		{Name='Auspice',		Buff='Auspice',		SpellID=96,		Reapply=false},
	},
}
