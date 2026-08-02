module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_settlement {
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

    struct FundingRoundSkipped has copy, drop {
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        reason: u8,
        timestamp_ms: u64,
    }

    struct FundingKeeperCap has store, key {
        id: 0x2::object::UID,
        keeper_address: address,
    }

    struct FundingKeeperCapCreated has copy, drop {
        keeper_address: address,
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

    public fun compute_accrued_funding_cost_v4(arg0: u8, arg1: u64, arg2: u64, arg3: u128, arg4: bool, arg5: u128, arg6: bool, arg7: u128, arg8: u128) : u64 {
        let v0 = (((arg1 as u128) * (arg2 as u128) / 100000000) as u64);
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

    public fun create_funding_keeper_cap(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FundingKeeperCap{
            id             : 0x2::object::new(arg2),
            keeper_address : arg1,
        };
        0x2::transfer::transfer<FundingKeeperCap>(v0, arg1);
        let v1 = FundingKeeperCapCreated{keeper_address: arg1};
        0x2::event::emit<FundingKeeperCapCreated>(v1);
    }

    public fun keeper_settle_funding_round_v4<T0>(arg0: &FundingKeeperCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg5: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg6: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg7: vector<u8>, arg8: 0x2::object::ID, arg9: u64, arg10: bool, arg11: u64, arg12: bool, arg13: u64, arg14: &0x2::clock::Clock) : u64 {
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg4);
        let v0 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::get_state(arg3, arg8);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::assert_fresh(v0, arg14);
        let v1 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::mark_price(v0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::update_indices_v3(arg1, arg2, arg7, arg9, arg10, arg11, arg12, arg13, arg0.keeper_address, arg14);
        let v2 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::borrow_funding_state(arg2, arg7);
        let v3 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index(v2);
        let v4 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_global_funding_index_is_negative(v2);
        let v5 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::state_short_borrow_index(v2);
        let v6 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::settle_market_funding_round_v4<T0>(arg5, arg6, arg8, v1, v3, v4, v5, arg14);
        let v7 = FundingRoundSettledV2{
            market_id                        : arg8,
            mark_price                       : v1,
            premium_rate_bps                 : arg9,
            premium_rate_is_negative         : arg10,
            inventory_rate_bps               : arg11,
            inventory_rate_is_negative       : arg12,
            borrow_rate_bps                  : arg13,
            global_funding_index             : v3,
            global_funding_index_is_negative : v4,
            short_borrow_index               : v5,
            positions_settled                : v6,
            timestamp_ms                     : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<FundingRoundSettledV2>(v7);
        v6
    }

    public fun keeper_settle_funding_round_v4_gated<T0>(arg0: &FundingKeeperCap, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::RiskParams, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::funding_index::FundingRegistry, arg4: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::mark_price::MarkPriceRegistry, arg5: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg6: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg7: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg8: vector<u8>, arg9: 0x2::object::ID, arg10: u64, arg11: bool, arg12: u64, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock) : u64 {
        if (!0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::is_funding_allowed(arg1, arg8)) {
            let v0 = FundingRoundSkipped{
                market_id    : arg9,
                symbol       : arg8,
                reason       : 1,
                timestamp_ms : 0x2::clock::timestamp_ms(arg15),
            };
            0x2::event::emit<FundingRoundSkipped>(v0);
            return 0
        };
        keeper_settle_funding_round_v4<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun settle_funding_round(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock) : u64 {
        abort 1
    }

    public fun settle_funding_round_v3(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: u128, arg10: bool, arg11: u128, arg12: &0x2::clock::Clock) : u64 {
        abort 1
    }

    // decompiled from Move bytecode v7
}

