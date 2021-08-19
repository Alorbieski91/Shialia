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
	gear.obi_high_nuke_waist = "Sacro Cord"

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
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back=gear.idle_jse_back}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +1"}

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Merlinic Jubbah",ring1="Lebeche Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}

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
		body="Twilight Cloak",ring1="Lebeche Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}
		
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Loquac. Earring",ear2="Malignance Earring",
		body="Merlinic Jubbah",ring1="Lebeche Ring",
		back=gear.mndenfeeb_jse_back,waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}

	sets.midcast.Geomancy = {main="Solstice",sub="Genmei Shield",
		head=gear.telchine_enh_head,neck="Bagua Charm +1",ear1="Magnetic Earring",ear2="Gifted Earring",
		body="Bagua Tunic +1",hands="Shrieker's Cuffs",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Austerity Belt",legs="Vanya Slops",feet=gear.merlinic_conservemp_feet}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back=gear.idle_jse_back,legs="Bagua Pants +1",feet="Azimuth Gaiters +1"})

	sets.midcast.Cure = {main="Daybreak",sub="Sors Shield",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Vanya Slops",feet="Vanya Clogs"}

	sets.midcast.LightWeatherCure = {main="Iridal Staff",sub="Enki Strap",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back="Twilight Cape",waist="Sacro Cord",legs="Vanya Slops",feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {main="Daybreak",sub="Sors Shield",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Vanya Robe",hands=gear.telchine_enh_hands,ring1="Ephedra Ring",ring2="Janniston Ring",
		back="Twilight Cape",waist="Sacro Cord",legs="Vanya Slops",feet="Vanya Clogs"}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {main="Daybreak",sub="Sors Shield"})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Culminus",ammo="Ghastly Tathlum",
		head="Mallquis Chapeau +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Mallquis Cuffs +1",ring1="Tamas Ring",ring2="Mallquis Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Mallquis Trews +1",feet="Mallquis Clogs +2"}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum",
		head=gear.merlinic_nuke_head,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Mallquis Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
		head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Seidr Cotehardie",hands="Hagondes Cuffs +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}

	sets.midcast['Elemental Magic'].Fodder = {main="Daybreak",sub="Culminus",ammo="Ghastly Tathlum",
		head="Mallquis Chapeau +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Mallquis Cuffs +1",ring1="Tamas Ring",ring2="Mallquis Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Mallquis Trews +1",feet="Mallquis Clogs +2"}

	sets.midcast['Elemental Magic'].HighTierNuke = {main="Daybreak",sub="Culminus",ammo="Ghastly Tathlum",
		head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Tamas Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum",
		head=gear.merlinic_nuke_head,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {main="Daybreak",sub="Culminus",ammo="Ghastly Tathlum",
		head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Malignance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Tamas Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet=gear.merlinic_nuke_feet}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Culminus",range="Dunna",
		head="Bagua Galero +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Evanescence Ring",
		back=gear.nuke_jse_back,waist="Fucho-no-Obi",legs="Mallquis Trews +1",feet=gear.merlinic_conservemp_feet}

	sets.midcast.Drain = {main="Rubicundity",sub="Culminus",range="Dunna",
		head="Bagua Galero +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Mallquis Saio +2",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Evanescence Ring",
		back=gear.nuke_jse_back,waist="Fucho-no-Obi",legs="Mallquis Trews +1",feet=gear.merlinic_conservemp_feet}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

	sets.midcast.Impact = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head=empty,neck="Bagua Charm +1",ear1="Gwati Earring",ear2="Malignance Earring",
		body="Twilight Cloak",hands="Geo. Mitaines +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet="Geo. Sandals +2"}

	sets.midcast.Dispel = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Bagua Charm +1",ear1="Vor Earring",ear2="Malignance Earring",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Sacro Cord",legs="Jhakri Slops +2",feet="Geo. Sandals +2"}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {
		main="Daybreak",
		--sub="Ammurapi Shield"
		sub="Genmei Shield"
	})

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Bagua Charm +1",ear1="Vor Earring",ear2="Malignance Earring",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Ea Slops",feet="Geo. Sandals +2"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Bagua Charm +1",ear1="Vor Earring",ear2="Malignance Earring",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.mndenfeeb_jse_back,waist="Sacro Cord",legs="Ea Slops",feet="Geo. Sandals +2"}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring2="Stikini Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring2="Stikini Ring"})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring"})

	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Genmei Shield",range="Dunna",
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
		head="Befouled Crown",neck="Twilight Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back="Sloemnity Cape",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",range="Dunna",
		head="Befouled Crown",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Bagua Mitaines +1",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back=gear.idle_jse_back,legs="Assid. Pants +1",feet="Mallquis Clogs +2"}

	sets.idle.PDT = {main="Malignance Pole",range="Dunna",
		head="Befouled Crown",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back=gear.idle_jse_back,legs="Assid. Pants +1",feet="Mallquis Clogs +2"}

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {main="Bolelabunga",sub="Genmei Shield",range="Dunna",
		head=gear.telchine_pet_head,neck="Twilight Torque",ear1="Handler's Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back=gear.idle_jse_back,waist="Isa Belt",legs=gear.telchine_pet_legs,feet="Bagua Sandals +1"}

	sets.idle.PDT.Pet = {main="Malignance Pole",range="Dunna",
		head=gear.telchine_pet_head,neck="Twilight Torque",ear1="Handler's Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back=gear.idle_jse_back,waist="Isa Belt",legs=gear.telchine_pet_legs,feet="Bagua Sandals +1"}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Twilight Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands=gear.merlinic_refresh_hands,ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back="Sloemnity Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Mallquis Clogs +2"}

	-- Defense sets
	sets.defense.PDT = {main="Malignance Pole",sub="Enki Strap",ammo="Staunch Tathlum +1",
		head=gear.merlinic_nuke_head,neck="Twilight Torque",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Geo. Mitaines +2",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back="Sloemnity Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Mallquis Clogs +2"}

	sets.defense.MDT = {main="Malignance Pole",sub="Enki Strap",ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Mallquis Saio +2",hands="Geo. Mitaines +2",ring1="Gelatinous Ring +1",ring2="Fortified Ring",
		back="Sloemnity Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Mallquis Clogs +2"}
		
	sets.defense.MEVA = {main="Malignance Pole",sub="Enki Strap",ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1",neck="Warder's Charm",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Shamash Robe",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back=gear.idle_jse_back,waist="Luminary Sash",legs="Ea Slops",feet="Mallquis Clogs +2"}
		
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
