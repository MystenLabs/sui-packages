module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_config {
    struct StakingConfig has key {
        id: 0x2::object::UID,
        cooldown_ms: u64,
        monthly_boost_bps: u64,
        max_boost_bps: u64,
        max_lock_months: u64,
        min_balance: u64,
    }

    struct STAKING_CONFIG has drop {
        dummy_field: bool,
    }

    struct EventConfigChange has copy, drop {
        property: 0x1::string::String,
        old_value: u64,
        new_value: u64,
    }

    public fun cooldown_ms(arg0: &StakingConfig) : u64 {
        arg0.cooldown_ms
    }

    fun emit_event(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = EventConfigChange{
            property  : 0x1::string::utf8(arg0),
            old_value : arg1,
            new_value : arg2,
        };
        0x2::event::emit<EventConfigChange>(v0);
    }

    fun init(arg0: STAKING_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingConfig{
            id                : 0x2::object::new(arg1),
            cooldown_ms       : 1209600000,
            monthly_boost_bps : 11000,
            max_boost_bps     : 30000,
            max_lock_months   : 12,
            min_balance       : 100000,
        };
        0x2::transfer::share_object<StakingConfig>(v0);
    }

    public fun max_boost_bps(arg0: &StakingConfig) : u64 {
        arg0.max_boost_bps
    }

    public fun max_lock_months(arg0: &StakingConfig) : u64 {
        arg0.max_lock_months
    }

    public fun min_balance(arg0: &StakingConfig) : u64 {
        arg0.min_balance
    }

    public fun monthly_boost_bps(arg0: &StakingConfig) : u64 {
        arg0.monthly_boost_bps
    }

    public fun set_all(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        set_cooldown_ms(arg0, arg1, arg2);
        set_max_lock_months(arg0, arg1, arg3);
        set_max_boost_bps(arg0, arg1, arg4);
        set_monthly_boost_bps(arg0, arg1, arg5);
        set_min_balance(arg0, arg1, arg6);
    }

    public fun set_cooldown_ms(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64) {
        assert!(arg2 >= 0, 100);
        assert!(arg2 <= 2592000000, 100);
        emit_event(b"cooldown_ms", arg0.cooldown_ms, arg2);
        arg0.cooldown_ms = arg2;
    }

    public fun set_max_boost_bps(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64) {
        assert!(arg2 >= 10500, 102);
        assert!(arg2 <= 150000, 102);
        emit_event(b"max_boost_bps", arg0.max_boost_bps, arg2);
        arg0.max_boost_bps = arg2;
    }

    public fun set_max_lock_months(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64) {
        assert!(arg2 >= 3, 101);
        assert!(arg2 <= 36, 101);
        emit_event(b"max_lock_months", arg0.max_lock_months, arg2);
        arg0.max_lock_months = arg2;
    }

    public fun set_min_balance(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64) {
        assert!(arg2 >= 1000, 104);
        assert!(arg2 <= 1000000000, 104);
        emit_event(b"min_balance", arg0.min_balance, arg2);
        arg0.min_balance = arg2;
    }

    public fun set_monthly_boost_bps(arg0: &mut StakingConfig, arg1: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin::StakingAdminCap, arg2: u64) {
        assert!(arg2 >= 10100, 103);
        assert!(arg2 <= 30000, 103);
        emit_event(b"monthly_boost_bps", arg0.monthly_boost_bps, arg2);
        arg0.monthly_boost_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

