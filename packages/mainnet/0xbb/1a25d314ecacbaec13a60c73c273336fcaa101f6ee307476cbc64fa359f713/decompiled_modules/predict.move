module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict {
    struct Predict<phantom T0> has key {
        id: 0x2::object::UID,
        markets: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::Markets,
        vault: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::Vault<T0>,
        pricing: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::Pricing,
        lp_config: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::lp_config::LPConfig,
        risk_config: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::risk_config::RiskConfig,
    }

    public(friend) fun enable_market<T0, T1>(arg0: &mut Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::enable_market<T0>(&mut arg0.markets, arg1, arg2);
    }

    fun assert_vault_exposure<T0>(arg0: &Predict<T0>, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        let v0 = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::balance<T0>(&arg0.vault);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::max_liability<T0>(&arg0.vault) <= 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(v0, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::risk_config::max_total_exposure_pct(&arg0.risk_config)), 3);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::market_liability<T0>(&arg0.vault, arg1) <= 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(v0, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::risk_config::max_per_market_exposure_pct(&arg0.risk_config)), 4);
    }

    public(friend) fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Predict<T0>{
            id          : 0x2::object::new(arg0),
            markets     : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::new(),
            vault       : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::new<T0>(arg0),
            pricing     : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::new(),
            lp_config   : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::lp_config::new(),
            risk_config : 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::risk_config::new(),
        };
        0x2::transfer::share_object<Predict<T0>>(v0);
        0x2::object::id<Predict<T0>>(&v0)
    }

    public fun get_mint_cost<T0, T1>(arg0: &Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::pair_position<T1>(&arg0.vault, arg2);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::get_mint_cost<T0>(&arg0.pricing, arg1, arg2, arg3, v0, v1, arg4)
    }

    public fun get_redeem_payout<T0, T1>(arg0: &Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::pair_position<T1>(&arg0.vault, arg2);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::get_redeem_payout<T0>(&arg0.pricing, arg1, arg2, arg3, v0, v1, arg4)
    }

    fun mark_to_market<T0, T1>(arg0: &mut Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::up_down_pair(&arg2);
        let (v2, v3) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::pair_position<T1>(&arg0.vault, arg2);
        update_position_mtm<T0, T1>(arg0, arg1, v0, v2, v3, arg3);
        update_position_mtm<T0, T1>(arg0, arg1, v1, v2, v3, arg3);
    }

    public fun mint<T0, T1>(arg0: &mut Predict<T1>, arg1: &mut 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::PredictManager, arg2: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg3: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::id<T0>(arg2), 0);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::expiry<T0>(arg2), 1);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::assert_not_stale<T0>(arg2, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::assert_enabled(&arg0.markets, &arg3);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::execute_mint<T1>(&mut arg0.vault, arg3, arg4, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::withdraw<T1>(arg1, get_mint_cost<T0, T1>(arg0, arg2, arg3, arg4, arg5), arg6));
        assert_vault_exposure<T1>(arg0, arg3);
        mark_to_market<T0, T1>(arg0, arg2, arg3, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::increase_position(arg1, arg3, arg4);
    }

    public fun mint_collateralized<T0, T1>(arg0: &mut Predict<T1>, arg1: &mut 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::PredictManager, arg2: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg3: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg4: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::id<T0>(arg2), 0);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::expiry<T0>(arg2), 1);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg4) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::id<T0>(arg2), 0);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg4) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::expiry<T0>(arg2), 1);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::assert_not_stale<T0>(arg2, arg6);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::assert_enabled(&arg0.markets, &arg3);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_manager::assert_enabled(&arg0.markets, &arg4);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg4), 5);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg4), 5);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_up(&arg3) && 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_up(&arg4) && 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg3) < 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg4) || 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_down(&arg3) && 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_down(&arg4) && 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg3) > 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg4), 5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::lock_collateral(arg1, arg3, arg4, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::execute_mint_collateralized<T1>(&mut arg0.vault, arg4, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::increase_position(arg1, arg4, arg5);
    }

    public fun redeem<T0, T1>(arg0: &mut Predict<T1>, arg1: &mut 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::PredictManager, arg2: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg3: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::id<T0>(arg2), 0);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg3) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::expiry<T0>(arg2), 1);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::assert_not_stale<T0>(arg2, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::decrease_position(arg1, arg3, arg4);
        let v0 = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::execute_redeem<T1>(&mut arg0.vault, arg3, arg4, get_redeem_payout<T0, T1>(arg0, arg2, arg3, arg4, arg5));
        mark_to_market<T0, T1>(arg0, arg2, arg3, arg5);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg6), arg6);
    }

    public fun redeem_collateralized<T0>(arg0: &mut Predict<T0>, arg1: &mut 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::PredictManager, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg4: u64) {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::decrease_position(arg1, arg3, arg4);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager::release_collateral(arg1, arg2, arg3, arg4);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::execute_redeem_collateralized<T0>(&mut arg0.vault, arg3, arg4);
    }

    public fun settle<T0, T1>(arg0: &mut Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: &0x2::clock::Clock) {
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::oracle_id(&arg2) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::id<T0>(arg1), 0);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::expiry(&arg2) == 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::expiry<T0>(arg1), 1);
        assert!(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::is_settled<T0>(arg1), 2);
        mark_to_market<T0, T1>(arg0, arg1, arg2, arg3);
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::finalize_settlement<T1>(&mut arg0.vault, arg2, 0x1::option::destroy_some<u64>(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::settlement_price<T0>(arg1)) > 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg2));
    }

    public fun supply<T0>(arg0: &mut Predict<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::supply<T0>(&mut arg0.vault, arg1, arg2, arg3)
    }

    fun update_position_mtm<T0, T1>(arg0: &mut Predict<T1>, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::position_quantities<T1>(&arg0.vault, arg2);
        let (v2, v3) = if (v0 > v1) {
            (0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::get_mint_cost<T0>(&arg0.pricing, arg1, arg2, v0 - v1, arg3, arg4, arg5), 0)
        } else if (v1 > v0) {
            (0, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing::get_redeem_payout<T0>(&arg0.pricing, arg1, arg2, v1 - v0, arg3, arg4, arg5))
        } else {
            (0, 0)
        };
        0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::update_unrealized<T1>(&mut arg0.vault, arg2, v2, v3);
    }

    public fun withdraw<T0>(arg0: &mut Predict<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::vault::withdraw<T0>(&mut arg0.vault, arg1, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::lp_config::lockup_period_ms(&arg0.lp_config), arg2, arg3), arg3)
    }

    // decompiled from Move bytecode v6
}

