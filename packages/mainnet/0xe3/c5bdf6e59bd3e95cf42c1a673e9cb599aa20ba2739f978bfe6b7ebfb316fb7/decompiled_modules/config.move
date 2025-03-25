module 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config {
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
    }

    struct EventUpdateBonus has copy, drop, store {
        day: u8,
        amount_new: u64,
        amount_old: u64,
    }

    struct UpdateWormEnergyEvent has copy, drop {
        type: u16,
        worm_energy_new: u64,
        worm_energy_old: u64,
    }

    struct UpdateBirdEnergyEvent has copy, drop {
        type: u16,
        bird_energy_new: u64,
        bird_energy_old: u64,
    }

    public fun get_bird_energy(arg0: &Config, arg1: u16) : u64 {
        *0x2::table::borrow<u16, u64>(&arg0.bird_energy, arg1)
    }

    public fun get_checkin_reward(arg0: &Config, arg1: u8) : (u8, u64) {
        (arg0.max_checkin_days, *0x2::table::borrow<u8, u64>(&arg0.chekin_reward, arg1))
    }

    public fun get_time_lock(arg0: &Config) : (u64, u64) {
        (arg0.time_lock_withdrawal, arg0.preying_time)
    }

    public fun get_validator(arg0: &Config) : 0x1::option::Option<vector<u8>> {
        arg0.validator
    }

    public fun get_worm_energy(arg0: &Config, arg1: u16) : u64 {
        *0x2::table::borrow<u16, u64>(&arg0.worm_energy, arg1)
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, bool>(arg1);
        0x2::table::add<u8, bool>(&mut v0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_archive(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_checkin(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_mission(), false);
        0x2::table::add<u8, bool>(&mut v0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_game(), false);
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
        };
        let v2 = &mut v1;
        init_checkin_reward(v2);
        0x2::transfer::share_object<Config>(v1);
    }

    fun init_checkin_reward(arg0: &mut Config) {
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 1, 10);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 2, 20);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 3, 30);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 4, 40);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 5, 50);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 6, 60);
        0x2::table::add<u8, u64>(&mut arg0.chekin_reward, 7, 70);
        assert!(0x2::table::length<u8, u64>(&arg0.chekin_reward) == (arg0.max_checkin_days as u64), 1001);
    }

    fun init_energy(arg0: &mut Config) {
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 0, 10);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 1, 20);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 2, 30);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 3, 40);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 4, 50);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 0, 30);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 1, 60);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 2, 90);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 3, 120);
        0x2::table::add<u16, u64>(&mut arg0.worm_energy, 4, 150);
    }

    public fun pause_trigger(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u8, arg3: bool) {
        assert!(0x2::table::contains<u8, bool>(&arg1.paused, arg2), 1009);
        let v0 = 0x2::table::borrow_mut<u8, bool>(&mut arg1.paused, arg2);
        assert!(*v0 != arg3, 1002);
        *v0 = arg3;
    }

    public fun update_bird_energy(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u16, arg3: u64) {
        assert!(0x2::table::contains<u16, u64>(&arg1.bird_energy, arg2), 1003);
        0x2::table::add<u16, u64>(&mut arg1.bird_energy, arg2, arg3);
        let v0 = UpdateBirdEnergyEvent{
            type            : arg2,
            bird_energy_new : arg3,
            bird_energy_old : 0x2::table::remove<u16, u64>(&mut arg1.bird_energy, arg2),
        };
        0x2::event::emit<UpdateBirdEnergyEvent>(v0);
    }

    public fun update_checkin_reward(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u8, arg3: u64) {
        assert!(arg2 >= 1 && arg2 <= arg1.max_checkin_days, 1001);
        0x2::table::add<u8, u64>(&mut arg1.chekin_reward, arg2, arg3);
        let v0 = EventUpdateBonus{
            day        : arg2,
            amount_new : arg3,
            amount_old : 0x2::table::remove<u8, u64>(&mut arg1.chekin_reward, arg2),
        };
        0x2::event::emit<EventUpdateBonus>(v0);
    }

    public fun update_max_checkin_days(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u8) {
        arg1.max_checkin_days = arg2;
    }

    public fun update_preying_time(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.preying_time = arg2;
    }

    public fun update_time_lock_withdrawal(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.time_lock_withdrawal = arg2;
    }

    public fun update_validator(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: vector<u8>, arg2: &mut Config) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1007);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun update_worm_energy(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::manager::AdminCap, arg1: &mut Config, arg2: u16, arg3: u64) {
        assert!(0x2::table::contains<u16, u64>(&arg1.worm_energy, arg2), 1003);
        0x2::table::add<u16, u64>(&mut arg1.worm_energy, arg2, arg3);
        let v0 = UpdateWormEnergyEvent{
            type            : arg2,
            worm_energy_new : arg3,
            worm_energy_old : 0x2::table::remove<u16, u64>(&mut arg1.worm_energy, arg2),
        };
        0x2::event::emit<UpdateWormEnergyEvent>(v0);
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

