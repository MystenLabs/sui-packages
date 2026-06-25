module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::off_hours {
    struct OffHoursConfig has copy, drop, store {
        session_status: u8,
        session_opened_at_ms: u64,
        transition_duration_ms: u64,
        transition_leverage_pct_bps: u64,
        transition_oi_cap_pct_bps: u64,
        mm_liquidity_gone: bool,
        mm_margin_surcharge_bps: u64,
        enhanced_funding_active: bool,
    }

    struct OffHoursRegistry has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<vector<u8>, OffHoursConfig>,
    }

    struct TierCaps has copy, drop, store {
        new_market_reduce_only: bool,
        new_limit_allowed: bool,
        new_limit_post_only_only: bool,
        max_leverage_factor_bps: u64,
    }

    struct OffHoursPolicy has key {
        id: 0x2::object::UID,
        retail: TierCaps,
        institutional: TierCaps,
        vault_operator: TierCaps,
        last_updated_ts_ms: u64,
    }

    struct SessionStatusChanged has copy, drop {
        symbol: vector<u8>,
        old_status: u8,
        new_status: u8,
    }

    struct TransitionStarted has copy, drop {
        symbol: vector<u8>,
        started_at_ms: u64,
        duration_ms: u64,
    }

    struct TransitionEnded has copy, drop {
        symbol: vector<u8>,
        ended_at_ms: u64,
    }

    struct MMLiquidityDisappeared has copy, drop {
        symbol: vector<u8>,
    }

    struct MMLiquidityRestored has copy, drop {
        symbol: vector<u8>,
    }

    struct EnhancedFundingTriggered has copy, drop {
        symbol: vector<u8>,
        mark_price: u64,
        index_price: u64,
        deviation_bps: u64,
    }

    struct EnhancedFundingCleared has copy, drop {
        symbol: vector<u8>,
    }

    struct OffHoursConfigRegistered has copy, drop {
        symbol: vector<u8>,
        transition_duration_ms: u64,
    }

    struct ScheduledTransitionsSet has copy, drop {
        symbol: vector<u8>,
        transition_count: u64,
    }

    struct OffHoursPolicyUpdated has copy, drop {
        role: u8,
        caps: TierCaps,
        admin: address,
        ts_ms: u64,
    }

    fun assert_valid_role(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 11);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun calendar_state_closed() : u8 {
        0
    }

    public fun calendar_state_halted() : u8 {
        4
    }

    public fun calendar_state_open() : u8 {
        1
    }

    public fun calendar_state_post_market() : u8 {
        3
    }

    public fun calendar_state_pre_market() : u8 {
        2
    }

    public fun caps_for_role(arg0: &OffHoursPolicy, arg1: u8) : TierCaps {
        assert_valid_role(arg1);
        if (arg1 == 0) {
            arg0.retail
        } else if (arg1 == 1) {
            arg0.institutional
        } else {
            arg0.vault_operator
        }
    }

    public fun check_enhanced_funding_deviation(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 == 0 || arg0 == 0) {
            return (false, 0)
        };
        let v0 = compute_deviation_bps(arg0, arg1);
        (v0 > 300, v0)
    }

    public fun check_off_hours_rules(arg0: &mut OffHoursRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        if (!0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg0.configs, arg1);
        if (v0.mm_liquidity_gone && !arg3) {
            abort 5
        };
        let v1 = if (v0.mm_liquidity_gone) {
            if (arg5 > 0) {
                if (arg4 > 0) {
                    arg6 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = arg6 * 10000 / v0.mm_margin_surcharge_bps;
            let v3 = if (v2 == 0) {
                1
            } else {
                v2
            };
            assert!((arg5 as u128) <= (arg4 as u128) * (v3 as u128), 6);
        };
        let v4 = get_effective_session_status_internal(v0, arg2);
        if (v0.session_status == 1 && v4 == 0) {
            v0.session_status = 0;
            v0.enhanced_funding_active = false;
            let v5 = TransitionEnded{
                symbol      : arg1,
                ended_at_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<TransitionEnded>(v5);
            let v6 = SessionStatusChanged{
                symbol     : arg1,
                old_status : 1,
                new_status : 0,
            };
            0x2::event::emit<SessionStatusChanged>(v6);
        };
        if (arg3) {
            return
        };
        if (v4 == 1) {
            if (arg11 > 0 && arg12 > 0) {
                let v7 = compute_deviation_bps(arg11, arg12);
                if (v7 > 300 && !v0.enhanced_funding_active) {
                    v0.enhanced_funding_active = true;
                    let v8 = EnhancedFundingTriggered{
                        symbol        : arg1,
                        mark_price    : arg11,
                        index_price   : arg12,
                        deviation_bps : v7,
                    };
                    0x2::event::emit<EnhancedFundingTriggered>(v8);
                };
                if (v7 <= 300 && v0.enhanced_funding_active) {
                    v0.enhanced_funding_active = false;
                    let v9 = EnhancedFundingCleared{symbol: arg1};
                    0x2::event::emit<EnhancedFundingCleared>(v9);
                };
            };
            let v10 = arg6 * v0.transition_leverage_pct_bps / 10000;
            let v11 = if (v10 == 0) {
                1
            } else {
                v10
            };
            assert!((arg5 as u128) <= (arg4 as u128) * (v11 as u128), 3);
            assert!((arg8 as u128) + (arg9 as u128) + (arg10 as u128) <= (arg7 as u128) * (v0.transition_oi_cap_pct_bps as u128) / (10000 as u128), 4);
        };
    }

    public fun clear_enhanced_funding(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2).enhanced_funding_active = false;
        let v0 = EnhancedFundingCleared{symbol: arg2};
        0x2::event::emit<EnhancedFundingCleared>(v0);
    }

    public fun close_session(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        let v0 = 0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2);
        v0.session_status = 2;
        v0.enhanced_funding_active = false;
        let v1 = SessionStatusChanged{
            symbol     : arg2,
            old_status : v0.session_status,
            new_status : 2,
        };
        0x2::event::emit<SessionStatusChanged>(v1);
    }

    fun compute_deviation_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (((v0 as u128) * (10000 as u128) / (arg1 as u128)) as u64)
    }

    public fun config_exists(arg0: &OffHoursRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1)
    }

    public fun default_transition_duration_ms() : u64 {
        1800000
    }

    public fun e_config_already_exists() : u64 {
        1
    }

    public fun e_config_not_found() : u64 {
        0
    }

    public fun e_invalid_calendar_state() : u64 {
        10
    }

    public fun e_invalid_max_leverage_factor() : u64 {
        12
    }

    public fun e_invalid_role() : u64 {
        11
    }

    public fun e_invalid_schedule_input() : u64 {
        9
    }

    public fun e_mm_liquidity_gone() : u64 {
        5
    }

    public fun e_mm_margin_insufficient() : u64 {
        6
    }

    public fun e_session_closed() : u64 {
        2
    }

    public fun e_transition_leverage_exceeded() : u64 {
        3
    }

    public fun e_transition_oi_cap_breached() : u64 {
        4
    }

    public fun effective_max_leverage_bps(arg0: &OffHoursPolicy, arg1: u8, arg2: u8, arg3: u64) : u64 {
        if (arg2 == 0) {
            arg3
        } else {
            let v1 = caps_for_role(arg0, arg1);
            arg3 * v1.max_leverage_factor_bps / 10000
        }
    }

    public fun enhanced_funding_deviation_bps() : u64 {
        300
    }

    public fun get_effective_session_status(arg0: &OffHoursRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock) : u8 {
        if (!0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1)) {
            return 0
        };
        get_effective_session_status_internal(0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), arg2)
    }

    fun get_effective_session_status_internal(arg0: &OffHoursConfig, arg1: &0x2::clock::Clock) : u8 {
        if (arg0.session_status != 1) {
            return arg0.session_status
        };
        if (0x2::clock::timestamp_ms(arg1) >= arg0.session_opened_at_ms + arg0.transition_duration_ms && !arg0.enhanced_funding_active) {
            0
        } else {
            1
        }
    }

    public fun get_mm_margin_surcharge(arg0: &OffHoursRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).mm_margin_surcharge_bps
    }

    public fun get_session_opened_at(arg0: &OffHoursRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).session_opened_at_ms
    }

    public fun get_session_status(arg0: &OffHoursRegistry, arg1: vector<u8>) : u8 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).session_status
    }

    public fun get_transition_duration(arg0: &OffHoursRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).transition_duration_ms
    }

    public fun get_transition_leverage_pct(arg0: &OffHoursRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).transition_leverage_pct_bps
    }

    public fun get_transition_oi_cap_pct(arg0: &OffHoursRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).transition_oi_cap_pct_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OffHoursRegistry{
            id      : 0x2::object::new(arg0),
            configs : 0x2::table::new<vector<u8>, OffHoursConfig>(arg0),
        };
        0x2::transfer::share_object<OffHoursRegistry>(v0);
    }

    public entry fun init_policy(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OffHoursPolicy{
            id                 : 0x2::object::new(arg2),
            retail             : new_tier_caps(true, false, false, 5000),
            institutional      : new_tier_caps(true, true, false, 7500),
            vault_operator     : new_tier_caps(true, true, true, 10000),
            last_updated_ts_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::share_object<OffHoursPolicy>(v0);
    }

    public fun is_admit_allowed(arg0: &OffHoursPolicy, arg1: u8, arg2: u8, arg3: u8, arg4: bool, arg5: bool) : bool {
        if (arg2 == 0) {
            return true
        };
        let v0 = caps_for_role(arg0, arg1);
        arg3 == 1 && (!v0.new_market_reduce_only || arg4) || arg3 == 0 && v0.new_limit_allowed && (!v0.new_limit_post_only_only || arg5)
    }

    public fun is_enhanced_funding_active(arg0: &OffHoursRegistry, arg1: vector<u8>) : bool {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).enhanced_funding_active
    }

    public fun is_mm_liquidity_gone(arg0: &OffHoursRegistry, arg1: vector<u8>) : bool {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg0.configs, arg1), 0);
        0x2::table::borrow<vector<u8>, OffHoursConfig>(&arg0.configs, arg1).mm_liquidity_gone
    }

    public fun new_tier_caps(arg0: bool, arg1: bool, arg2: bool, arg3: u64) : TierCaps {
        TierCaps{
            new_market_reduce_only   : arg0,
            new_limit_allowed        : arg1,
            new_limit_post_only_only : arg2,
            max_leverage_factor_bps  : arg3,
        }
    }

    public fun off_hours_policy_last_updated_ts_ms(arg0: &OffHoursPolicy) : u64 {
        arg0.last_updated_ts_ms
    }

    public fun open_session(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        let v0 = 0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2);
        assert!(v0.session_status == 2, 7);
        v0.session_status = 1;
        v0.session_opened_at_ms = 0x2::clock::timestamp_ms(arg3);
        v0.enhanced_funding_active = false;
        let v1 = SessionStatusChanged{
            symbol     : arg2,
            old_status : v0.session_status,
            new_status : 1,
        };
        0x2::event::emit<SessionStatusChanged>(v1);
        let v2 = TransitionStarted{
            symbol        : arg2,
            started_at_ms : v0.session_opened_at_ms,
            duration_ms   : v0.transition_duration_ms,
        };
        0x2::event::emit<TransitionStarted>(v2);
    }

    public fun order_type_limit() : u8 {
        0
    }

    public fun order_type_market() : u8 {
        1
    }

    public fun register_config(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 1);
        let v0 = OffHoursConfig{
            session_status              : 2,
            session_opened_at_ms        : 0,
            transition_duration_ms      : 1800000,
            transition_leverage_pct_bps : 5000,
            transition_oi_cap_pct_bps   : 5000,
            mm_liquidity_gone           : false,
            mm_margin_surcharge_bps     : 15000,
            enhanced_funding_active     : false,
        };
        0x2::table::add<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2, v0);
        let v1 = OffHoursConfigRegistered{
            symbol                 : arg2,
            transition_duration_ms : 1800000,
        };
        0x2::event::emit<OffHoursConfigRegistered>(v1);
    }

    public fun restore_mm_liquidity(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2).mm_liquidity_gone = false;
        let v0 = MMLiquidityRestored{symbol: arg2};
        0x2::event::emit<MMLiquidityRestored>(v0);
    }

    public fun role_institutional() : u8 {
        1
    }

    public fun role_retail() : u8 {
        0
    }

    public fun role_vault_operator_eligible() : u8 {
        2
    }

    public fun session_closed() : u8 {
        2
    }

    public fun session_open() : u8 {
        0
    }

    public fun session_transition() : u8 {
        1
    }

    public fun set_mm_liquidity_gone(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2).mm_liquidity_gone = true;
        let v0 = MMLiquidityDisappeared{symbol: arg2};
        0x2::event::emit<MMLiquidityDisappeared>(v0);
    }

    public fun tier_caps_max_leverage_factor_bps(arg0: &TierCaps) : u64 {
        arg0.max_leverage_factor_bps
    }

    public fun tier_caps_new_limit_allowed(arg0: &TierCaps) : bool {
        arg0.new_limit_allowed
    }

    public fun tier_caps_new_limit_post_only_only(arg0: &TierCaps) : bool {
        arg0.new_limit_post_only_only
    }

    public fun tier_caps_new_market_reduce_only(arg0: &TierCaps) : bool {
        arg0.new_market_reduce_only
    }

    public entry fun update_tier_caps(arg0: &mut OffHoursPolicy, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg2: u8, arg3: TierCaps, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_valid_role(arg2);
        assert!(arg3.max_leverage_factor_bps <= 10000, 12);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2 == 0) {
            arg0.retail = arg3;
        } else if (arg2 == 1) {
            arg0.institutional = arg3;
        } else {
            arg0.vault_operator = arg3;
        };
        arg0.last_updated_ts_ms = v0;
        let v1 = OffHoursPolicyUpdated{
            role  : arg2,
            caps  : arg3,
            admin : 0x2::tx_context::sender(arg5),
            ts_ms : v0,
        };
        0x2::event::emit<OffHoursPolicyUpdated>(v1);
    }

    public fun update_transition_params(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut OffHoursRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64) {
        assert!(0x2::table::contains<vector<u8>, OffHoursConfig>(&arg1.configs, arg2), 0);
        assert!(arg3 > 0, 8);
        assert!(arg4 > 0 && arg4 <= 10000, 8);
        assert!(arg5 > 0 && arg5 <= 10000, 8);
        let v0 = 0x2::table::borrow_mut<vector<u8>, OffHoursConfig>(&mut arg1.configs, arg2);
        v0.transition_duration_ms = arg3;
        v0.transition_leverage_pct_bps = arg4;
        v0.transition_oi_cap_pct_bps = arg5;
    }

    // decompiled from Move bytecode v7
}

