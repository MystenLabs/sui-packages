module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::payout_cap {
    struct ParamsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LongHoldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LongHoldV1 has copy, drop, store {
        enabled: bool,
        free_ms: u64,
        slope_bps_per_h: u64,
        max_extra_bps: u64,
    }

    struct ParamsV1 has copy, drop, store {
        enabled: bool,
        leverages: vector<u64>,
        multiples_bps: vector<u64>,
        pool_share_bps: u64,
        side_budget_bps: u64,
    }

    struct PositionKey has copy, drop, store {
        pos0: u64,
    }

    struct PositionCapV1 has copy, drop, store {
        market_id: 0x2::object::ID,
        is_long: bool,
        cap: u64,
    }

    struct SideKey has copy, drop, store {
        market_id: 0x2::object::ID,
        is_long: bool,
    }

    struct SideBudgetV1 has copy, drop, store {
        committed: u128,
        positions: u64,
    }

    fun admission<T0>(arg0: &ParamsV1, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64) : (u64, u128, u128) {
        let v0 = cap_for(arg4, arg0.pool_share_bps, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::lp_cash<T0>(arg1), arg5);
        (v0, side_committed<T0>(arg1, arg2, arg3) + (v0 as u128), budget_of<T0>(arg0, arg1))
    }

    public fun admits<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64) : bool {
        let v0 = params_or_off(arg1);
        if (!v0.enabled) {
            return true
        };
        let (v1, v2, v3) = admission<T0>(&v0, arg0, arg2, arg3, multiple_bps_at(&v0.leverages, &v0.multiples_bps, arg4), arg5);
        v1 > 0 && v2 <= v3
    }

    public fun assert_admits<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = params_or_off(arg1);
        if (!v0.enabled) {
            return
        };
        let (v1, v2, v3) = admission<T0>(&v0, arg0, arg2, arg3, multiple_bps_at(&v0.leverages, &v0.multiples_bps, arg4), arg5);
        assert!(v1 > 0, 13835622233596493829);
        assert!(v2 <= v3, 13835340762914619395);
    }

    fun budget_of<T0>(arg0: &ParamsV1, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : u128 {
        (free_cash<T0>(arg1) as u128) * (arg0.side_budget_bps as u128) / 10000
    }

    public fun cap_for(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0x1::u128::min((arg3 as u128) * (arg0 as u128) / 10000, (arg2 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun free_cash<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : u64 {
        let v0 = (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::reserve_upnl<T0>(arg0) as u128) + (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::reserve_stress<T0>(arg0) as u128);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::reserve<T0>(arg0);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::lp_cash<T0>(arg0) as u128);
        if (v3 > v2) {
            ((v3 - v2) as u64)
        } else {
            0
        }
    }

    public fun long_hold_fee(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = (arg6 as u128) + (arg7 as u128);
        let v1 = if (!arg0) {
            true
        } else if (arg4 <= arg1) {
            true
        } else {
            (arg5 as u128) <= v0
        };
        if (v1) {
            return 0
        };
        (0x1::u128::min((arg5 as u128) * 0x1::u128::min((arg2 as u128) * ((arg4 - arg1) as u128) / 3600000, (arg3 as u128)) / 10000, (arg5 as u128) - v0) as u64)
    }

    public fun multiple_bps(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: u64) : u64 {
        let v0 = params_or_off(arg0);
        multiple_bps_at(&v0.leverages, &v0.multiples_bps, arg1)
    }

    public fun multiple_bps_at(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        if (arg2 <= *0x1::vector::borrow<u64>(arg0, 0)) {
            return *0x1::vector::borrow<u64>(arg1, 0)
        };
        if (arg2 >= *0x1::vector::borrow<u64>(arg0, v0 - 1)) {
            return *0x1::vector::borrow<u64>(arg1, v0 - 1)
        };
        let v1 = 1;
        while (*0x1::vector::borrow<u64>(arg0, v1) <= arg2) {
            v1 = v1 + 1;
        };
        let v2 = (*0x1::vector::borrow<u64>(arg0, v1 - 1) as u128);
        let v3 = (*0x1::vector::borrow<u64>(arg0, v1) as u128);
        let v4 = (arg2 as u128);
        ((((*0x1::vector::borrow<u64>(arg1, v1 - 1) as u128) * (v3 - v4) + (*0x1::vector::borrow<u64>(arg1, v1) as u128) * (v4 - v2)) / (v3 - v2)) as u64)
    }

    public fun on_open<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: bool, arg7: u64, arg8: u64) {
        let v0 = params_or_off(arg2);
        if (!v0.enabled) {
            return
        };
        let v1 = multiple_bps_at(&v0.leverages, &v0.multiples_bps, arg7);
        let (v2, v3, v4) = admission<T0>(&v0, arg1, arg3, arg6, v1, arg8);
        assert!(v2 > 0, 13835621902884012037);
        assert!(v3 <= v4, 13835340432202137603);
        let v5 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        let v6 = SideKey{
            market_id : arg3,
            is_long   : arg6,
        };
        if (!0x2::dynamic_field::exists<SideKey>(v5, v6)) {
            let v7 = SideBudgetV1{
                committed : 0,
                positions : 0,
            };
            0x2::dynamic_field::add<SideKey, SideBudgetV1>(v5, v6, v7);
        };
        let v8 = 0x2::dynamic_field::borrow_mut<SideKey, SideBudgetV1>(v5, v6);
        v8.committed = v3;
        v8.positions = v8.positions + 1;
        let v9 = PositionKey{pos0: arg5};
        let v10 = PositionCapV1{
            market_id : arg3,
            is_long   : arg6,
            cap       : v2,
        };
        0x2::dynamic_field::add<PositionKey, PositionCapV1>(v5, v9, v10);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_set_payout_cap_event(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1), arg5, arg4, arg3, arg6, arg7, arg8, v1, v2, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::lp_cash<T0>(arg1), v3, v4);
    }

    public fun on_settle<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : (u64, u64) {
        let v0 = PositionKey{pos0: arg3};
        if (!0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v0)) {
            assert!(!arg9, 13835903541069611015);
            return (arg6, arg7)
        };
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        let (v2, v3, v4) = take(v1, arg3, arg4, arg5);
        let v5 = arg6 > 0 && arg6 >= v3;
        assert!(!arg9 || v5, 13835903571134382087);
        if (!v5) {
            if (arg5 > 0) {
                0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_split_payout_cap_event(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1), arg3, v3, v4);
            };
            return (arg6, arg7)
        };
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_hit_payout_cap_event(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1), arg3, arg2, v2, arg6, v3, v4, arg9);
        (v3, (((v3 as u128) * (arg8 as u128) / 10000) as u64))
    }

    public fun on_settle_long_hold<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : u64 {
        let v0 = LongHoldKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LongHoldKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), v0)) {
            return arg6
        };
        let v1 = LongHoldKey{dummy_field: false};
        let LongHoldV1 {
            enabled         : v2,
            free_ms         : v3,
            slope_bps_per_h : v4,
            max_extra_bps   : v5,
        } = *0x2::dynamic_field::borrow<LongHoldKey, LongHoldV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), v1);
        let v6 = if (arg8 > arg4) {
            arg8 - arg4
        } else {
            0
        };
        let v7 = long_hold_fee(v2, v3, v4, v5, v6, arg5, arg6, arg7);
        if (v7 == 0) {
            return arg6
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_charge_long_hold_fee_event(arg3, v6, v7);
        arg6 + v7
    }

    public fun params(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) : (bool, vector<u64>, vector<u64>, u64, u64) {
        let v0 = params_or_off(arg0);
        (v0.enabled, v0.leverages, v0.multiples_bps, v0.pool_share_bps, v0.side_budget_bps)
    }

    fun params_or_off(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) : ParamsV1 {
        let v0 = ParamsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ParamsKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0), v0)) {
            let v2 = ParamsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ParamsKey, ParamsV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0), v2)
        } else {
            ParamsV1{enabled: false, leverages: vector[], multiples_bps: vector[], pool_share_bps: 0, side_budget_bps: 0}
        }
    }

    public fun position_cap<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = PositionKey{pos0: arg1};
        if (0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0)) {
            0x1::option::some<u64>(0x2::dynamic_field::borrow<PositionKey, PositionCapV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0).cap)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun quote<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = params_or_off(arg1);
        if (!v0.enabled) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(cap_for(multiple_bps_at(&v0.leverages, &v0.multiples_bps, arg2), v0.pool_share_bps, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::lp_cash<T0>(arg0), arg3))
    }

    public fun release<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64) {
        let v0 = PositionKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v0)) {
            return
        };
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        let (_, _, _) = take(v1, arg2, 0, 0);
    }

    public fun set_long_hold(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: bool, arg4: u64, arg5: u64, arg6: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = if (arg4 <= 604800000) {
            if (arg5 <= 2000) {
                arg6 <= 5000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13836186016773832713);
        let v1 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1);
        let v2 = LongHoldKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LongHoldKey>(v1, v2)) {
            let v3 = LongHoldKey{dummy_field: false};
            0x2::dynamic_field::remove<LongHoldKey, LongHoldV1>(v1, v3);
        };
        let v4 = LongHoldKey{dummy_field: false};
        let v5 = LongHoldV1{
            enabled         : arg3,
            free_ms         : arg4,
            slope_bps_per_h : arg5,
            max_extra_bps   : arg6,
        };
        0x2::dynamic_field::add<LongHoldKey, LongHoldV1>(v1, v4, v5);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 117);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_set_long_hold_fee_params_event(arg3, arg4, arg5, arg6);
    }

    public fun set_params(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: bool, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = if (valid_curve(&arg4, &arg5)) {
            if (arg6 >= 1) {
                if (arg6 <= 10000) {
                    if (arg7 >= 1) {
                        arg7 <= 1000000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835058789721571329);
        let v1 = ParamsV1{
            enabled         : arg3,
            leverages       : arg4,
            multiples_bps   : arg5,
            pool_share_bps  : arg6,
            side_budget_bps : arg7,
        };
        let v2 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1);
        let v3 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid_mut(arg0, arg1);
        let v4 = ParamsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ParamsKey>(v3, v4)) {
            let v5 = ParamsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ParamsKey, ParamsV1>(v3, v5) = v1;
        } else {
            let v6 = ParamsKey{dummy_field: false};
            0x2::dynamic_field::add<ParamsKey, ParamsV1>(v3, v6, v1);
        };
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::events::emit_admin_action(arg0, v2, 111);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_set_payout_cap_params_event(v2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun side_budget<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) : u128 {
        let v0 = params_or_off(arg1);
        budget_of<T0>(&v0, arg0)
    }

    public fun side_committed<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: bool) : u128 {
        let v0 = SideKey{
            market_id : arg1,
            is_long   : arg2,
        };
        if (0x2::dynamic_field::exists<SideKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0)) {
            0x2::dynamic_field::borrow<SideKey, SideBudgetV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0).committed
        } else {
            0
        }
    }

    public fun side_positions<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: bool) : u64 {
        let v0 = SideKey{
            market_id : arg1,
            is_long   : arg2,
        };
        if (0x2::dynamic_field::exists<SideKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0)) {
            0x2::dynamic_field::borrow<SideKey, SideBudgetV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0).positions
        } else {
            0
        }
    }

    fun take(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) : (0x2::object::ID, u64, u64) {
        let v0 = PositionKey{pos0: arg1};
        let PositionCapV1 {
            market_id : v1,
            is_long   : v2,
            cap       : v3,
        } = *0x2::dynamic_field::borrow<PositionKey, PositionCapV1>(arg0, v0);
        let v4 = arg3 == 0;
        let v5 = if (v4) {
            v3
        } else {
            (((v3 as u128) * (arg2 as u128) / ((arg2 as u128) + (arg3 as u128))) as u64)
        };
        if (v4) {
            0x2::dynamic_field::remove<PositionKey, PositionCapV1>(arg0, v0);
        } else {
            0x2::dynamic_field::borrow_mut<PositionKey, PositionCapV1>(arg0, v0).cap = v3 - v5;
        };
        let v6 = SideKey{
            market_id : v1,
            is_long   : v2,
        };
        let v7 = 0x2::dynamic_field::borrow_mut<SideKey, SideBudgetV1>(arg0, v6);
        v7.committed = v7.committed - (v5 as u128);
        if (v4) {
            v7.positions = v7.positions - 1;
        };
        if (v7.positions == 0) {
            0x2::dynamic_field::remove<SideKey, SideBudgetV1>(arg0, v6);
        };
        (v1, v5, v3 - v5)
    }

    fun valid_curve(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = if (v0 == 0) {
            true
        } else if (v0 > 8) {
            true
        } else {
            0x1::vector::length<u64>(arg1) != v0
        };
        if (v1) {
            return false
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v2);
            let v4 = if (*0x1::vector::borrow<u64>(arg0, v2) <= 0) {
                true
            } else if (v3 < 10000) {
                true
            } else {
                v3 > 100000000
            };
            if (v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

