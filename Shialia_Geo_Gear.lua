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

	autoindi = "Haste"
	autogeo = "Frailty"
	autoentrust = 'Fury'
	autoentrustee = 'Alltrium'

	include('User/Global-GEO-Binds.lua')

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
	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +2",back=gear.idle_jse_back}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +1"}

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {main=gear.gada_indi_club,sub="Ammurapi Shield"}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Agwu's Gages",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geomancy Pants +2",feet="Regal Pumps +1"}

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

	sets.precast.FC.Impact = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head=empty,neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Twilight Cloak",hands="Agwu's Gages",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geomancy Pants +2",feet="Regal Pumps +1"}
		
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Zendik Robe",ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geomancy Pants +2",feet="Regal Pumps +1"}

	sets.midcast.Geomancy = {main="Idris",sub="Genmei Shield",
		head=gear.telchine_enh_head,neck="Bagua Charm +1",ear1="Magnetic Earring",ear2="Gifted Earring",
		body="Bagua Tunic +1",hands="Shrieker's Cuffs",ring1="Defending Ring",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Austerity Belt",legs="Vanya Slops",feet=gear.merlinic_conservemp_feet}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back="Lifestream Cape",legs="Bagua Pants +1",feet="Azimuth Gaiters +1"})

	sets.midcast.Cure = {main="Daybreak",sub="Sors Shield",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Vanya Slops",feet="Vanya Clogs"}

	sets.midcast.LightWeatherCure = {main="Iridal Staff",sub="Enki Strap",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Vanya Slops",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {main="Daybreak",sub="Sors Shield",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Vanya Slops",feet="Vanya Clogs"}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {main="Daybreak",sub="Sors Shield"})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub="Culminus",ammo="Pemphredo Tathlum",
		head="Mall. Chapeau +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Mallquis Cuffs +2",ring1="Mallquis Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Mallquis Trews +2",feet="Mallquis Clogs +2"}

	sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Agwu's Cap",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Agwu's Robe",hands="Agwu's Gages",ring1="Shiva Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Agwu's Slops",feet="Bagua Sandals +3"}
		
	sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
		head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Seidr Cotehardie",hands="Hagondes Cuffs +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}

	sets.midcast['Elemental Magic'].Fodder = {main="Bunzi's Rod",sub="Culminus",ammo="Pemphredo Tathlum",
		head="Mall. Chapeau +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Mallquis Cuffs +2",ring1="Mallquis Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Mallquis Trews +2",feet="Mallquis Clogs +2"}

	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet="Bagua Sandals +3"}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Bagua Sandals +3"}

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet="Bagua Sandals +3"}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Bagua Galero +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Archon Ring",ring2="Evanescence Ring",
		back=gear.nuke_jse_back,waist="Fucho-no-Obi",legs="Geomancy Pants +2",feet="Agwu's Pigaches"}

	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Bagua Galero +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Archon Ring",ring2="Evanescence Ring",
		back=gear.nuke_jse_back,waist="Fucho-no-Obi",legs="Geomancy Pants +2",feet="Agwu's Pigaches"}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands="Agwu's Gages",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants +2",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Geomancy Pants +2",feet="Geo. Sandals +2"}

	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Bagua Charm +1",ear1="Regal Earring",ear2="Malignance Earring",
		body="Twilight Cloak",hands="Geo. Mitaines +3",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Geomancy Pants +2",feet="Geo. Sandals +2"}

	sets.midcast.Dispel = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Bagua Charm +1",ear1="Regal Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Geomancy Pants +2",feet="Geo. Sandals +2"}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, sets.TreasureHunter, {main="Daybreak",sub="Ammurapi Shield",feet=gear.merlinic_treasure_feet})

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Bagua Charm +1",ear1="Vor Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Stikini Ring",ring2="Kishar Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Geomancy Pants +2",feet="Geo. Sandals +2"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Geo. Galero +2",neck="Bagua Charm +1",ear1="Vor Earring",ear2="Malignance Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +3",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Geomancy Pants +2",feet="Geo. Sandals +2"}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring2="Kishar Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring2="Stikini Ring"})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring"})

	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",range="Dunna",
		head=gear.telchine_enh_head,neck="Incanter's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
		body=gear.telchine_enh_body,hands=gear.telchine_enh_hands,ring1="Lebeche Ring",ring2="Stikini Ring",
		back="Solemnity Cape",waist="Embla Sash",legs=gear.telchine_enh_legs,feet="Regal Pumps +1"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		sub="Ammurapi Shield",
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
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

	-- Idle sets
	sets.idle = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Carrier's Sash",legs="Assid. Pants +1",feet="Mallquis Clogs +2"}

	sets.idle.PDT = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Isa Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {main="Idris",sub="Genmei Shield",range="Dunna",
		head=gear.telchine_pet_head,neck="Bagua Charm +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Isa Belt",legs=gear.telchine_pet_legs,feet="Bagua Sandals +3"}

	sets.idle.PDT.Pet = {main="Idris",sub="Genmei Shield",range="Dunna",
		head="Nyame Helm",neck="Bagua Charm +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Isa Belt",legs="Nyame Flanchard",feet="Bagua Sandals +3"}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Assid. Pants +1",feet="Nyame Sollerets"}

	-- Defense sets
	sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flax Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.defense.MEVA = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Lugalbanda Earring",ear2="Eabani Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Vengeful Ring",Ring2="Purity Ring",
		back=gear.idle_jse_back,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Geo. Sandals +2"}
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
	sets.engaged = {main="Idris",sub="Genmei Shield",ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Kayapa Cape",waist="Witful Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.engaged.DW = {main="Idris",sub="Daybreak",ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Kayapa Cape",waist="Witful Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",
		head="Agwu's Cap",neck="Mizu. Kubikazari",
		body="Agwu's Robe",hands="Agwu's Gages",--ring1="Mujin Band",
		legs="Ea Slops",feet="Jhakri Pigaches +2"
	}
	sets.ResistantMagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",
		head="Agwu's Cap",neck="Mizu. Kubikazari",
		body="Agwu's Robe",hands="Agwu's Gages",--ring1="Mujin Band",
		legs="Ea Slops",feet="Jhakri Pigaches +2"
	}
	
	sets.buff.Sublimation = {}
	sets.buff.DTSublimation = {}
	
	-- Weapons sets
	sets.weapons.Nehushtan = {main='Nehushtan',sub='Genmei Shield'}
	sets.weapons.DualWeapons = {main='Nehushtan',sub='Nehushtan'}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 4)
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

buff_spell_lists = {
	Auto = {
		{Name='Haste',		Buff='Haste',		SpellID=57,		When='Always'},
		{Name='Refresh',	Buff='Refresh',		SpellID=109,	When='Always'},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		When='Always'},
	},

	Default = {
		{Name='Haste',		Buff='Haste',		SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',		SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Blink',		Buff='Blink',		SpellID=53,		Reapply=false},
		{Name='Regen',		Buff='Regen',		SpellID=108,	Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',		SpellID=106,	Reapply=false},
	},
}

function default_post_midcast(spell, spellMap, eventArgs)

	if not eventArgs.handled then
		if not job_post_midcast and is_nuke(spell, spellMap) and state.MagicBurstMode.value ~= 'Off' and sets.MagicBurst then
			equip(sets.MagicBurst)
		end

		if spell.target.type == 'SELF' and spellMap then
			if spellMap:contains('Cure') then
				if curecheat then
					if sets.HPCure then
						equip(sets.HPCure)
					end
					curecheat = false
				elseif sets.Self_Healing then
					if sets.Self_Healing.SIRD and state.CastingMode.value:contains('SIRD') and (player.in_combat or being_attacked) then
						equip(sets.Self_Healing.SIRD)
					else
						equip(sets.Self_Healing)
					end
				end
			elseif spellMap == 'Refresh' and sets.Self_Refresh then
				equip(sets.Self_Refresh)
			end
		end
		
		set_elemental_obi_cape_ring(spell, spellMap)
		
		if state.Capacity.value == true then
			if set.contains(spell.targets, 'Enemy') then
				if spell.skill == 'Elemental Magic' or spell.skill == 'Blue Magic' or spell.action_type == 'Ranged Attack' then
					equip(sets.Capacity)
				end
			end
		end
		
		if sets.Reive and buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
			if sets.Reive.neck == "Arciela's Grace +1" then
				equip(sets.Reive)
			end
		end
		
		if state.TreasureMode.value ~= 'None' and spell.target.type == 'MONSTER' and not info.tagged_mobs[spell.target.id] and not spell.english:startswith('Geo-') then
			equip(sets.TreasureHunter)
		end
		
		if state.DefenseMode.value ~= 'None' and spell.action_type == 'Magic' and (player.in_combat or being_attacked) then
			if sets.midcast[spell.english] and sets.midcast[spell.english].DT then
				equip(sets.midcast[spell.english].DT)
			elseif sets.midcast[spellMap] and sets.midcast[spellMap].DT then
				equip(sets.midcast[spellMap].DT)
			elseif sets.midcast[spell.skill] and sets.midcast[spell.skill].DT then
				equip(sets.midcast[spell.skill].DT)
			elseif sets.midcast.FastRecast.DT then
				equip(sets.midcast.FastRecast.DT)
			else
				handle_equipping_gear(player.status)
			end

			if spell.target.type == 'SELF' and spellMap and spellMap:contains('Cure') and sets.Self_Healing and sets.Self_Healing.DT then
				equip(sets.Self_Healing.DT)

			end
			
			eventArgs.handled = true
		end
	
	end
	
	if buffactive.doom then
		equip(sets.buff.Doom)
	end
end