module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::mark_price {
    struct MarkPriceState has copy, drop, store {
        oracle_price: u64,
        mark_price: u64,
        basis_ema: u64,
        basis_ema_is_negative: bool,
        tau_off_hours_ms: u64,
        tau_basis_ema_ms: u64,
        impact_notional_usd_e8: u64,
        max_per_update_bps: u64,
        last_close_oracle: u64,
        last_perp_mid: u64,
        last_update_ms: u64,
        last_session_flag: u8,
    }

    struct MarkPriceRegistry has key {
        id: 0x2::object::UID,
        states: 0x2::table::Table<0x2::object::ID, MarkPriceState>,
    }

    struct Ipd has copy, drop {
        value: u64,
        is_negative: bool,
    }

    struct MarkPriceUpdated has copy, drop {
        market_id: 0x2::object::ID,
        new_mark_price: u64,
        oracle_price: u64,
        perp_mid_price: u64,
        session_flag: u8,
        timestamp_ms: u64,
    }

    struct MarkPriceRegistered has copy, drop {
        market_id: 0x2::object::ID,
        initial_price: u64,
    }

    struct MarkPriceParamsUpdated has copy, drop {
        market_id: 0x2::object::ID,
        tau_off_hours_ms: u64,
        tau_basis_ema_ms: u64,
        max_per_update_bps: u64,
        impact_notional_usd_e8: u64,
    }

    public fun mark_price(arg0: &MarkPriceState) : u64 {
        arg0.mark_price
    }

    fun advance_oracle_off_hours(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = compute_ipd(arg1, arg2, arg0);
        let v1 = if (arg3 > arg4 / 10) {
            arg4 / 10
        } else {
            arg3
        };
        let v2 = exp_neg_scaled(v1, arg4);
        let (v3, v4) = if (v0.is_negative) {
            if (v0.value >= arg0) {
                (0, true)
            } else {
                (arg0 - v0.value, false)
            }
        } else {
            (arg0 + v0.value, false)
        };
        let v5 = if (v4) {
            (((v2 as u128) * (arg0 as u128) / (1000000000 as u128)) as u64)
        } else {
            ((((v2 as u128) * (arg0 as u128) + ((1000000000 - v2) as u128) * (v3 as u128)) / (1000000000 as u128)) as u64)
        };
        clamp_to_bps_bound(v5, arg0, arg5)
    }

    public fun assert_fresh(arg0: &MarkPriceState, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_update_ms;
        if (v0 > v1) {
            assert!(v0 - v1 <= 60000, 6);
        };
    }

    public fun assert_fresh_by_market(arg0: &MarkPriceRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg0.states, arg1), 0);
        assert_fresh(0x2::table::borrow<0x2::object::ID, MarkPriceState>(&arg0.states, arg1), arg2);
    }

    public fun basis_ema(arg0: &MarkPriceState) : u64 {
        arg0.basis_ema
    }

    public fun basis_ema_is_negative(arg0: &MarkPriceState) : bool {
        arg0.basis_ema_is_negative
    }

    fun clamp_to_bps_bound(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg1 as u128) * (arg2 as u128) / 10000) as u64);
        if (arg0 > arg1) {
            if (arg0 - arg1 > v0) {
                arg1 + v0
            } else {
                arg0
            }
        } else if (arg1 - arg0 > v0) {
            arg1 - v0
        } else {
            arg0
        }
    }

    fun compute_ipd(arg0: u64, arg1: u64, arg2: u64) : Ipd {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            0
        };
        let v1 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            0
        };
        if (v0 >= v1) {
            Ipd{value: v0 - v1, is_negative: false}
        } else {
            Ipd{value: v1 - v0, is_negative: true}
        }
    }

    fun compute_mark(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64) : (u64, u64, bool) {
        let (v0, v1) = update_basis_ema(arg1, arg0, arg5, arg6, arg9, arg8);
        let v2 = if (v1) {
            if (v0 >= arg0) {
                0
            } else {
                arg0 - v0
            }
        } else {
            arg0 + v0
        };
        (median_of_3(arg0, v2, median_of_3(arg2, arg3, arg4)), v0, v1)
    }

    public fun default_impact_notional_usd_e8() : u64 {
        2000000000000
    }

    public fun default_max_per_update_bps() : u64 {
        25
    }

    public fun default_tau_basis_ema_ms() : u64 {
        150000
    }

    public fun default_tau_off_hours_ms() : u64 {
        1800000
    }

    fun exp_neg_scaled(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 1000000000
        };
        let v0 = (1000000000 as u128);
        let v1 = (arg0 as u128) * v0 / (arg1 as u128);
        let v2 = v1 * v1 / v0;
        let v3 = v0 + v2 / 2;
        let v4 = v1 + v2 * v1 / v0 / 6;
        if (v4 >= v3) {
            0
        } else {
            ((v3 - v4) as u64)
        }
    }

    public fun get_mark_price(arg0: &MarkPriceRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg0.states, arg1), 0);
        0x2::table::borrow<0x2::object::ID, MarkPriceState>(&arg0.states, arg1).mark_price
    }

    public fun get_state(arg0: &MarkPriceRegistry, arg1: 0x2::object::ID) : &MarkPriceState {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg0.states, arg1), 0);
        0x2::table::borrow<0x2::object::ID, MarkPriceState>(&arg0.states, arg1)
    }

    public fun has_mark_price(arg0: &MarkPriceRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg0.states, arg1)
    }

    public fun impact_notional_usd_e8(arg0: &MarkPriceState) : u64 {
        arg0.impact_notional_usd_e8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarkPriceRegistry{
            id     : 0x2::object::new(arg0),
            states : 0x2::table::new<0x2::object::ID, MarkPriceState>(arg0),
        };
        0x2::transfer::share_object<MarkPriceRegistry>(v0);
    }

    public fun last_close_oracle(arg0: &MarkPriceState) : u64 {
        arg0.last_close_oracle
    }

    public fun last_perp_mid(arg0: &MarkPriceState) : u64 {
        arg0.last_perp_mid
    }

    public fun last_session_flag(arg0: &MarkPriceState) : u8 {
        arg0.last_session_flag
    }

    public fun last_update_ms(arg0: &MarkPriceState) : u64 {
        arg0.last_update_ms
    }

    public fun max_mark_staleness_ms() : u64 {
        60000
    }

    public fun max_per_update_bps(arg0: &MarkPriceState) : u64 {
        arg0.max_per_update_bps
    }

    fun median_of_3(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 >= arg1) {
            if (arg1 >= arg2) {
                arg1
            } else if (arg0 >= arg2) {
                arg2
            } else {
                arg0
            }
        } else if (arg0 >= arg2) {
            arg0
        } else if (arg1 >= arg2) {
            arg2
        } else {
            arg1
        }
    }

    public fun oracle_price(arg0: &MarkPriceState) : u64 {
        arg0.oracle_price
    }

    public fun register_market(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut MarkPriceRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg1.states, arg2), 1);
        assert!(arg3 > 0, 2);
        let v0 = MarkPriceState{
            oracle_price           : arg3,
            mark_price             : arg3,
            basis_ema              : 0,
            basis_ema_is_negative  : false,
            tau_off_hours_ms       : 1800000,
            tau_basis_ema_ms       : 150000,
            impact_notional_usd_e8 : 2000000000000,
            max_per_update_bps     : 25,
            last_close_oracle      : arg3,
            last_perp_mid          : arg3,
            last_update_ms         : 0x2::clock::timestamp_ms(arg4),
            last_session_flag      : 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::session_open(),
        };
        0x2::table::add<0x2::object::ID, MarkPriceState>(&mut arg1.states, arg2, v0);
        let v1 = MarkPriceRegistered{
            market_id     : arg2,
            initial_price : arg3,
        };
        0x2::event::emit<MarkPriceRegistered>(v1);
    }

    public fun scale() : u64 {
        1000000000
    }

    public fun set_last_close_oracle(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut MarkPriceRegistry, arg2: 0x2::object::ID, arg3: u64) {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg1.states, arg2), 0);
        assert!(arg3 > 0, 2);
        0x2::table::borrow_mut<0x2::object::ID, MarkPriceState>(&mut arg1.states, arg2).last_close_oracle = arg3;
    }

    public fun tau_basis_ema_ms(arg0: &MarkPriceState) : u64 {
        arg0.tau_basis_ema_ms
    }

    public fun tau_off_hours_ms(arg0: &MarkPriceState) : u64 {
        arg0.tau_off_hours_ms
    }

    fun update_basis_ema(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : (u64, bool) {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (arg1 - arg0, true)
        };
        let v2 = if (arg4 > arg5 / 10) {
            arg5 / 10
        } else {
            arg4
        };
        let v3 = exp_neg_scaled(v2, arg5);
        let v4 = (v3 as u128) * (arg2 as u128) / (1000000000 as u128);
        let v5 = ((1000000000 - v3) as u128) * (v0 as u128) / (1000000000 as u128);
        if (arg3 == v1) {
            (((v4 + v5) as u64), arg3)
        } else if (v4 >= v5) {
            (((v4 - v5) as u64), arg3)
        } else {
            (((v5 - v4) as u64), v1)
        }
    }

    public fun update_mark_price(arg0: &mut MarkPriceRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg0.states, arg1), 0);
        assert!(arg2 > 0, 2);
        assert!(arg6 > 0, 2);
        assert!(arg3 > 0 && arg4 > 0, 7);
        assert!(arg3 >= arg4, 7);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, MarkPriceState>(&mut arg0.states, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = if (v1 > v0.last_update_ms) {
            v1 - v0.last_update_ms
        } else {
            0
        };
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::session_open();
        if (v0.last_session_flag == v3 && arg7 != v3) {
            v0.last_close_oracle = v0.oracle_price;
        };
        let v4 = if (arg7 == v3) {
            arg6
        } else {
            advance_oracle_off_hours(v0.oracle_price, arg3, arg4, v2, v0.tau_off_hours_ms, v0.max_per_update_bps)
        };
        let (v5, v6, v7) = compute_mark(v4, arg2, arg3, arg4, arg5, v0.basis_ema, v0.basis_ema_is_negative, v0.last_perp_mid, v0.tau_basis_ema_ms, v2);
        v0.oracle_price = v4;
        v0.mark_price = v5;
        v0.basis_ema = v6;
        v0.basis_ema_is_negative = v7;
        v0.last_perp_mid = arg2;
        v0.last_update_ms = v1;
        v0.last_session_flag = arg7;
        let v8 = MarkPriceUpdated{
            market_id      : arg1,
            new_mark_price : v5,
            oracle_price   : v4,
            perp_mid_price : arg2,
            session_flag   : arg7,
            timestamp_ms   : v1,
        };
        0x2::event::emit<MarkPriceUpdated>(v8);
    }

    public fun update_params(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut MarkPriceRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x2::table::contains<0x2::object::ID, MarkPriceState>(&arg1.states, arg2), 0);
        assert!(arg3 >= 60000 && arg3 <= 7200000, 8);
        assert!(arg4 >= 30000 && arg4 <= 1800000, 8);
        assert!(arg5 >= 5 && arg5 <= 500, 8);
        assert!(arg6 > 0, 8);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, MarkPriceState>(&mut arg1.states, arg2);
        v0.tau_off_hours_ms = arg3;
        v0.tau_basis_ema_ms = arg4;
        v0.max_per_update_bps = arg5;
        v0.impact_notional_usd_e8 = arg6;
        let v1 = MarkPriceParamsUpdated{
            market_id              : arg2,
            tau_off_hours_ms       : arg3,
            tau_basis_ema_ms       : arg4,
            max_per_update_bps     : arg5,
            impact_notional_usd_e8 : arg6,
        };
        0x2::event::emit<MarkPriceParamsUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

