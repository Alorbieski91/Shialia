function user_job_setup()

	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Nehushtan','DualWeapons')

	gear.nuke_jse_back = {name="Nantosuelta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	gear.idle_jse_back = {name="Nantosuelta's Cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Pet: "Regen"+5',}}
	gear.mndenfeeb_jse_back = {name="Nantosuelta's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	autoindi = "Fury"
	autogeo = "Frailty"
	autoentrust = 'Haste'
	autoentrustee = 'Alltrium'

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')

	indi_duration = 290

	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic",back=gear.idle_jse_back}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +1"}

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		--ammo="Impatiens",
		head="Amalric Coif",
		neck="Baetyl Pendant",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		--ear2="Malignance Earring",
		--body="Zendik Robe",
		ring1="Lebeche Ring",
		ring2="Weather. Ring",
		back=gear.mndenfeeb_jse_back,
		waist="Witful Belt",
		legs="Geo. Pants +1",
		feet="Regal Pumps +1"
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {body="Mallquis Saio +2",ear2="Malignance Earring",hands="Bagua Mitaines +1"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main=gear.grioavolr_fc_staff,sub="Clerisy Strap"})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

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
	sets.Self_Refresh = {
		--back="Grapevine Cape",
		waist="Gishdubar Sash",
		--feet="Inspirited Boots"
	}
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {
		--ammo="Impatiens",
		--head=empty,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		--body="Twilight Cloak",hands="Volte Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		--back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		--ammo="Impatiens",
		head=empty,
		body="Twilight Cloak",
		neck="Baetyl Pendant",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		--ear2="Malignance Earring",
		--body="Zendik Robe",
		ring1="Lebeche Ring",
		ring2="Weather. Ring",
		back=gear.mndenfeeb_jse_back,
		waist="Witful Belt",
		legs="Geo. Pants +1",
		feet="Regal Pumps +1"
	}
		
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {
		--main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		--head="Amalric Coif",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		--body="Zendik Robe",hands="Volte Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		--back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		--ammo="Impatiens",
		head="Amalric Coif",
		neck="Baetyl Pendant",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		--ear2="Malignance Earring",
		--body="Zendik Robe",
		ring1="Lebeche Ring",
		ring2="Weather. Ring",
		back=gear.mndenfeeb_jse_back,
		waist="Witful Belt",
		legs="Geo. Pants +1",
		feet="Regal Pumps +1"
	}

	sets.midcast.Geomancy = {
		--main="Solstice",sub="Genmei Shield",range="Dunna",
		--head="Vanya Hood",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Malignance Earring",
		--body="Vedic Coat",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Dark Ring",
		--back="Solemnity Cape",waist="Austerity Belt +1",legs="Vanya Slops",feet="Medium's Sabots"
		main="Solstice",
		sub="Genmei Shield",
		--head="Bagua Galero +3",
		head="Azimuth Hood +1",
		body="Bagua Tunic",
		hands="Shrieker's Cuffs",
		legs="Vanya Slops",
		feet=gear.merlinic_conservemp_feet,
		left_ear="Magnetic Earring",
		right_ear="Mendi. Earring",
		neck="Incanter's Torque",
		--ring1={name="Stikini Ring", bag="wardrobe3"},
		ring2={name="Stikini Ring", bag="wardrobe4"},
		back="Lifestream Cape",
		waist="Austerity Belt",
		--waist="Shinjutsu-no-Obi +1",
	}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back=gear.idle_jse_back,legs="Bagua Pants +1",feet="Azimuth Gaiters +1"})

	sets.midcast.Cure = {
		--main=gear.gada_healing_club,sub="Sors Shield",ammo="Hasty Pinion +1",
		--head="Amalric Coif",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
		--body="Zendik Robe",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Menelaus's Ring",
		--back="Tempered Cape +1",waist="Witful Belt",legs="Geo. Pants +1",feet="Vanya Clogs"
		main="Daybreak",
		sub="Sors Shield",
		range="Dunna",
		head="Vanya Hood",
		body="Vanya Robe",
		hands=gear.telchine_enh_hands,
		legs="Vanya Slops",
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		waist="Porous Rope",
		left_ear="Meili Earring",
		right_ear="Mendi. Earring",
		left_ring="Ephedra Ring",
		right_ring="Haoma's Ring",
		back=gear.mndenfeeb_jse_back,
	}

	sets.midcast.LightWeatherCure = {main="Iridal Staff",sub="Curatio Grip",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Geo. Pants +1",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {main="Daybreak",sub="Sors Shield",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Zendik Robe",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Lebeche Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Geo. Pants +1",feet="Vanya Clogs"}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {main="Daybreak",sub="Sors Shield"})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		--head=gear.merlinic_nuke_head,neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Friomisi Earring",
		--body=gear.merlinic_nuke_body,hands="Mallquis Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
		--back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
		main="Daybreak",
		sub="Culminus",
		range="Dunna",
		head="Mallquis Chapeau +1",
		body="Mallquis Saio +2",
		hands="Mallquis Cuffs +1",
		legs="Mallquis Trews +1",
		feet="Mallquis Clogs +2",
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Tamas Ring",
		right_ring="Mallquis Ring",
		back=gear.nuke_jse_back,
	}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.merlinic_nuke_head,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Mallquis Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
		head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Seidr Cotehardie",hands="Hagondes Cuffs +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}

	sets.midcast['Elemental Magic'].Fodder = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		--head=gear.merlinic_nuke_head,neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Friomisi Earring",
		--body=gear.merlinic_nuke_body,hands="Mallquis Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
		--back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
		main="Daybreak",
		sub="Culminus",
		range="Dunna",
		head="Mallquis Chapeau +1",
		body="Mallquis Saio +2",
		hands="Mallquis Cuffs +1",
		legs="Mallquis Trews +1",
		feet="Mallquis Clogs +2",
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Tamas Ring",
		right_ring="Mallquis Ring",
		back=gear.nuke_jse_back,
	}

	sets.midcast['Elemental Magic'].HighTierNuke = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		--body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Freke Ring",
		--back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
		main="Solstice",
		sub="Culminus",
		range="Dunna",
		head=gear.merlinic_nuke_head,
		body="Shamash Robe",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet=gear.merlinic_nuke_feet,
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Tamas Ring",
		right_ring="Metamor. Ring +1",
		back=gear.nuke_jse_back,
	}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.merlinic_nuke_head,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head=gear.merlinic_nuke_head,neck="Saevus Pendant +1",ear1="Regal Earring",ear2="Malignance Earring",
		--body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Freke Ring",
		--back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
		main="Solstice",
		sub="Culminus",
		range="Dunna",
		head=gear.merlinic_nuke_head,
		body="Shamash Robe",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet=gear.merlinic_nuke_feet,
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Tamas Ring",
		right_ring="Metamor. Ring +1",
		back=gear.nuke_jse_back,
	}

	sets.midcast['Dark Magic'] = {
		--main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head=gear.merlinic_nuke_head,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		--body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet
		main="Daybreak",
		sub="Culminus",
		range="Dunna",
		head="Bagua Galero",
		body="Mallquis Saio +2",
		hands="Mallquis Cuffs +1",
		legs="Mallquis Trews +1",
		feet=gear.merlinic_conservemp_feet,
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Moonshade Earring",
		right_ear="Gwati Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back=gear.nuke_jse_back,
	}

	sets.midcast.Drain = {
		--main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		--body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Archon Ring",ring2="Evanescence Ring",
		--back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet
		main="Daybreak",
		sub="Culminus",
		range="Dunna",
		head="Bagua Galero",
		body="Mallquis Saio +2",
		hands="Mallquis Cuffs +1",
		legs="Mallquis Trews +1",
		feet=gear.merlinic_conservemp_feet,
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Moonshade Earring",
		right_ear="Gwati Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back=gear.nuke_jse_back,
	}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

	sets.midcast.Impact = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		--body="Twilight Cloak",hands="Regal Cuffs",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
		main="Daybreak",
		sub="Genmei Shield",
		range="Dunna",
		head=empty,
		body="Twilight Cloak",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet="Mallquis Clogs +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.mndenfeeb_jse_back,
	}

	sets.midcast.Dispel = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Amalric Coif",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		--body="Zendik Robe",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet
		main="Daybreak",
		sub="Genmei Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet="Mallquis Clogs +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.nuke_jse_back,
	}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {
		main="Daybreak",
		--sub="Ammurapi Shield"
		sub="Genmei Shield"
	})

	sets.midcast['Enfeebling Magic'] = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring",
		--back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"
		main="Daybreak",
		sub="Genmei Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet="Mallquis Clogs +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.mndenfeeb_jse_back,
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		--main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		--head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		--body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		--back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"
		main="Daybreak",
		sub="Genmei Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Mallquis Cuffs +1",
		legs="Ea Slops",
		feet="Mallquis Clogs +2",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Vor Earring",
		right_ear="Gwati Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring",
		back=gear.mndenfeeb_jse_back,
	}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Stikini Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Stikini Ring"})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring"})

	sets.midcast['Enhancing Magic'] = {
		--main=gear.gada_enhancing_club,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		--head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		--body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Perimede Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"
		main=gear.gada_enhancing_club,
		sub="Genmei Shield",
		range="Dunna",
		head=gear.telchine_enh_head,
		body=gear.telchine_enh_body,
		hands=gear.telchine_enh_hands,
		legs=gear.telchine_enh_legs,
		feet="Regal Pumps +1",
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Lebeche Ring",
		right_ring="Tamas Ring",
		back="Solemnity Cape",
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		--ear2="Earthcry Earring",
		--waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		sub="Genmei Shield",
		head="Amalric Coif",
		--hands="Regal Cuffs",
		--waist="Emphatikos Rope",
		--legs="Shedir Seraweels"
	})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {main="Iridal Staff",sub="Oneiros Grip",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

	-- Idle sets
	sets.idle = {
		--main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		--head="Befouled Crown",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		--body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Stikini Ring",ring2="Stikini Ring",
		--back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet
		main="Bolelabunga",
		sub="Genmei Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Bagua Mitaines +1",
		legs="Assid. Pants +1",
		feet="Mallquis Clogs +2",
		neck="Bathy Choker +1",
		left_ear="Moonshade Earring",
		right_ear="Etiolation Earring",
		ring1="Gelatinous Ring +1",
		ring2="Fortified Ring",
		back=gear.idle_jse_back,
		--waist="Slipor Sash",
	}

	sets.idle.PDT = {
		--main="Malignance Pole",sub="Umbra Strap",ammo="Staunch Tathlum +1",
		--head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		--body="Jhakri Robe +2",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Shadow Ring",
		--back="Shadow Mantle",waist="Flax Sash",legs="Hagondes Pants +1",feet="Mallquis Clogs +2"
		main="Malignance Pole",
		head="Befouled Crown",
		range="Dunna",
		body="Shamash Robe",
		hands="Geo. Mitaines +1",
		legs="Assid. Pants +1",
		feet="Mallquis Clogs +2",
		neck="Bathy Choker +1",
		left_ear="Moonshade Earring",
		right_ear="Etiolation Earring",
		ring1="Gelatinous Ring +1",
		ring2="Fortified Ring",
		back=gear.idle_jse_back,
		--waist="Slipor Sash",
	}

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		--main="Sucellus",sub="Genmei Shield",range="Dunna",
		--head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Handler's Earring",ear2="Handler's Earring +1",
		--body="Jhakri Robe +2",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Dark Ring",
		--back=gear.idle_jse_back,waist="Isa Belt",legs="Psycloth Lappas",feet="Bagua Sandals +1"
		main="Bolelabunga",
		sub="Genmei Shield",
		range="Dunna",
		head="Azimuth Hood +1",
		body="Shamash Robe",
		hands="Geo. Mitaines +1",
		legs=gear.telchine_pet_legs,
		feet="Bagua Sandals +1",
		neck="Twilight Torque",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		ring1="Gelatinous Ring +1", --7/(-1)/0/0
		ring2="Fortified Ring",
		--ring2="Defending Ring", --10/10/0/0
		back=gear.idle_jse_back,
		waist="Isa Belt" --0/0/3/1
	}

	sets.idle.PDT.Pet = {
		--main="Malignance Pole",sub="Umbra Strap",range="Dunna",
		--head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Handler's Earring",ear2="Handler's Earring +1",
		--body="Jhakri Robe +2",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Dark Ring",
		--back=gear.idle_jse_back,waist="Isa Belt",legs="Hagondes Pants +1",feet="Bagua Sandals +1"
		main="Malignance Pole",
		range="Dunna",
		head="Azimuth Hood +1",
		body="Shamash Robe",
		hands="Geo. Mitaines +1",
		legs=gear.telchine_pet_legs,
		feet="Bagua Sandals +1",
		neck="Twilight Torque",
		--ear1="Lugalbanda Earring",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		ring1="Gelatinous Ring +1", --7/(-1)/0/0
		ring2="Fortified Ring",
		--ring2="Defending Ring", --10/10/0/0
		back=gear.idle_jse_back,
		waist="Isa Belt" --0/0/3/1
	}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Azimuth Gaiters +1"}

	-- Defense sets
	sets.defense.PDT = {main="Malignance Pole",sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Azimuth Gaiters +1"}

	sets.defense.MDT = {main="Malignance Pole",sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Mallquis Saio +2",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Azimuth Gaiters +1"}
		
	sets.defense.MEVA = {main="Malignance Pole",sub="Enki Strap",ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body=gear.merlinic_nuke_body,hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back=gear.idle_jse_back,waist="Luminary Sash",legs="Telchine Braconi",feet="Azimuth Gaiters +1"}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Geomancy Sandals"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +2"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Jhakri Robe +2",hands="Gazu Bracelet +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Kayapa Cape",waist="Witful Belt",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.DW = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Jhakri Robe +2",hands="Regal Cuffs",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Kayapa Cape",waist="Witful Belt",legs="Assid. Pants +1",feet="Battlecast Gaiters"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {
		--main=gear.grioavolr_nuke_staff,
		--sub="Alber Strap",
		--head="Ea Hat",
		--neck="Mizu. Kubikazari",
		--body="Ea Houppelande",
		--ring1="Mujin Band",
		legs="Ea Slops",
		feet="Jhakri Pigaches +1"
	}
	sets.ResistantMagicBurst = {
		--main=gear.grioavolr_nuke_staff,
		--sub="Enki Strap",
		--head="Ea Hat",
		--neck="Mizu. Kubikazari",
		--body="Ea Houppelande",
		--ring1="Mujin Band",
		legs="Ea Slops",
		feet="Jhakri Pigaches +1"
	}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Weapons sets
	sets.weapons.Nehushtan = {main='Nehushtan',sub='Genmei Shield'}
	sets.weapons.DualWeapons = {main='Nehushtan',sub='Nehushtan'}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end

function user_job_lockstyle()
	if player.sub_job == 'RDM' or player.sub_job == 'WHM' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 3')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 3')
			else
				windower.chat.input('/lockstyleset 3') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 3')
			else
				windower.chat.input('/lockstyleset 3') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 3')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 3')
			else
				windower.chat.input('/lockstyleset 3') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 3')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 3')
	else
		windower.chat.input('/lockstyleset 3')
	end
end