module 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        paused: 0x2::table::Table<u8, bool>,
        validator: 0x1::option::Option<vector<u8>>,
        chekin_reward: 0x2::table::Table<u8, u64>,
        max_checkin_days: u8,
        preying_time: u64,
        time_lock_withdrawal: u64,
        bird_energy: 0x2::table::Table<u16, u64>,
        worm_energy: 0x2::table::Table<u16, u64>,
        mating_energy: 0x2::table::Table<u16, u64>,
        prey_reward_b: 0x2::table::Table<u16, u64>,
        prey_reward_sb: 0x2::table::Table<u16, u64>,
        mating_time: u64,
        potion_energy: 0x2::table::Table<u16, u64>,
    }

    struct EventUpdateBonus has copy, drop, store {
        day: u8,
        amount_new: u64,
        amount_old: u64,
    }

    struct UpdatePreyRewardEvent has copy, drop {
        type: u16,
        reward_b_new: u64,
        reward_b_old: u64,
        reward_sb_new: u64,
        reward_sb_old: u64,
    }

    struct UpdateTime has copy, drop {
        type: u16,
        new_time: u64,
    }

    struct UpdateEnergyEvent has copy, drop {
        update_type: u16,
        type: u16,
        energy_new: u64,
        energy_old: u64,
    }

    public fun get_checkin_reward(arg0: &Config, arg1: u8) : u64 {
        assert!(0x2::table::contains<u8, u64>(&arg0.chekin_reward, arg1), 1010);
        *0x2::table::borrow<u8, u64>(&arg0.chekin_reward, arg1)
    }

    public fun get_energy(arg0: &Config, arg1: u16, arg2: u16) : u64 {
        let v0 = if (arg1 == 2003) {
            true
        } else if (arg1 == 2004) {
            true
        } else if (arg1 == 2001) {
            true
        } else {
            arg1 == 2002
        };
        assert!(v0, 1003);
        let v1 = if (arg1 == 2003) {
            &arg0.bird_energy
        } else if (arg1 == 2004) {
            &arg0.worm_energy
        } else if (arg1 == 2001) {
            &arg0.mating_energy
        } else {
            &arg0.potion_energy
        };
        assert!(0x2::table::contains<u16, u64>(v1, arg2), 1003);
        *0x2::table::borrow<u16, u64>(v1, arg2)
    }

    public fun get_max_checkin_days(arg0: &Config) : u8 {
        arg0.max_checkin_days
    }

    public fun get_prey_reward(arg0: &Config, arg1: u16) : (u64, u64) {
        assert!(0x2::table::contains<u16, u64>(&arg0.prey_reward_b, arg1), 1011);
        assert!(0x2::table::contains<u16, u64>(&arg0.prey_reward_sb, arg1), 1011);
        (*0x2::table::borrow<u16, u64>(&arg0.prey_reward_b, arg1), *0x2::table::borrow<u16, u64>(&arg0.prey_reward_sb, arg1))
    }

    public fun get_time_lock(arg0: &Config) : (u64, u64, u64) {
        (arg0.time_lock_withdrawal, arg0.preying_time, arg0.mating_time)
    }

    public fun get_validator(arg0: &Config) : 0x1::option::Option<vector<u8>> {
        arg0.validator
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, bool>(arg1);
        0x2::table::add<u8, bool>(&mut v0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_archive(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_checkin(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_mission(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), false);
        let v1 = Config{
            id                   : 0x2::object::new(arg1),
            paused               : v0,
            validator            : 0x1::option::none<vector<u8>>(),
            chekin_reward        : 0x2::table::new<u8, u64>(arg1),
            max_checkin_days     : 7,
            preying_time         : 86400000,
            time_lock_withdrawal : 2592000000,
            bird_energy          : 0x2::table::new<u16, u64>(arg1),
            worm_energy          : 0x2::table::new<u16, u64>(arg1),
            mating_energy        : 0x2::table::new<u16, u64>(arg1),
            prey_reward_b        : 0x2::table::new<u16, u64>(arg1),
            prey_reward_sb       : 0x2::table::new<u16, u64>(arg1),
            mating_time          : 86400000,
            potion_energy        : 0x2::table::new<u16, u64>(arg1),
        };
        let v2 = &mut v1;
        init_energy(v2);
        let v3 = &mut v1;
        init_reward(v3);
        0x2::transfer::share_object<Config>(v1);
    }

    fun init_energy(arg0: &mut Config) {
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 0, 5);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 1, 20);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 2, 60);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 3, 180);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 4, 420);
        0x2::table::add<u16, u64>(&mut arg0.bird_energy, 0, 10);
        0x2::table::add<u16, u64>(&mut arg0.bird_energy, 1, 40);
        0x2::table::add<u16, u64>(&mut arg0.bird_energy, 2, 120);
        0x2::table::add<u16, u64>(&mut arg0.bird_energy, 3, 360);
        0x2::table::add<u16, u64>(&mut arg0.bird_energy, 4, 840);
        0x2::table::add<u16, u64>(&mut arg0.mating_energy, 0, 5);
        0x2::table::add<u16, u64>(&mut arg0.mating_energy, 1, 10);
        0x2::table::add<u16, u64>(&mut arg0.mating_energy, 2, 25);
        0x2::table::add<u16, u64>(&mut arg0.mating_energy, 3, 50);
        0x2::table::add<u16, u64>(&mut arg0.mating_energy, 4, 100);
        0x2::table::add<u16, u64>(&mut arg0.potion_energy, 0, 5);
        0x2::table::add<u16, u64>(&mut arg0.potion_energy, 1, 10);
        0x2::table::add<u16, u64>(&mut arg0.potion_energy, 2, 25);
        0x2::table::add<u16, u64>(&mut arg0.potion_energy, 3, 50);
        0x2::table::add<u16, u64>(&mut arg0.potion_energy, 4, 100);
    }

    fun init_reward(arg0: &mut Config) {
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_b, 0, 10);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_b, 1, 20);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_b, 2, 30);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_b, 3, 40);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_b, 4, 50);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_sb, 0, 30);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_sb, 1, 60);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_sb, 2, 90);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_sb, 3, 120);
        0x2::table::add<u16, u64>(&mut arg0.prey_reward_sb, 4, 150);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 1, 10);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 2, 20);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 3, 30);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 4, 40);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 5, 50);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 6, 60);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 7, 70);
    }

    public fun pause_trigger(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u8, arg3: bool) {
        assert!(0x2::table::contains<u8, bool>(&arg1.paused, arg2), 1009);
        let v0 = 0x2::table::borrow_mut<u8, bool>(&mut arg1.paused, arg2);
        assert!(*v0 != arg3, 1002);
        *v0 = arg3;
    }

    public fun update_checkin_reward(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u8, arg3: u64) {
        assert!(arg2 >= 1 && arg2 <= arg1.max_checkin_days, 1001);
        0x2::table::add<u8, u64>(&mut arg1.chekin_reward, arg2, arg3);
        let v0 = EventUpdateBonus{
            day        : arg2,
            amount_new : arg3,
            amount_old : 0x2::table::remove<u8, u64>(&mut arg1.chekin_reward, arg2),
        };
        0x2::event::emit<EventUpdateBonus>(v0);
    }

    public fun update_energy(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u16, arg3: u16, arg4: u64) {
        let v0 = if (arg2 == 2003) {
            true
        } else if (arg2 == 2004) {
            true
        } else if (arg2 == 2001) {
            true
        } else {
            arg2 == 2002
        };
        assert!(v0, 1003);
        let v1 = if (arg2 == 2003) {
            &mut arg1.bird_energy
        } else if (arg2 == 2004) {
            &mut arg1.worm_energy
        } else if (arg2 == 2001) {
            &mut arg1.mating_energy
        } else {
            &mut arg1.potion_energy
        };
        assert!(0x2::table::contains<u16, u64>(v1, arg3), 1003);
        0x2::table::add<u16, u64>(v1, arg3, arg4);
        let v2 = UpdateEnergyEvent{
            update_type : arg2,
            type        : arg3,
            energy_new  : arg4,
            energy_old  : 0x2::table::remove<u16, u64>(v1, arg3),
        };
        0x2::event::emit<UpdateEnergyEvent>(v2);
    }

    public fun update_max_checkin_days(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u8) {
        arg1.max_checkin_days = arg2;
    }

    public fun update_prey_reward(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u16, arg3: u64, arg4: u64) {
        assert!(0x2::table::contains<u16, u64>(&arg1.prey_reward_b, arg2), 1011);
        assert!(0x2::table::contains<u16, u64>(&arg1.prey_reward_sb, arg2), 1011);
        0x2::table::add<u16, u64>(&mut arg1.prey_reward_b, arg2, arg3);
        0x2::table::add<u16, u64>(&mut arg1.prey_reward_sb, arg2, arg4);
        let v0 = UpdatePreyRewardEvent{
            type          : arg2,
            reward_b_new  : arg3,
            reward_b_old  : 0x2::table::remove<u16, u64>(&mut arg1.prey_reward_b, arg2),
            reward_sb_new : arg4,
            reward_sb_old : 0x2::table::remove<u16, u64>(&mut arg1.prey_reward_sb, arg2),
        };
        0x2::event::emit<UpdatePreyRewardEvent>(v0);
    }

    public fun update_time(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut Config, arg2: u16, arg3: u64) {
        let v0 = if (arg2 == 2005) {
            true
        } else if (arg2 == 2001) {
            true
        } else {
            arg2 == 2006
        };
        assert!(v0, 1003);
        if (arg2 == 2005) {
            arg1.preying_time = arg3;
        } else if (arg2 == 2001) {
            arg1.mating_time = arg3;
        } else if (arg2 == 2006) {
            arg1.time_lock_withdrawal = arg3;
        };
        let v1 = UpdateTime{
            type     : arg2,
            new_time : arg3,
        };
        0x2::event::emit<UpdateTime>(v1);
    }

    public fun update_validator(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: vector<u8>, arg2: &mut Config) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1007);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun validate_bird_type(arg0: &Config, arg1: u16) {
        assert!(0x2::table::contains<u16, u64>(&arg0.bird_energy, arg1), 1003);
    }

    public fun validate_boost(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.preying_time, 1008);
    }

    public fun validate_checkin_day(arg0: &Config, arg1: u8) {
        assert!(0x2::table::contains<u8, u64>(&arg0.chekin_reward, arg1), 1004);
    }

    public fun validate_paused(arg0: &Config, arg1: u8) {
        assert!(0x2::table::contains<u8, bool>(&arg0.paused, arg1), 1009);
        assert!(!*0x2::table::borrow<u8, bool>(&arg0.paused, arg1), 1002);
    }

    public fun validate_worm_type(arg0: &Config, arg1: u16) {
        assert!(0x2::table::contains<u16, u64>(&arg0.worm_energy, arg1), 1003);
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 1005);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 1006);
    }

    // decompiled from Move bytecode v6
}

