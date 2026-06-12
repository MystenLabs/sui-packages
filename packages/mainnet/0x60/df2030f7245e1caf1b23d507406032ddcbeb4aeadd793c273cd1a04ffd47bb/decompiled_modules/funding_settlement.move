module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::funding_settlement {
    struct FundingRoundSettled has copy, drop {
        market_id: 0x2::object::ID,
        mark_price: u64,
        global_funding_index: u128,
        global_funding_index_is_negative: bool,
        short_borrow_index: u128,
        positions_settled: u64,
        timestamp_ms: u64,
    }

    struct FundingRoundSettledV2 has copy, drop {
        market_id: 0x2::object::ID,
        mark_price: u64,
        premium_rate_bps: u64,
        premium_rate_is_negative: bool,
        inventory_rate_bps: u64,
        inventory_rate_is_negative: bool,
        borrow_rate_bps: u64,
        global_funding_index: u128,
        global_funding_index_is_negative: bool,
        short_borrow_index: u128,
        positions_settled: u64,
        timestamp_ms: u64,
    }

    fun add_signed_u128(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 > arg2) {
            (arg0 - arg2, arg1)
        } else if (arg2 > arg0) {
            (arg2 - arg0, arg3)
        } else {
            (0, false)
        }
    }

    public fun compute_accrued_funding_cost(arg0: u8, arg1: u64, arg2: u64, arg3: u128, arg4: bool, arg5: u128, arg6: bool, arg7: u128, arg8: u128) : u64 {
        let v0 = (((arg1 as u128) * (arg2 as u128) / 1000000000) as u64);
        let (v1, v2) = compute_owed_funding(arg0, v0, arg3, arg4, arg5, arg6);
        let v3 = if (arg0 == 1) {
            compute_owed_borrow(v0, arg7, arg8)
        } else {
            0
        };
        let v4 = (v3 as u128);
        let v5 = if (v2) {
            v4 + (v1 as u128)
        } else {
            if ((v1 as u128) > v4) {
                return 0
            };
            v4 - (v1 as u128)
        };
        (v5 as u64)
    }

    public fun compute_index_delta(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        let (v0, v1) = if (arg2 == 0) {
            (0, false)
        } else {
            (arg2, !arg3)
        };
        add_signed_u128(arg0, arg1, v0, v1)
    }

    public fun compute_owed_borrow(arg0: u64, arg1: u128, arg2: u128) : u64 {
        if (arg1 <= arg2 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 - arg2) / 1000000000000000000) as u64)
    }

    public fun compute_owed_funding(arg0: u8, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool) : (u64, bool) {
        let (v0, v1) = compute_index_delta(arg2, arg3, arg4, arg5);
        if (v0 == 0 || arg1 == 0) {
            return (0, false)
        };
        let v2 = arg0 == 0 && !v1 || v1;
        ((((arg1 as u128) * v0 / 1000000000000000000) as u64), v2)
    }

    public fun compute_settlement(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: bool, arg8: u128, arg9: u128) : (u64, u64, u64, bool) {
        assert!(arg0 == 0 || arg0 == 1, 0);
        let v0 = (((arg1 as u128) * (arg2 as u128) / 1000000000) as u64);
        let (v1, v2) = compute_owed_funding(arg0, v0, arg4, arg5, arg6, arg7);
        let v3 = if (arg0 == 1) {
            compute_owed_borrow(v0, arg8, arg9)
        } else {
            0
        };
        let v4 = (arg3 as u128);
        let v5 = if (v2) {
            if ((v1 as u128) >= v4) {
                0
            } else {
                v4 - (v1 as u128)
            }
        } else {
            v4 + (v1 as u128)
        };
        if ((v3 as u128) >= v5) {
            v5 = 0;
        } else {
            v5 = v5 - (v3 as u128);
        };
        ((v5 as u64), v1, v3, v2)
    }

    public fun settle_funding_round(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock) : u64 {
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg0);
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::settle_market_funding_round(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = FundingRoundSettled{
            market_id                        : arg2,
            mark_price                       : arg3,
            global_funding_index             : arg4,
            global_funding_index_is_negative : arg5,
            short_borrow_index               : arg6,
            positions_settled                : v0,
            timestamp_ms                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<FundingRoundSettled>(v1);
        v0
    }

    public fun settle_funding_round_v3(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::PositionStore, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: bool, arg11: u128, arg12: &0x2::clock::Clock) : u64 {
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::assert_not_paused(arg0);
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store::settle_market_funding_round(arg1, arg2, arg3, arg9, arg10, arg11, arg12);
        let v1 = FundingRoundSettledV2{
            market_id                        : arg2,
            mark_price                       : arg3,
            premium_rate_bps                 : arg4,
            premium_rate_is_negative         : arg5,
            inventory_rate_bps               : arg6,
            inventory_rate_is_negative       : arg7,
            borrow_rate_bps                  : arg8,
            global_funding_index             : arg9,
            global_funding_index_is_negative : arg10,
            short_borrow_index               : arg11,
            positions_settled                : v0,
            timestamp_ms                     : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<FundingRoundSettledV2>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

