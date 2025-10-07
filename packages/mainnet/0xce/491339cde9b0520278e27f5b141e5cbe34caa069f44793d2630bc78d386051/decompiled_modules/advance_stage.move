module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::advance_stage {
    struct ProposalStateChanged has copy, drop {
        proposal_id: 0x2::object::ID,
        old_state: u8,
        new_state: u8,
        timestamp: u64,
    }

    struct TWAPHistoryEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        outcome_idx: u64,
        twap_price: u128,
        timestamp: u64,
    }

    struct MarketFinalizedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        winning_outcome: u64,
        timestamp_ms: u64,
    }

    public(friend) fun finalize<T0, T1>(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::Proposal<T0, T1>, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg2: &0x2::clock::Clock) {
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0) == 1, 1);
        assert!(0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState>(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::market_state_id<T0, T1>(arg0), 1);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_id<T0, T1>(arg0), 1);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::dao_id(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_dao_id<T0, T1>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        while (v2 < 0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_amm_pools<T0, T1>(arg0))) {
            let v6 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::get_twap(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (v2 as u8)), arg2);
            0x1::vector::push_back<u128>(&mut v1, v6);
            if (v2 == 0) {
            } else if (v6 > v3 && v6 > (((0 as u256) * (100000 + (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_twap_threshold<T0, T1>(arg0) as u256)) / 100000) as u128)) {
                v4 = v6;
                v5 = v2;
            };
            let v7 = TWAPHistoryEvent{
                proposal_id : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_id<T0, T1>(arg0),
                outcome_idx : v2,
                twap_price  : v6,
                timestamp   : v0,
            };
            0x2::event::emit<TWAPHistoryEvent>(v7);
            v2 = v2 + 1;
        };
        if (v4 == 0) {
            v5 = 0;
        };
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::set_twap_prices<T0, T1>(arg0, v1);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::set_last_twap_update<T0, T1>(arg0, v0);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::finalize(arg1, v5, arg2);
        let v8 = MarketFinalizedEvent{
            proposal_id     : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_id<T0, T1>(arg0),
            winning_outcome : v5,
            timestamp_ms    : v0,
        };
        0x2::event::emit<MarketFinalizedEvent>(v8);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::set_winning_outcome<T0, T1>(arg0, v5);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::set_state<T0, T1>(arg0, 2);
    }

    fun initialize_oracles_for_trading<T0, T1>(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::Proposal<T0, T1>, arg1: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_amm_pools<T0, T1>(arg0))) {
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::set_oracle_start_time(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (v0 as u8)), arg1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun try_advance_state<T0, T1>(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::Proposal<T0, T1>, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState>(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::market_state_id<T0, T1>(arg0), 1);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_id<T0, T1>(arg0), 1);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::dao_id(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_dao_id<T0, T1>(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0);
        if (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0) == 0 && v0 >= 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_created_at<T0, T1>(arg0) + 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_review_period_ms<T0, T1>(arg0)) {
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::set_state<T0, T1>(arg0, 1);
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::start_trading(arg1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_trading_period_ms<T0, T1>(arg0), arg2);
            initialize_oracles_for_trading<T0, T1>(arg0, arg1);
        } else {
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0) == 1, 0);
            let v2 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_trading_end_time(arg1);
            assert!(v0 >= *0x1::option::borrow<u64>(&v2), 2);
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::end_trading(arg1, arg2);
            finalize<T0, T1>(arg0, arg1, arg2);
        };
        if (v1 != 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0)) {
            let v3 = ProposalStateChanged{
                proposal_id : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::get_id<T0, T1>(arg0),
                old_state   : v1,
                new_state   : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0),
                timestamp   : v0,
            };
            0x2::event::emit<ProposalStateChanged>(v3);
        };
    }

    public entry fun try_advance_state_entry<T0, T1>(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::Proposal<T0, T1>, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::FeeManager, arg3: &0x2::clock::Clock) {
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state_id<T0, T1>(arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::market_state_id<T0, T1>(arg0), 1);
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state_mut<T0, T1>(arg1);
        try_advance_state<T0, T1>(arg0, v0, arg3);
        if (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::state<T0, T1>(arg0) == 2) {
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::liquidity_interact::collect_protocol_fees<T0, T1>(arg0, arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

