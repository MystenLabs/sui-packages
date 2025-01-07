module 0x959987422e144ef7f3fdca9885aa5e782418dd4e8d27696ce8992de050ec2795::two_pool {
    struct LP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        kraft_fee: u64,
        krafted_pools_list: 0x2::linked_table::LinkedTable<PoolRegistryItem, 0x2::object::ID>,
        fee_claim_cap: 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::TwoAmmFlowAccess,
        sui_hive_pool_addr: 0x1::option::Option<address>,
        sui_for_hive_pool_pct: u64,
        sui_honey_pool_addr: 0x1::option::Option<address>,
        sui_for_honey_pool_pct: u64,
        third_pool_addr: 0x1::option::Option<address>,
        total_sui_collected: 0x2::balance::Balance<0x2::sui::SUI>,
        is_buyback_enabled: bool,
        module_version: u64,
    }

    struct PoolRegistryItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        curve: 0x1::type_name::TypeName,
    }

    struct LiquidityPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_x_decimals: u8,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        coin_y_decimals: u8,
        lp_supply: 0x2::balance::Supply<LP<T0, T1, T2>>,
        total_lp_krafted: u64,
        curved_config: 0x1::option::Option<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>,
        stable_config: 0x1::option::Option<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>,
        weighted_config: 0x1::option::Option<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>,
        collected_fee_x: 0x2::balance::Balance<T0>,
        collected_fee_y: 0x2::balance::Balance<T1>,
        fee_info: PoolFeeInfo,
        is_locked: bool,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        last_timestamp: u64,
        pool_hive_addr: 0x1::option::Option<address>,
        is_swap_enabled: bool,
        module_version: u64,
    }

    struct PoolFeeInfo has store {
        total_fee_bps: u64,
        bees_fee_pct: u64,
    }

    struct Flashloan<phantom T0, phantom T1, phantom T2> {
        x_loan: u64,
        y_loan: u64,
    }

    struct SuiPolDistributionUpdated has copy, drop {
        sui_for_hive_pool_pct: u64,
        sui_for_honey_pool_pct: u64,
    }

    struct SuiPolThirdPoolUpdated has copy, drop {
        third_pool_addr: address,
    }

    struct StableConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_amp_time: u64,
        next_amp: u64,
        next_amp_time: u64,
    }

    struct WeightedConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        new_weights: vector<u64>,
        new_exit_fee: u64,
    }

    struct CurvedConfigUpdatedAmp<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_A_gamma_time: u64,
        next_amp: u64,
        next_gamma: u256,
        future_A_gamma_time: u64,
    }

    struct CurvedConfigUpdatedParams<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        new_mid_fee: u64,
        new_out_fee: u64,
        new_fee_gamma: u64,
        new_ma_half_time: u64,
        new_allowed_extra_profit: u64,
        new_adjustment_step: u64,
    }

    struct NewPoolCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LiquidityAddedToPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_minted: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct LiquidityRemovedFromPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_burned: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct LpBurntForever has copy, drop {
        pool_addr: address,
        lp_burned: u64,
    }

    struct TokensSwapped<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_offer_amt: u64,
        y_offer_amt: u64,
        x_return_amt: u64,
        y_return_amt: u64,
        x_total_fee: u64,
        y_total_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct FlashLoanExecuted<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_loan: u64,
        y_loan: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct CumPriceUpdatedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        timestamp: u64,
    }

    struct InternalPricesUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        price_scale: vector<u256>,
        oracle_prices: vector<u256>,
        last_prices: vector<u256>,
        last_prices_timestamp: u64,
        virtual_price: u256,
        xcp_profit: u256,
        not_adjusted: bool,
        _D: u256,
    }

    struct SuiFeeUsedForBuybacks has copy, drop {
        pool_addr: address,
        sui_for_treasury: u64,
        sui_for_honey_buyback: u64,
        honey_bought_amt: u64,
        sui_for_hive_buyback: u64,
        hive_bought_amt: u64,
        hive_for_voters_amt: u64,
        honey_for_voters_amt: u64,
    }

    struct SuiForYieldFarm has copy, drop {
        sui_for_treasury: u64,
        sui_for_honey_buyback: u64,
        honey_bought_amt: u64,
        sui_for_hive_buyback: u64,
        hive_bought_amt: u64,
    }

    struct PoolFeeUpdated has copy, drop {
        id: 0x2::object::ID,
        total_fee_bps: u64,
        bees_fee_pct: u64,
    }

    struct SUI_HIVE_INITIALIZED has copy, drop {
        sui_hive_pool_addr: address,
    }

    struct SUI_HONEY_INITIALIZED has copy, drop {
        sui_honey_pool_addr: address,
    }

    struct YieldFromQueenMakerClaimed has copy, drop {
        auction_over_for_epoch: u64,
        total_sui_bidded: u64,
        energy_yield: u64,
        simulated_hive_buyback: u64,
        simulated_honey_buyback: u64,
        sui_for_hive_pool_amt: u64,
        sui_for_honey_buyback_pool_amt: u64,
        sui_hive_lp_tokens_amt: u64,
        sui_honey_lp_tokens_amt: u64,
        third_pool_lp_tokens_amt: u64,
    }

    public fun swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5034);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5034);
        internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun update_initial_prices<T0, T1, T2>(arg0: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: vector<u256>) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::update_initial_prices(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), arg2);
    }

    public entry fun update_stable_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(&arg0.stable_config), 5025);
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::update_stable_config(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(&mut arg0.stable_config), arg3, arg2, arg4);
        let v0 = StableConfigUpdated<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg0.id),
            init_amp_time : arg3,
            next_amp      : arg2,
            next_amp_time : arg4,
        };
        0x2::event::emit<StableConfigUpdated<T0, T1, T2>>(v0);
    }

    public entry fun update_weighted_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: vector<u64>, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg0.weighted_config), 5025);
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::update_weighted_config(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&mut arg0.weighted_config), arg2, arg3);
        let v0 = WeightedConfigUpdated<T0, T1, T2>{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            new_weights  : arg2,
            new_exit_fee : arg3,
        };
        0x2::event::emit<WeightedConfigUpdated<T0, T1, T2>>(v0);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64) : 0x2::balance::Balance<LP<T0, T1, T2>> {
        assert!(arg1.module_version == 0, 5036);
        let v0 = internal_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert!(v0 >= arg4, 5008);
        arg1.total_lp_krafted = arg1.total_lp_krafted + v0;
        0x2::balance::increase_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, v0)
    }

    public fun add_sui_for_buyback(arg0: &mut PoolRegistry, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg0.module_version == 0, 5036);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_sui_collected, arg1);
    }

    public fun claim_fees_one_hop_via_sui_x_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &mut LiquidityPool<0x2::sui::SUI, T0, T3>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg1.collected_fee_y);
        let (v2, v3) = internal_swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), 1, v1, 0, true);
        let v4 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(&mut arg1.collected_fee_x));
        let (v5, v6) = internal_swap<0x2::sui::SUI, T0, T3>(arg0, arg2, 0x2::balance::zero<0x2::sui::SUI>(), 1, v4, 0, true);
        0x2::balance::destroy_zero<T0>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        convert_sui_fees_to_hive_and_honey(arg0, arg3, v0, 0x2::object::uid_to_address(&arg1.id), arg4, arg5, arg6);
    }

    public fun claim_fees_one_hop_via_sui_y_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &mut LiquidityPool<0x2::sui::SUI, T1, T3>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg1.collected_fee_x);
        let (v2, v3) = internal_swap<T0, T1, T2>(arg0, arg1, v1, 0, 0x2::balance::zero<T1>(), 1, true);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg1.collected_fee_y));
        let (v5, v6) = internal_swap<0x2::sui::SUI, T1, T3>(arg0, arg2, 0x2::balance::zero<0x2::sui::SUI>(), 1, v4, 0, true);
        0x2::balance::destroy_zero<T1>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        convert_sui_fees_to_hive_and_honey(arg0, arg3, v0, 0x2::object::uid_to_address(&arg1.id), arg4, arg5, arg6);
    }

    public fun claim_fees_one_hop_via_x_sui_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &mut LiquidityPool<T0, 0x2::sui::SUI, T3>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg1.collected_fee_y);
        let (v2, v3) = internal_swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), 1, v1, 0, true);
        let v4 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(&mut arg1.collected_fee_x));
        let (v5, v6) = internal_swap<T0, 0x2::sui::SUI, T3>(arg0, arg2, v4, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v6);
        convert_sui_fees_to_hive_and_honey(arg0, arg3, v0, 0x2::object::uid_to_address(&arg1.id), arg4, arg5, arg6);
    }

    public fun claim_fees_one_hop_via_y_sui_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &mut LiquidityPool<T1, 0x2::sui::SUI, T3>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg1.collected_fee_x);
        let (v2, v3) = internal_swap<T0, T1, T2>(arg0, arg1, v1, 0, 0x2::balance::zero<T1>(), 1, true);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg1.collected_fee_y));
        let (v5, v6) = internal_swap<T1, 0x2::sui::SUI, T3>(arg0, arg2, v4, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T1>(v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v6);
        convert_sui_fees_to_hive_and_honey(arg0, arg3, v0, 0x2::object::uid_to_address(&arg1.id), arg4, arg5, arg6);
    }

    public fun claim_fees_sui_hive_pool(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg3: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(&mut arg3.collected_fee_y);
        let (v2, v3) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.collected_fee_x));
        let v4 = 0x2::object::uid_to_address(&arg3.id);
        convert_sui_fees_to_hive_and_honey(arg0, arg1, v0, v4, arg3, arg4, arg2);
    }

    public fun claim_fees_sui_honey_pool(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg3: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(&mut arg4.collected_fee_y);
        let (v2, v3) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg4.collected_fee_x));
        let v4 = 0x2::object::uid_to_address(&arg4.id);
        convert_sui_fees_to_hive_and_honey(arg0, arg1, v0, v4, arg3, arg4, arg2);
    }

    public fun claim_fees_sui_x_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg3: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.collected_fee_y);
        let (v2, v3) = internal_swap<0x2::sui::SUI, T0, T1>(arg0, arg2, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.collected_fee_x));
        convert_sui_fees_to_hive_and_honey(arg0, arg1, v0, 0x2::object::uid_to_address(&arg2.id), arg3, arg4, arg5);
    }

    public fun claim_fees_x_sui_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg3: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg3.collected_fee_x);
        let (v2, v3) = internal_swap<T0, 0x2::sui::SUI, T1>(arg0, arg3, v1, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.collected_fee_y));
        convert_sui_fees_to_hive_and_honey(arg0, arg1, v0, 0x2::object::uid_to_address(&arg3.id), arg4, arg5, arg2);
    }

    public fun claim_yield_from_queen_maker<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut PoolRegistry, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::BeesManager, arg3: &mut 0xf19a586bb1ba1ec97b063c22b58534444ada26a8f81a049327c74689cc1b22f6::queen_maker::QueenMaker, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg7: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg1.sui_hive_pool_addr) && *0x1::option::borrow<address>(&arg1.sui_hive_pool_addr) == 0x2::object::uid_to_address(&arg4.id), 5031);
        assert!(0x1::option::is_some<address>(&arg1.sui_honey_pool_addr) && *0x1::option::borrow<address>(&arg1.sui_honey_pool_addr) == 0x2::object::uid_to_address(&arg5.id), 5038);
        let v0 = if (arg1.module_version == 0) {
            if (arg4.module_version == 0) {
                arg5.module_version == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5036);
        let (v1, v2, v3) = 0xf19a586bb1ba1ec97b063c22b58534444ada26a8f81a049327c74689cc1b22f6::queen_maker::increment_queen_maker(&arg1.fee_claim_cap, arg2, arg3, arg8);
        let v4 = v3;
        if (!arg1.is_buyback_enabled) {
            let v5 = YieldFromQueenMakerClaimed{
                auction_over_for_epoch         : v1,
                total_sui_bidded               : v2,
                energy_yield                   : 0x2::balance::value<0x2::sui::SUI>(&v4),
                simulated_hive_buyback         : 0,
                simulated_honey_buyback        : 0,
                sui_for_hive_pool_amt          : 0,
                sui_for_honey_buyback_pool_amt : 0,
                sui_hive_lp_tokens_amt         : 0,
                sui_honey_lp_tokens_amt        : 0,
                third_pool_lp_tokens_amt       : 0,
            };
            0x2::event::emit<YieldFromQueenMakerClaimed>(v5);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.total_sui_collected, v4);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.total_sui_collected));
            let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
            let (_, _, _, _, v11, _, _) = query_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg4, v6, 0, 0, 1, true);
            let (_, _, _, _, v18, _, _) = query_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg5, v6, 0, 0, 1, true);
            0xf19a586bb1ba1ec97b063c22b58534444ada26a8f81a049327c74689cc1b22f6::queen_maker::increment_energy_and_health(&arg1.fee_claim_cap, arg3, v1, v11, v18);
            let v21 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision();
            let v22 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&v4), arg1.sui_for_hive_pool_pct, v21);
            let v23 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&v4), arg1.sui_for_honey_pool_pct, v21);
            let v24 = add_liquidity<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v22), 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(), 0);
            dangerous_burn_lp_coins<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg4, v24);
            let v25 = add_liquidity<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v23), 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 0);
            dangerous_burn_lp_coins<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg5, v25);
            let v26 = 0;
            if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0 && 0x1::option::is_some<address>(&arg1.third_pool_addr)) {
                assert!(*0x1::option::borrow<address>(&arg1.third_pool_addr) == 0x2::object::uid_to_address(&arg6.id), 5037);
                let v27 = add_liquidity<0x2::sui::SUI, T0, T1>(arg0, arg6, v4, 0x2::balance::zero<T0>(), 0);
                v26 = 0x2::balance::value<LP<0x2::sui::SUI, T0, T1>>(&v27);
                dangerous_burn_lp_coins<0x2::sui::SUI, T0, T1>(arg6, v27);
            } else if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
                0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg7, v4);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            };
            let v28 = YieldFromQueenMakerClaimed{
                auction_over_for_epoch         : v1,
                total_sui_bidded               : v2,
                energy_yield                   : v6,
                simulated_hive_buyback         : v11,
                simulated_honey_buyback        : v18,
                sui_for_hive_pool_amt          : v22,
                sui_for_honey_buyback_pool_amt : v23,
                sui_hive_lp_tokens_amt         : 0x2::balance::value<LP<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>>(&v24),
                sui_honey_lp_tokens_amt        : 0x2::balance::value<LP<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>>(&v25),
                third_pool_lp_tokens_amt       : v26,
            };
            0x2::event::emit<YieldFromQueenMakerClaimed>(v28);
        };
    }

    public fun convert_sui_fees_to_hive_and_honey(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2) > 0) {
            let (v0, v1, v2) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::get_sui_fee_distribution_info(arg1);
            let v3 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg2), v0, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            let v4 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg2), v1, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v3));
            let (v5, v6) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v4), 0, 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 1, true);
            let v7 = v6;
            let v8 = 0x2::balance::value<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(&v7);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
            let (v9, v10) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg4, arg2, 0, 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(), 1, true);
            let v11 = v10;
            let v12 = 0x2::balance::value<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(&v11);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
            let v13 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(v12, v2, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            let v14 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(v8, v2, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::add_balance_to_pool_flow(arg1, arg3, 0x2::balance::split<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(&mut v11, v13), 0x2::balance::split<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(&mut v7, v14));
            0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_hive_for_distribution(arg6, v11);
            0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_honey_for_distribution(arg6, v7);
            let v15 = SuiFeeUsedForBuybacks{
                pool_addr             : arg3,
                sui_for_treasury      : v3,
                sui_for_honey_buyback : v4,
                honey_bought_amt      : v8,
                sui_for_hive_buyback  : 0x2::balance::value<0x2::sui::SUI>(&arg2),
                hive_bought_amt       : v12,
                hive_for_voters_amt   : v13,
                honey_for_voters_amt  : v14,
            };
            0x2::event::emit<SuiFeeUsedForBuybacks>(v15);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public fun dangerous_burn_lp_coins<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg0.module_version == 0, 5036);
        let v0 = LpBurntForever{
            pool_addr : 0x2::object::uid_to_address(&arg0.id),
            lp_burned : 0x2::balance::value<LP<T0, T1, T2>>(&arg1),
        };
        0x2::event::emit<LpBurntForever>(v0);
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg0.lp_supply, arg1);
    }

    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::get_decimals<T0>(arg6), 0x2::coin::get_decimals<T1>(arg7), arg8, arg9, arg10, arg11);
        v1
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T1>(arg2);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::get_decimals<T0>(arg6), v0, arg7, arg8, arg9, arg10);
        v2
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T0>(arg2);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, v0, 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v2
    }

    public fun flashloan<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Flashloan<T0, T1, T2>, u64, u64) {
        assert!(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg2 > 0 || arg3 > 0, 5018);
        assert!(!arg1.is_locked, 5009);
        assert!(arg1.module_version == 0, 5036);
        let v0 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, arg2);
        let v1 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, arg3);
        let v2 = arg1.fee_info.total_fee_bps;
        arg1.is_locked = true;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let v3 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision();
        let v4 = arg2 + (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v5 = arg3 + (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg3 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v6 = Flashloan<T0, T1, T2>{
            x_loan : v4,
            y_loan : v5,
        };
        (v0, v1, v6, v4, v5)
    }

    public fun get_collected_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.collected_fee_x), 0x2::balance::value<T1>(&arg0.collected_fee_y))
    }

    fun get_decimal_for_coin<T0>(arg0: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow) : u8 {
        let (v0, v1) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::get_decimals_for_coin<T0>(arg0);
        assert!(v0, 5001);
        v1
    }

    public fun get_liquidity_pool_id<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_pool_addr<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_pool_cumulative_prices<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u64) {
        (arg0.cumulative_x_price, arg0.cumulative_y_price, arg0.last_timestamp)
    }

    public fun get_pool_curved_config_amp_gamma<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, u256, u256) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_amp_gamma_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u256, u256, u256) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_fee_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_precision<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : vector<u256> {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_prices_info<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_xcp<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u256, bool) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_fee_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (arg0.fee_info.total_fee_bps, arg0.fee_info.bees_fee_pct)
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &PoolRegistry) : 0x2::object::ID {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        *0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun get_pool_id_as_address<T0, T1, T2>(arg0: &PoolRegistry) : address {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0))
    }

    public fun get_pool_registry(arg0: &PoolRegistry) : (u64, bool) {
        (0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list), 0x1::option::is_some<address>(&arg0.sui_hive_pool_addr))
    }

    public fun get_pool_reserves<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve))
    }

    public fun get_pool_reserves_decimals<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u8, u8) {
        (arg0.coin_x_decimals, arg0.coin_y_decimals)
    }

    public fun get_pool_stable_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, vector<u256>) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::get_stable_config_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(&arg0.stable_config))
    }

    public fun get_pool_total_supply<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64) {
        let v0 = arg0.total_lp_krafted;
        let v1 = 0x2::balance::supply_value<LP<T0, T1, T2>>(&arg0.lp_supply);
        (v0, v1, v0 - v1)
    }

    public fun get_pool_weighted_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u64>, vector<u256>, u64, u64) {
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_weighted_config_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg0.weighted_config))
    }

    public fun get_poolhive_addr<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : address {
        *0x1::option::borrow<address>(&arg0.pool_hive_addr)
    }

    public fun get_scaling_factor<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>) : (u64, vector<u256>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            v1 = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config));
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            let (v2, v3) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(&arg1.stable_config));
            v1 = v3;
            v0 = v2;
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_weighted<T2>()) {
            v1 = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config));
        };
        (v0, v1)
    }

    public fun get_sui_hive_pool_for_pol(arg0: &PoolRegistry) : address {
        *0x1::option::borrow<address>(&arg0.sui_hive_pool_addr)
    }

    public entry fun harvest_hive_fee(arg0: &PoolRegistry, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg3: &0x2::tx_context::TxContext) {
        0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_hive_for_distribution(arg2, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::extract_fee_for_coin_2amm<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(&arg0.fee_claim_cap, arg1));
    }

    public entry fun harvest_honey_fee(arg0: &PoolRegistry, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>, arg2: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg3: &0x2::tx_context::TxContext) {
        0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_honey_for_distribution(arg2, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::extract_fee_for_coin_2amm<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(&arg0.fee_claim_cap, arg1));
    }

    fun imbalanced_exit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : (u64, vector<u64>) {
        let (v0, v1) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v2 = v1;
        let (v3, v4) = if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            let (v5, v6) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::imbalanced_liquidity_withdraw(v0, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(arg3), v2), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v6;
            (v3, v5)
        } else {
            let (v7, v8) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::imbalanced_liquidity_withdraw(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(arg3), v2), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v8;
            (v3, v7)
        };
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 0) / *0x1::vector::borrow<u256>(&v2, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 1) / *0x1::vector::borrow<u256>(&v2, 1)) as u64));
        ((0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(v4, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64), v9)
    }

    public entry fun increment_liquidity_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    public entry fun increment_pool_registry(arg0: &mut PoolRegistry) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_pool_registry(arg0: 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::TwoAmmFlowAccess, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                     : 0x2::object::new(arg3),
            kraft_fee              : 0,
            krafted_pools_list     : 0x2::linked_table::new<PoolRegistryItem, 0x2::object::ID>(arg3),
            fee_claim_cap          : arg0,
            sui_hive_pool_addr     : 0x1::option::none<address>(),
            sui_for_hive_pool_pct  : arg1,
            sui_honey_pool_addr    : 0x1::option::none<address>(),
            sui_for_honey_pool_pct : arg2,
            third_pool_addr        : 0x1::option::none<address>(),
            total_sui_collected    : 0x2::balance::zero<0x2::sui::SUI>(),
            is_buyback_enabled     : false,
            module_version         : 0,
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun internal_add_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : u64 {
        assert!(!arg1.is_locked, 5009);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        let v2 = (arg1.total_lp_krafted as u128);
        if (v2 == 0) {
            assert!(v0 > 0 && v1 > 0, 5021);
        };
        let v3 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v4 = arg1.fee_info.total_fee_bps;
        let v5 = arg1.fee_info.bees_fee_pct;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v6, v7) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v8 = v7;
        let (v9, v10) = if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            let (v11, v12) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::add_liquidity_computation(arg0, 0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(v3, v8), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
            let v9 = v12;
            let (v13, v14, v15, v16) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v17, v18, v19, v20) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v21 = InternalPricesUpdated<T0, T1, T2>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v13,
                oracle_prices         : v14,
                last_prices           : v15,
                last_prices_timestamp : v16,
                virtual_price         : v18,
                xcp_profit            : v19,
                not_adjusted          : v20,
                _D                    : v17,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v21);
            (v9, v11)
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            let (v22, v23) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::add_liquidity_computation(v6, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(v3, v8), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
            let v9 = v23;
            (v9, v22)
        } else {
            let (v24, v25) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::add_liquidity_computation(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(v3, v8), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
            let v9 = v25;
            (v9, v24)
        };
        let v26 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256(v10, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64);
        let v27 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v27, ((*0x1::vector::borrow<u256>(&v9, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v27, ((*0x1::vector::borrow<u256>(&v9, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
        assert!(v26 > 0, 5007);
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, arg3);
        let v28 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v27, 0));
        let v29 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v27, 1));
        let v30 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision();
        let v31 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((*0x1::vector::borrow<u64>(&v27, 0) as u128), (v5 as u128), (v30 as u128)) as u64);
        let v32 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((*0x1::vector::borrow<u64>(&v27, 1) as u128), (v5 as u128), (v30 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.collected_fee_x, 0x2::balance::split<T0>(&mut v28, v31));
        0x2::balance::join<T1>(&mut arg1.collected_fee_y, 0x2::balance::split<T1>(&mut v29, v32));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v28);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v29);
        let v33 = LiquidityAddedToPool<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : v0,
            coin_y_amount : v1,
            lp_minted     : v26,
            total_x_fee   : *0x1::vector::borrow<u64>(&v27, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v27, 1),
            x_hive_fee    : v31,
            y_hive_fee    : v32,
        };
        0x2::event::emit<LiquidityAddedToPool<T0, T1, T2>>(v33);
        v26
    }

    fun internal_register_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: u8, arg6: u8, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg2.module_version == 0, 5036);
        0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg4, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, arg2.kraft_fee));
        0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::assert_valid_curve<T2>();
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::uid_to_address(&v0);
        registry_add<T0, T1, T2>(arg2, arg1, arg5, arg6, 0x2::object::uid_to_inner(&v0));
        let (v2, v3) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::get_fee_info<T2>(arg1);
        let v4 = NewPoolCreated<T0, T1, T2>{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewPoolCreated<T0, T1, T2>>(v4);
        let v5 = LP<T0, T1, T2>{dummy_field: false};
        let v6 = PoolFeeInfo{
            total_fee_bps : v2,
            bees_fee_pct  : v3,
        };
        let v7 = LiquidityPool<T0, T1, T2>{
            id                 : v0,
            coin_x_reserve     : 0x2::balance::zero<T0>(),
            coin_x_decimals    : arg5,
            coin_y_reserve     : 0x2::balance::zero<T1>(),
            coin_y_decimals    : arg6,
            lp_supply          : 0x2::balance::create_supply<LP<T0, T1, T2>>(v5),
            total_lp_krafted   : 0,
            curved_config      : 0x1::option::none<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(),
            stable_config      : 0x1::option::none<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(),
            weighted_config    : 0x1::option::none<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(),
            collected_fee_x    : 0x2::balance::zero<T0>(),
            collected_fee_y    : 0x2::balance::zero<T1>(),
            fee_info           : v6,
            is_locked          : false,
            cumulative_x_price : 0,
            cumulative_y_price : 0,
            last_timestamp     : 0x2::clock::timestamp_ms(arg0),
            pool_hive_addr     : 0x1::option::none<address>(),
            is_swap_enabled    : true,
            module_version     : 0,
        };
        let v8 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v8, 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::computeScalingFactor(arg5));
        0x1::vector::push_back<u256>(&mut v8, 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::computeScalingFactor(arg6));
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            assert!(0x1::option::is_some<vector<u256>>(&arg8), 5003);
            v7.curved_config = 0x1::option::some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::initialize_curved_config(arg0, arg7, 0x1::option::extract<vector<u256>>(&mut arg8), v8, (2 as u128), arg10));
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            v7.stable_config = 0x1::option::some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::StablePoolConfig>(0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::initialize_stable_config(arg0, arg7, v8, arg10));
        } else {
            assert!(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_weighted<T2>(), 5024);
            assert!(0x1::option::is_some<vector<u64>>(&arg9), 5004);
            v7.weighted_config = 0x1::option::some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::initialize_weighted_config(arg7, 0x1::option::extract<vector<u64>>(&mut arg9), v8, 2, arg10));
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1, T2>>(v7);
        if (!0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::is_fee_collector_present<T0>(arg1)) {
            0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::create_fee_collector<T0>(arg1, arg10);
        };
        if (!0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::is_fee_collector_present<T1>(arg1)) {
            0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::create_fee_collector<T1>(arg1, arg10);
        };
        0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::add_new_two_pool_flow(arg1, &arg2.fee_claim_cap, v1);
        (v1, arg3)
    }

    fun internal_remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64) {
        assert!(!arg1.is_locked, 5009);
        let v0 = (arg1.total_lp_krafted as u128);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = arg1.fee_info.total_fee_bps;
        let v4 = arg1.fee_info.bees_fee_pct;
        let v5 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v6 = arg2;
        let v7 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::create_zero_vector(2);
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        if (arg3 == 0 && arg4 == 0) {
            *0x1::vector::borrow_mut<u64>(&mut v5, 0) = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), (v1 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v5, 1) = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), (v2 as u256), (v0 as u256)) as u64);
            if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
                0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::reduce_d(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v0 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
            };
        } else {
            if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
                abort 5011
            };
            let (v8, v9) = imbalanced_exit<T0, T1, T2>(arg0, arg1, (v0 as u64), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()), v5, v3);
            v7 = v9;
            v6 = v8;
        };
        assert!(v6 > 0, 5010);
        let v10 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v5, 0));
        let v11 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v5, 1));
        let v12 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision();
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_weighted<T2>()) {
            let v13 = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_exit_fee(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config));
            *0x1::vector::borrow_mut<u64>(&mut v7, 0) = *0x1::vector::borrow<u64>(&v7, 0) + 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(*0x1::vector::borrow<u64>(&v5, 0), v13, v12);
            *0x1::vector::borrow_mut<u64>(&mut v7, 1) = *0x1::vector::borrow<u64>(&v7, 1) + 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(*0x1::vector::borrow<u64>(&v5, 1), v13, v12);
        };
        let v14 = if (0x2::balance::value<T0>(&v10) >= *0x1::vector::borrow<u64>(&v7, 0)) {
            0x2::balance::split<T0>(&mut v10, *0x1::vector::borrow<u64>(&v7, 0))
        } else {
            0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v7, 0))
        };
        let v15 = if (0x2::balance::value<T1>(&v11) >= *0x1::vector::borrow<u64>(&v7, 1)) {
            0x2::balance::split<T1>(&mut v11, *0x1::vector::borrow<u64>(&v7, 1))
        } else {
            0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v7, 1))
        };
        let v16 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision();
        let v17 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 0) as u128), (v4 as u128), (v16 as u128)) as u64);
        let v18 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 1) as u128), (v4 as u128), (v16 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.collected_fee_x, 0x2::balance::split<T0>(&mut v14, v17));
        0x2::balance::join<T1>(&mut arg1.collected_fee_y, 0x2::balance::split<T1>(&mut v15, v18));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v14);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v15);
        let v19 = LiquidityRemovedFromPool<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : *0x1::vector::borrow<u64>(&v5, 0),
            coin_y_amount : *0x1::vector::borrow<u64>(&v5, 1),
            lp_burned     : v6,
            total_x_fee   : *0x1::vector::borrow<u64>(&v7, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v7, 1),
            x_hive_fee    : v17,
            y_hive_fee    : v18,
        };
        0x2::event::emit<LiquidityRemovedFromPool<T0, T1, T2>>(v19);
        (v10, v11, arg2 - v6)
    }

    fun internal_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        assert!(arg1.module_version == 0, 5036);
        assert!(arg1.is_swap_enabled, 5040);
        let (v0, v1, v2) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::get_asset_index_and_amount(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::create_vector(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg4)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v2, 5012);
        let (v3, v4, v5) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::get_asset_index_and_amount(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v5, 5013);
        assert!(v1 != v4, 5014);
        let v6 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v7 = (arg1.total_lp_krafted as u128);
        let v8 = arg1.fee_info.total_fee_bps;
        let v9 = arg1.fee_info.bees_fee_pct;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v13, v14) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u256>(&v15, v4);
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            if (arg6) {
                v10 = v0;
                let (v17, v18) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::compute_ask_amount(arg0, 0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v0 as u256) * *0x1::vector::borrow<u256>(&v15, v1), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v15), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v7 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
                v11 = ((v17 / v16) as u64);
                v12 = ((v18 / v16) as u64);
            } else {
                let (v19, v20) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::compute_offer_amount(arg0, 0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v3 as u256) * v16, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v15), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v7 as u256), 1000000000000000000, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_u256(10, (6 as u128))));
                v10 = ((v19 / *0x1::vector::borrow<u256>(&v15, v1)) as u64);
                let v21 = ((v20 / v16) as u64);
                v12 = v21;
                v11 = v3 + v21;
            };
            let (v22, v23, v24, v25) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v26, v27, v28, v29) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v30 = InternalPricesUpdated<T0, T1, T2>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v22,
                oracle_prices         : v23,
                last_prices           : v24,
                last_prices_timestamp : v25,
                virtual_price         : v27,
                xcp_profit            : v28,
                not_adjusted          : v29,
                _D                    : v26,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v30);
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            if (arg6) {
                v10 = v0;
                let v31 = ((0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::compute_ask_amount(v13, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v15, v1), v4, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v15)) / v16) as u64);
                v11 = v31;
                v12 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((v8 as u128), (v31 as u128), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v32, v33) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::compute_offer_amount(v13, (v3 as u256) * v16, v4, v1, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v15), v8);
                v10 = ((v32 / *0x1::vector::borrow<u256>(&v15, v1)) as u64);
                let v34 = ((v33 / v16) as u64);
                v12 = v34;
                v11 = v3 + v34;
            };
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_weighted<T2>()) {
            let (v35, v36) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config), v1, true);
            let (v37, v38) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config), v4, true);
            if (arg6) {
                v10 = v0;
                let v39 = ((0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::compute_ask_amount((v0 as u256) * v36, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v36, (v35 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v38, (v37 as u256)) / v38) as u64);
                v11 = v39;
                v12 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((v8 as u128), (v39 as u128), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v40, v41) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::compute_offer_amount((v3 as u256) * v38, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v38, (v37 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v36, (v35 as u256), v8);
                v10 = ((v40 / v36) as u64);
                let v42 = ((v41 / v38) as u64);
                v12 = v42;
                v11 = v3 + v42;
            };
        };
        assert!(v11 >= v3, 5016);
        assert!(v10 <= v0, 5017);
        let v43 = 0;
        let v44 = 0;
        let v45 = 0;
        let v46 = 0;
        let v47 = 0;
        let v48 = 0;
        let v49 = 0;
        let v50 = 0;
        if (v1 == 0 && v4 == 1) {
            v43 = v10;
            v47 = v11 - v12;
            v48 = v12;
            let (v51, v52) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::process_coin_balances_processing_for_swap<T0, T1>(&mut arg1.coin_x_reserve, &mut arg2, v10, &mut arg1.coin_y_reserve, &mut arg4, v11, v12, v9);
            v50 = v52;
            0x2::balance::join<T1>(&mut arg1.collected_fee_y, v51);
        } else if (v1 == 1 && v4 == 0) {
            v46 = v10;
            v44 = v11 - v12;
            v45 = v12;
            let (v53, v54) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::process_coin_balances_processing_for_swap<T1, T0>(&mut arg1.coin_y_reserve, &mut arg4, v10, &mut arg1.coin_x_reserve, &mut arg2, v11, v12, v9);
            v49 = v54;
            0x2::balance::join<T0>(&mut arg1.collected_fee_x, v53);
        };
        let v55 = TokensSwapped<T0, T1, T2>{
            id           : 0x2::object::uid_to_inner(&arg1.id),
            x_offer_amt  : v43,
            y_offer_amt  : v46,
            x_return_amt : v44,
            y_return_amt : v47,
            x_total_fee  : v45,
            y_total_fee  : v48,
            x_hive_fee   : v49,
            y_hive_fee   : v50,
        };
        0x2::event::emit<TokensSwapped<T0, T1, T2>>(v55);
        (arg2, arg4)
    }

    public fun is_pool_registered<T0, T1, T2>(arg0: &PoolRegistry) : bool {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun lock_in_sui_hive_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg2.module_version == 0, 5036);
        assert!(0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>() == 0x1::type_name::get<T1>(), 5001);
        assert!(0x1::option::is_none<address>(&arg2.sui_hive_pool_addr), 5030);
        let v0 = get_decimal_for_coin<T0>(arg1);
        let (v1, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, 0x2::coin::get_decimals<T1>(arg3), arg6, arg7, arg8, arg9);
        arg2.sui_hive_pool_addr = 0x1::option::some<address>(v1);
        let v3 = SUI_HIVE_INITIALIZED{sui_hive_pool_addr: v1};
        0x2::event::emit<SUI_HIVE_INITIALIZED>(v3);
        (v1, v2)
    }

    public fun lock_in_sui_honey_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = get_decimal_for_coin<T0>(arg1);
        let (v1, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, 0x2::coin::get_decimals<T1>(arg3), arg6, arg7, arg8, arg9);
        arg2.sui_honey_pool_addr = 0x1::option::some<address>(v1);
        let v3 = SUI_HONEY_INITIALIZED{sui_honey_pool_addr: v1};
        0x2::event::emit<SUI_HONEY_INITIALIZED>(v3);
        (v1, v2)
    }

    public fun pay_flashloan<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: Flashloan<T0, T1, T2>) {
        assert!(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg0.module_version == 0, 5036);
        let Flashloan {
            x_loan : v0,
            y_loan : v1,
        } = arg3;
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 >= v0 && v3 >= v1, 5020);
        let v4 = arg0.fee_info.total_fee_bps;
        let v5 = arg0.fee_info.bees_fee_pct;
        let v6 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision();
        let v7 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v2 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v8 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v3 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v9 = 0x2::balance::split<T0>(&mut arg1, v7);
        let v10 = 0x2::balance::split<T1>(&mut arg2, v8);
        let v11 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision();
        let v12 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(v7, v5, v11);
        let v13 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(v8, v5, v11);
        0x2::balance::join<T0>(&mut arg0.collected_fee_x, 0x2::balance::split<T0>(&mut v9, v12));
        0x2::balance::join<T1>(&mut arg0.collected_fee_y, 0x2::balance::split<T1>(&mut v10, v13));
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, arg2);
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, v9);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, v10);
        let v14 = FlashLoanExecuted<T0, T1, T2>{
            id          : 0x2::object::uid_to_inner(&arg0.id),
            x_loan      : v0,
            y_loan      : v1,
            total_x_fee : v7,
            total_y_fee : v8,
            x_hive_fee  : v12,
            y_hive_fee  : v13,
        };
        0x2::event::emit<FlashLoanExecuted<T0, T1, T2>>(v14);
        arg0.is_locked = false;
    }

    public fun query_across_all_pools<T0, T1, T2>(arg0: &PoolRegistry, arg1: u64) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        let v5 = 0x1::option::some<PoolRegistryItem>(v4);
        let v6 = 0;
        while (0x1::option::is_some<PoolRegistryItem>(&v5) && v6 < arg1) {
            let v7 = *0x1::option::borrow<PoolRegistryItem>(&v5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(v7.a)));
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::from_ascii(0x1::type_name::into_string(v7.b)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(v7.curve)));
            0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v7)));
            v5 = *0x2::linked_table::next<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v7);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v0, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public fun query_first_pool(arg0: &PoolRegistry) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64) {
        let v0 = *0x2::linked_table::front<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list);
        let v1 = *0x1::option::borrow<PoolRegistryItem>(&v0);
        (0x1::string::from_ascii(0x1::type_name::into_string(v1.a)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.b)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.curve)), 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v1)), 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public entry fun query_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : (u64, u64, u64, u64, u64, u64, u64) {
        if (arg1.is_locked) {
            return (0, 0, 0, 0, 0, 0, 5009)
        };
        let (v0, v1, v2) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::get_asset_index_and_amount(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::create_vector(0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v2) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        let (v3, v4, v5) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::get_asset_index_and_amount(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        if (v1 == v4) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        let v6 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        if (v3 > *0x1::vector::borrow<u64>(&v6, v4)) {
            return (0, 0, 0, 0, 0, 0, 5028)
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let (v10, v11) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v12 = v11;
        let v13 = *0x1::vector::borrow<u256>(&v12, v4);
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            if (arg6) {
                v7 = v0;
                let (v14, v15) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::query_ask_amount(arg0, 0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v12), (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), v1, v4);
                v8 = ((v14 / v13) as u64);
                v9 = ((v15 / v13) as u64);
            } else {
                let (v16, v17) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::query_offer_amount(arg0, 0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg1.curved_config), 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v12), (v3 as u256) * v13, v1, v4);
                v7 = ((v16 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v18 = ((v17 / v13) as u64);
                v9 = v18;
                v8 = v3 + v18;
            };
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_stable<T2>()) {
            if (arg6) {
                v7 = v0;
                let v19 = ((0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::compute_ask_amount(v10, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), v4, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v12)) / v13) as u64);
                v8 = v19;
                v9 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v19 as u128), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v20, v21) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::stable_math::compute_offer_amount(v10, (v3 as u256) * v13, v4, v1, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::multiply_vectors_u256(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::vector_u64_to_u256(v6), v12), arg1.fee_info.total_fee_bps);
                v7 = ((v20 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v22 = ((v21 / v13) as u64);
                v9 = v22;
                v8 = v3 + v22;
            };
        } else if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_weighted<T2>()) {
            let v23 = 0x1::option::borrow<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::WeightedConfig>(&arg1.weighted_config);
            let (v24, v25) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_weight_and_sf_at_index(v23, v1, true);
            let (v26, v27) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::get_weight_and_sf_at_index(v23, v4, true);
            if (arg6) {
                v7 = v0;
                let v28 = ((0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::compute_ask_amount((v0 as u256) * v25, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v25, (v24 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v27, (v26 as u256)) / v27) as u64);
                v8 = v28;
                v9 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v28 as u128), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v29, v30) = 0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::weighted_math::compute_offer_amount((v3 as u256) * v27, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v27, (v26 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v25, (v24 as u256), arg1.fee_info.total_fee_bps);
                v7 = ((v29 / v25) as u64);
                let v31 = ((v30 / v27) as u64);
                v9 = v31;
                v8 = v3 + v31;
            };
        };
        if (v8 < v3) {
            return (0, 0, 0, 0, 0, 0, 5016)
        };
        if (v7 > v0) {
            return (0, 0, 0, 0, 0, 0, 5017)
        };
        let v32 = 0;
        let v33 = 0;
        let v34 = 0;
        let v35 = 0;
        let v36 = 0;
        let v37 = 0;
        if (v1 == 0 && v4 == 1) {
            v32 = v7;
            v36 = v8 - v9;
            v37 = v9;
        } else if (v1 == 1 && v4 == 0) {
            v35 = v7;
            v33 = v8 - v9;
            v34 = v9;
        };
        (v32, v33, v34, v35, v36, v37, 0)
    }

    public fun register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::get_decimals<T0>(arg5), 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v1
    }

    public fun register_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: vector<u64>, arg6: 0x1::option::Option<vector<u256>>, arg7: 0x1::option::Option<vector<u64>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T0>(arg1);
        let v1 = get_decimal_for_coin<T1>(arg1);
        let (_, v3) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, v1, arg5, arg6, arg7, arg8);
        v3
    }

    public fun register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T1>(arg1);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::get_decimals<T0>(arg5), v0, arg6, arg7, arg8, arg9);
        v2
    }

    public fun register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T0>(arg1);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, 0x2::coin::get_decimals<T1>(arg5), arg6, arg7, arg8, arg9);
        v2
    }

    fun registry_add<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: u8, arg3: u8, arg4: 0x2::object::ID) {
        if (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::is_curved<T2>()) {
            assert!(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::valid_curved_coins_2_pool<T0, T1>(arg1), 5005);
        } else {
            assert!(0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::coin_helper::is_sorted<T0, T1>(), 5006);
        };
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        assert!(!0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0), 5002);
        0x2::linked_table::push_back<PoolRegistryItem, 0x2::object::ID>(&mut arg0.krafted_pools_list, v0, arg4);
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg1.module_version == 0, 5036);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5034);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5034);
        let v0 = 0x2::balance::value<LP<T0, T1, T2>>(&arg2);
        let (v1, v2, v3) = internal_remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg3, arg4);
        let v4 = v0 - v3;
        if (arg5 > 0) {
            assert!(v4 <= arg5, 5015);
        };
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, 0x2::balance::split<LP<T0, T1, T2>>(&mut arg2, v4));
        arg1.total_lp_krafted = arg1.total_lp_krafted - v4;
        (v1, v2, arg2)
    }

    public(friend) fun remove_liquidity_from_x_honey_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg1.module_version == 0, 5036);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5033);
        let v0 = 0x2::balance::value<LP<T0, T1, T2>>(&arg2);
        let (v1, v2, v3) = internal_remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg3, arg4);
        let v4 = v0 - v3;
        if (arg5 > 0) {
            assert!(v4 <= arg5, 5015);
        };
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, 0x2::balance::split<LP<T0, T1, T2>>(&mut arg2, v4));
        arg1.total_lp_krafted = arg1.total_lp_krafted - v4;
        (v1, v2, arg2)
    }

    public fun set_pool_hive_addr<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: address) {
        assert!(arg0.module_version == 0, 5036);
        assert!(!0x1::option::is_some<address>(&arg0.pool_hive_addr), 5027);
        arg0.pool_hive_addr = 0x1::option::some<address>(arg2);
    }

    public(friend) fun swap_honey_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 5033);
        internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun switch_buyback(arg0: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg1: &mut PoolRegistry) {
        arg1.is_buyback_enabled = !arg1.is_buyback_enabled;
    }

    public fun switch_swap_switch<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DeployerCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 5036);
        arg0.is_swap_enabled = arg2;
    }

    fun update_cumulative_prices<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>) {
        let v0 = (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::twap_precision() as u8);
        let v1 = 0x2::clock::timestamp_ms(arg0) - arg1.last_timestamp;
        let v2 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v3 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v4 = if (v1 > 0) {
            if (v2 != 0) {
                v3 != 0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            arg1.cumulative_x_price = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::overflow_add_u256(arg1.cumulative_x_price, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v3 as u256), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_10(v0) as u256), (v2 as u256)) * (v1 as u256));
            arg1.cumulative_y_price = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::overflow_add_u256(arg1.cumulative_y_price, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div_u256((v2 as u256), (0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::pow_10(v0) as u256), (v3 as u256)) * (v1 as u256));
            arg1.last_timestamp = 0x2::clock::timestamp_ms(arg0);
        };
        let v5 = CumPriceUpdatedEvent<T0, T1, T2>{
            id                 : 0x2::object::uid_to_inner(&arg1.id),
            cumulative_x_price : arg1.cumulative_x_price,
            cumulative_y_price : arg1.cumulative_y_price,
            timestamp          : arg1.last_timestamp,
        };
        0x2::event::emit<CumPriceUpdatedEvent<T0, T1, T2>>(v5);
    }

    public entry fun update_curved_A_and_gamma<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::update_A_and_gamma(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5);
        let v0 = CurvedConfigUpdatedAmp<T0, T1, T2>{
            id                  : 0x2::object::uid_to_inner(&arg0.id),
            init_A_gamma_time   : arg2,
            next_amp            : arg3,
            next_gamma          : arg4,
            future_A_gamma_time : arg5,
        };
        0x2::event::emit<CurvedConfigUpdatedAmp<T0, T1, T2>>(v0);
    }

    public fun update_curved_config_fee_params<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::update_config_fee_params(0x1::option::borrow_mut<0x8545629a7093f67d28214ce430a09c25af57ec86ab01aa0769db39fd289a7d76::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurvedConfigUpdatedParams<T0, T1, T2>{
            id                       : 0x2::object::uid_to_inner(&arg0.id),
            new_mid_fee              : arg2,
            new_out_fee              : arg3,
            new_fee_gamma            : arg4,
            new_ma_half_time         : arg5,
            new_allowed_extra_profit : arg6,
            new_adjustment_step      : arg7,
        };
        0x2::event::emit<CurvedConfigUpdatedParams<T0, T1, T2>>(v0);
    }

    public fun update_fee_for_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonFoodCapability, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(arg2 >= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::min_swap_fee() && arg2 <= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::max_swap_fee(), 5000);
        assert!(arg3 >= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::min_hive_fee() && arg3 <= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::max_hive_fee(), 5026);
        arg0.fee_info.total_fee_bps = arg2;
        arg0.fee_info.bees_fee_pct = arg3;
        let v0 = PoolFeeUpdated{
            id            : 0x2::object::uid_to_inner(&arg0.id),
            total_fee_bps : arg2,
            bees_fee_pct  : arg3,
        };
        0x2::event::emit<PoolFeeUpdated>(v0);
    }

    public fun update_kraft_fee(arg0: &mut PoolRegistry, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonDaoCapability, arg2: u64) {
        assert!(arg0.module_version == 0, 5036);
        arg0.kraft_fee = arg2;
    }

    public fun update_sui_pol_distribution(arg0: &mut PoolRegistry, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonDaoCapability, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        if (arg2 > 0) {
            arg0.sui_for_hive_pool_pct = arg2;
        };
        if (arg3 > 0) {
            arg0.sui_for_honey_pool_pct = arg3;
        };
        assert!(arg0.sui_for_hive_pool_pct + arg0.sui_for_honey_pool_pct <= 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision(), 5039);
        let v0 = SuiPolDistributionUpdated{
            sui_for_hive_pool_pct  : arg0.sui_for_hive_pool_pct,
            sui_for_honey_pool_pct : arg0.sui_for_honey_pool_pct,
        };
        0x2::event::emit<SuiPolDistributionUpdated>(v0);
    }

    public fun update_third_pool_for_pol<T0, T1>(arg0: &mut PoolRegistry, arg1: &0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::DragonDaoCapability, arg2: &mut LiquidityPool<0x2::sui::SUI, T0, T1>) {
        assert!(arg0.module_version == 0, 5036);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        arg0.third_pool_addr = 0x1::option::some<address>(v0);
        let v1 = SuiPolThirdPoolUpdated{third_pool_addr: v0};
        0x2::event::emit<SuiPolThirdPoolUpdated>(v1);
    }

    public entry fun use_sui_for_buybacks(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg5: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg6: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        use_sui_for_yield_farm(arg1, arg3, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::extract_fee_for_coin_2amm<0x2::sui::SUI>(&arg0.fee_claim_cap, arg2), arg5, arg6, arg4);
    }

    fun use_sui_for_yield_farm(arg0: &0x2::clock::Clock, arg1: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg5: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2) > 0) {
            let (v0, v1, _) = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::get_sui_fee_distribution_info(arg1);
            let v3 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg2), v0, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            let v4 = 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg2), v1, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::constants::percent_precision());
            0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v3));
            let (v5, v6) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v4), 0, 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(), 1, true);
            let v7 = v6;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
            let (v8, v9) = internal_swap<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>(arg0, arg3, arg2, 0, 0x2::balance::zero<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(), 1, true);
            let v10 = v9;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
            0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_hive_for_distribution(arg5, v10);
            0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::deposit_honey_for_distribution(arg5, v7);
            let v11 = SuiForYieldFarm{
                sui_for_treasury      : v3,
                sui_for_honey_buyback : v4,
                honey_bought_amt      : 0x2::balance::value<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY>(&v7),
                sui_for_hive_buyback  : 0x2::balance::value<0x2::sui::SUI>(&arg2),
                hive_bought_amt       : 0x2::balance::value<0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE>(&v10),
            };
            0x2::event::emit<SuiForYieldFarm>(v11);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public entry fun use_x_for_buybacks_via_sui_x_pool<T0, T1>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<T0>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg5: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg6: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg7: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        let (v0, v1) = internal_swap<0x2::sui::SUI, T0, T1>(arg1, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::extract_fee_for_coin_2amm<T0>(&arg0.fee_claim_cap, arg2), 0, true);
        0x2::balance::destroy_zero<T0>(v1);
        use_sui_for_yield_farm(arg1, arg3, v0, arg6, arg7, arg4);
    }

    public entry fun use_x_for_buybacks_via_x_sui_pool<T0, T1>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::FeeCollector<T0>, arg3: &mut 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::YieldFlow, arg4: &mut 0xce5c7485a2bc8e523dd57635c43ec1e1912d22289eb34b39b8ac1fe3454ba812::dragon_trainer::YieldFarm, arg5: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg6: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::hive::HIVE, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>, arg7: &mut LiquidityPool<0x2::sui::SUI, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::honey::HONEY, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::curves::Curved>) {
        let (v0, v1) = internal_swap<T0, 0x2::sui::SUI, T1>(arg1, arg5, 0x49ff1fad22d99ddda9118f3df46b83dccdc040f914f715c753aad0321bcd2f8e::yield_flow::extract_fee_for_coin_2amm<T0>(&arg0.fee_claim_cap, arg2), 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v0);
        use_sui_for_yield_farm(arg1, arg3, v1, arg6, arg7, arg4);
    }

    // decompiled from Move bytecode v6
}

