module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order_events {
    struct OrderMinted has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        order_id: u256,
        position_root_id: u256,
        owner: address,
        lower_tick: u64,
        higher_tick: u64,
        entry_probability: u64,
        quantity: u64,
        premium: u64,
        trading_fee: u64,
        fee_incentive_subsidy: u64,
        builder_fee: u64,
        penalty_fee: u64,
        referral_fee: u64,
        inventory_impact_charge: u64,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
        referrer_account_id: 0x1::option::Option<0x2::object::ID>,
        onchain_timestamp_ms: u64,
        pyth_spot_source_timestamp_ms: u64,
        block_scholes_spot_source_timestamp_ms: u64,
        block_scholes_forward_source_timestamp_ms: u64,
        block_scholes_svi_source_timestamp_ms: u64,
    }

    struct LiveOrderRedeemed has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        order_id: u256,
        position_root_id: u256,
        owner: address,
        quantity_closed: u64,
        remaining_quantity: u64,
        replacement_order_id: 0x1::option::Option<u256>,
        redeem_amount: u64,
        trading_fee: u64,
        builder_fee: u64,
        penalty_fee: u64,
        inventory_impact_rebate: u64,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
        onchain_timestamp_ms: u64,
        pyth_spot_source_timestamp_ms: u64,
        block_scholes_spot_source_timestamp_ms: u64,
        block_scholes_forward_source_timestamp_ms: u64,
        block_scholes_svi_source_timestamp_ms: u64,
    }

    struct SettledOrderRedeemed has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        order_id: u256,
        position_root_id: u256,
        owner: address,
        payout_amount: u64,
        onchain_timestamp_ms: u64,
    }

    public(friend) fun emit_live_order_redeemed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg6: u256, arg7: u64, arg8: 0x1::option::Option<u256>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) {
        let v0 = if (arg11 == 0) {
            0x1::option::none<0x2::object::ID>()
        } else {
            arg3
        };
        let v1 = LiveOrderRedeemed{
            expiry_market_id                          : arg0,
            account_id                                : arg1,
            order_id                                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg4),
            position_root_id                          : arg6,
            owner                                     : arg2,
            quantity_closed                           : arg7,
            remaining_quantity                        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(arg4) - arg7,
            replacement_order_id                      : arg8,
            redeem_amount                             : arg9,
            trading_fee                               : arg10,
            builder_fee                               : arg11,
            penalty_fee                               : arg12,
            inventory_impact_rebate                   : arg13,
            builder_code_id                           : v0,
            onchain_timestamp_ms                      : arg14,
            pyth_spot_source_timestamp_ms             : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::pyth_spot_source_timestamp_ms(arg5),
            block_scholes_spot_source_timestamp_ms    : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_spot_source_timestamp_ms(arg5),
            block_scholes_forward_source_timestamp_ms : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_forward_source_timestamp_ms(arg5),
            block_scholes_svi_source_timestamp_ms     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_svi_source_timestamp_ms(arg5),
        };
        0x2::event::emit<LiveOrderRedeemed>(v1);
    }

    public(friend) fun emit_order_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg6: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        let v0 = if (arg11 == 0) {
            0x1::option::none<0x2::object::ID>()
        } else {
            arg3
        };
        let v1 = OrderMinted{
            expiry_market_id                          : arg0,
            account_id                                : arg1,
            order_id                                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg5),
            position_root_id                          : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg5),
            owner                                     : arg2,
            lower_tick                                : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(arg5),
            higher_tick                               : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(arg5),
            entry_probability                         : arg7,
            quantity                                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(arg5),
            premium                                   : arg8,
            trading_fee                               : arg9,
            fee_incentive_subsidy                     : arg10,
            builder_fee                               : arg11,
            penalty_fee                               : arg12,
            referral_fee                              : arg13,
            inventory_impact_charge                   : arg14,
            builder_code_id                           : v0,
            referrer_account_id                       : arg4,
            onchain_timestamp_ms                      : arg15,
            pyth_spot_source_timestamp_ms             : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::pyth_spot_source_timestamp_ms(arg6),
            block_scholes_spot_source_timestamp_ms    : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_spot_source_timestamp_ms(arg6),
            block_scholes_forward_source_timestamp_ms : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_forward_source_timestamp_ms(arg6),
            block_scholes_svi_source_timestamp_ms     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::block_scholes_svi_source_timestamp_ms(arg6),
        };
        0x2::event::emit<OrderMinted>(v1);
    }

    public(friend) fun emit_settled_order_redeemed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg4: u256, arg5: u64, arg6: u64) {
        let v0 = SettledOrderRedeemed{
            expiry_market_id     : arg0,
            account_id           : arg1,
            order_id             : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::id(arg3),
            position_root_id     : arg4,
            owner                : arg2,
            payout_amount        : arg5,
            onchain_timestamp_ms : arg6,
        };
        0x2::event::emit<SettledOrderRedeemed>(v0);
    }

    // decompiled from Move bytecode v7
}

