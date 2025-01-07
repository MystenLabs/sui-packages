module 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool {
    struct LP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        kraft_fee: u64,
        krafted_pools_list: 0x2::linked_table::LinkedTable<PoolRegistryItem, 0x2::object::ID>,
        fee_claim_cap: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::TwoAmmFeeClaimCapability,
        sui_hive_pool_addr: 0x1::option::Option<address>,
        sui_for_hive_pool_pct: u64,
        sui_bee_pool_addr: 0x1::option::Option<address>,
        sui_for_bee_pool_pct: u64,
        third_pool_addr: 0x1::option::Option<address>,
        public_kraft_enabled: bool,
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
        curved_config: 0x1::option::Option<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>,
        stable_config: 0x1::option::Option<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>,
        weighted_config: 0x1::option::Option<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>,
        hive_x: 0x2::balance::Balance<T0>,
        hive_y: 0x2::balance::Balance<T1>,
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
        hive_fee_percent: u64,
    }

    struct Flashloan<phantom T0, phantom T1, phantom T2> {
        x_loan: u64,
        y_loan: u64,
    }

    struct SuiPolDistributionUpdated has copy, drop {
        sui_for_hive_pool_pct: u64,
        sui_for_bee_pool_pct: u64,
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

    struct CollectedFeeForPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_fee_collected: u64,
        y_fee_collected: u64,
    }

    struct HarvestedDegenSui<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        dsui_for_hive: u64,
        dsui_for_treasury: u64,
        fee_balance_sold: u64,
    }

    struct PoolFeeUpdated has copy, drop {
        id: 0x2::object::ID,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct SUI_HIVE_Pool_Krafted has copy, drop {
        sui_hive_pool_addr: address,
    }

    struct SUI_BEE_Pool_Krafted has copy, drop {
        sui_bee_pool_addr: address,
    }

    public fun swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5034);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5034);
        internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun update_initial_prices<T0, T1, T2>(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: vector<u256>) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::update_initial_prices(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), arg2);
    }

    public entry fun update_stable_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(&arg0.stable_config), 5025);
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::update_stable_config(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(&mut arg0.stable_config), arg3, arg2, arg4);
        let v0 = StableConfigUpdated<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg0.id),
            init_amp_time : arg3,
            next_amp      : arg2,
            next_amp_time : arg4,
        };
        0x2::event::emit<StableConfigUpdated<T0, T1, T2>>(v0);
    }

    public entry fun update_weighted_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: vector<u64>, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg0.weighted_config), 5025);
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::update_weighted_config(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&mut arg0.weighted_config), arg2, arg3);
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
        0x1::debug::print<u64>(&v0);
        assert!(v0 >= arg4, 5008);
        arg1.total_lp_krafted = arg1.total_lp_krafted + v0;
        0x2::balance::increase_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, v0)
    }

    public fun claim_pol_from_streamer_buzz<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &PoolRegistry, arg3: &mut 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HiveVault, arg4: &mut LiquidityPool<T0, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE, T3>, arg5: &mut LiquidityPool<T0, T1, T4>, arg6: &mut LiquidityPool<T0, T2, T5>, arg7: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(0x1::option::is_some<address>(&arg2.sui_hive_pool_addr) && *0x1::option::borrow<address>(&arg2.sui_hive_pool_addr) == 0x2::object::uid_to_address(&arg4.id), 5031);
        assert!(0x1::option::is_some<address>(&arg2.sui_bee_pool_addr) && *0x1::option::borrow<address>(&arg2.sui_bee_pool_addr) == 0x2::object::uid_to_address(&arg5.id), 5038);
        assert!(arg2.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 5036);
        let v0 = 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::transfer_pol<T0>(&arg2.fee_claim_cap, arg3, arg8);
        let v1 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v2 = add_liquidity<T0, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE, T3>(arg0, arg4, 0x2::balance::split<T0>(&mut v0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(0x2::balance::value<T0>(&v0), arg2.sui_for_hive_pool_pct, v1)), 0x2::balance::zero<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(), 0);
        dangerous_burn_lp_coins<T0, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE, T3>(arg4, v2);
        let v3 = add_liquidity<T0, T1, T4>(arg0, arg5, 0x2::balance::split<T0>(&mut v0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(0x2::balance::value<T0>(&v0), arg2.sui_for_bee_pool_pct, v1)), 0x2::balance::zero<T1>(), 0);
        dangerous_burn_lp_coins<T0, T1, T4>(arg5, v3);
        let v4 = 0;
        if (0x2::balance::value<T0>(&v0) > 0 && 0x1::option::is_some<address>(&arg2.third_pool_addr)) {
            assert!(*0x1::option::borrow<address>(&arg2.third_pool_addr) == 0x2::object::uid_to_address(&arg6.id), 5037);
            let v5 = add_liquidity<T0, T2, T5>(arg0, arg6, v0, 0x2::balance::zero<T2>(), 0);
            v4 = 0x2::balance::value<LP<T0, T2, T5>>(&v5);
            dangerous_burn_lp_coins<T0, T2, T5>(arg6, v5);
        } else if (0x2::balance::value<T0>(&v0) > 0) {
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::collect_fee_for_coin<T0>(arg7, v0);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        (0x2::balance::value<LP<T0, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE, T3>>(&v2), 0x2::balance::value<LP<T0, T1, T4>>(&v3), v4)
    }

    public entry fun collect_fee_for_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T1>) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.hive_x);
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg0.hive_y);
        assert!(arg0.module_version == 0, 5036);
        let v2 = CollectedFeeForPool<T0, T1, T2>{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            x_fee_collected : 0x2::balance::value<T0>(&v0),
            y_fee_collected : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectedFeeForPool<T0, T1, T2>>(v2);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::collect_fee_for_coin<T0>(arg1, v0);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::collect_fee_for_coin<T1>(arg2, v1);
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

    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::get_decimals<T0>(arg6), 0x2::coin::get_decimals<T1>(arg7), arg8, arg9, arg10, arg11);
        v1
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T1>(arg2);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::get_decimals<T0>(arg6), v0, arg7, arg8, arg9, arg10);
        v2
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T0>(arg2);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, v0, 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v2
    }

    public fun distribute_degensui(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) : (u64, u64) {
        if (0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg3) > 0) {
            let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg3), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::get_hive_treasury_fee_info(arg0), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision());
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::deposit_to_treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg2, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg3, v2));
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::deposit_dsui_for_hive<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg1, arg3);
            (0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg3), v2)
        } else {
            0x2::balance::destroy_zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg3);
            (0, 0)
        }
    }

    public fun enable_public_pools(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg1: &mut PoolRegistry) {
        arg1.public_kraft_enabled = true;
    }

    public fun flashloan<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Flashloan<T0, T1, T2>, u64, u64) {
        assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg2 > 0 || arg3 > 0, 5018);
        assert!(!arg1.is_locked, 5009);
        assert!(arg1.module_version == 0, 5036);
        let v0 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, arg2);
        let v1 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, arg3);
        let v2 = arg1.fee_info.total_fee_bps;
        arg1.is_locked = true;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let v3 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision();
        let v4 = arg2 + (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v5 = arg3 + (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg3 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v6 = Flashloan<T0, T1, T2>{
            x_loan : v4,
            y_loan : v5,
        };
        (v0, v1, v6, v4, v5)
    }

    public fun get_collected_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.hive_x), 0x2::balance::value<T1>(&arg0.hive_y))
    }

    fun get_decimal_for_coin<T0>(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config) : u8 {
        let (v0, v1) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::get_decimals_for_coin<T0>(arg0);
        assert!(v0, 5001);
        v1
    }

    public fun get_liquidity_pool_id<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_pool_cumulative_prices<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u64) {
        (arg0.cumulative_x_price, arg0.cumulative_y_price, arg0.last_timestamp)
    }

    public fun get_pool_curved_config_amp_gamma<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, u256, u256) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_amp_gamma_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u256, u256, u256) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_fee_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_precision<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : vector<u256> {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_prices_info<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_xcp<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u256, bool) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_fee_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (arg0.fee_info.total_fee_bps, arg0.fee_info.hive_fee_percent)
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

    public fun get_pool_registery(arg0: &PoolRegistry) : (bool, u64, bool) {
        (arg0.public_kraft_enabled, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list), 0x1::option::is_some<address>(&arg0.sui_hive_pool_addr))
    }

    public fun get_pool_reserves<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve))
    }

    public fun get_pool_reserves_decimals<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u8, u8) {
        (arg0.coin_x_decimals, arg0.coin_y_decimals)
    }

    public fun get_pool_stable_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, vector<u256>) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::get_stable_config_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(&arg0.stable_config))
    }

    public fun get_pool_total_supply<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64) {
        let v0 = arg0.total_lp_krafted;
        let v1 = 0x2::balance::supply_value<LP<T0, T1, T2>>(&arg0.lp_supply);
        (v0, v1, v0 - v1)
    }

    public fun get_pool_weighted_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u64>, vector<u256>, u64, u64) {
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_weighted_config_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg0.weighted_config))
    }

    public fun get_poolhive_addr<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : address {
        *0x1::option::borrow<address>(&arg0.pool_hive_addr)
    }

    public fun get_scaling_factor<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>) : (u64, vector<u256>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            v1 = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config));
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            let (v2, v3) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(&arg1.stable_config));
            v1 = v3;
            v0 = v2;
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_weighted<T2>()) {
            v1 = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config));
        };
        (v0, v1)
    }

    public fun get_sui_hive_pool_for_pol(arg0: &PoolRegistry) : address {
        *0x1::option::borrow<address>(&arg0.sui_hive_pool_addr)
    }

    public entry fun harvest_collected_degensui_fee(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg1: &PoolRegistry, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        let (_, _) = distribute_degensui(arg0, arg3, arg4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.fee_claim_cap, arg2));
    }

    public entry fun harvest_dsui_for_collected_fee_x<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &PoolRegistry, arg3: &mut LiquidityPool<T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI, T1>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg2.fee_claim_cap, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            let (v2, v3) = internal_swap<T0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI, T1>(arg0, arg3, v0, 0, 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(), 1, true);
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = distribute_degensui(arg1, arg5, arg6, v3);
            let v6 = HarvestedDegenSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg3.id),
                dsui_for_hive     : v4,
                dsui_for_treasury : v5,
                fee_balance_sold  : v1,
            };
            0x2::event::emit<HarvestedDegenSui<T0>>(v6);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun harvest_dsui_for_collected_fee_y<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &PoolRegistry, arg3: &mut LiquidityPool<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI, T0, T1>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg2.fee_claim_cap, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            let (v2, v3) = internal_swap<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI, T0, T1>(arg0, arg3, 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(), 1, v0, 0, true);
            0x2::balance::destroy_zero<T0>(v3);
            let (v4, v5) = distribute_degensui(arg1, arg5, arg6, v2);
            let v6 = HarvestedDegenSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg3.id),
                dsui_for_hive     : v4,
                dsui_for_treasury : v5,
                fee_balance_sold  : v1,
            };
            0x2::event::emit<HarvestedDegenSui<T0>>(v6);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun harvest_sui_for_collected_fee_x<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg7: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg8: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            let (v2, v3) = internal_swap<T0, 0x2::sui::SUI, T1>(arg0, arg5, v0, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
            0x2::balance::destroy_zero<T0>(v2);
            let (_, v5, v6) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg7, arg8, v3, arg9);
            let v7 = HarvestedDegenSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                dsui_for_hive     : v5,
                dsui_for_treasury : v6,
                fee_balance_sold  : v1,
            };
            0x2::event::emit<HarvestedDegenSui<T0>>(v7);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun harvest_sui_for_collected_fee_y<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg7: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg8: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            let (v2, v3) = internal_swap<0x2::sui::SUI, T0, T1>(arg0, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, v0, 0, true);
            0x2::balance::destroy_zero<T0>(v3);
            let (_, v5, v6) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg7, arg8, v2, arg9);
            let v7 = HarvestedDegenSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                dsui_for_hive     : v5,
                dsui_for_treasury : v6,
                fee_balance_sold  : v1,
            };
            0x2::event::emit<HarvestedDegenSui<T0>>(v7);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun harvest_sui_one_hop_via_x_y_sui_x<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<T0, T1, T2>, arg6: &mut LiquidityPool<0x2::sui::SUI, T0, T3>, arg7: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T1>, arg8: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T1>(&arg3.fee_claim_cap, arg7);
        if (0x2::balance::value<T1>(&v0) > 0) {
            let (v1, v2) = internal_swap<T0, T1, T2>(arg0, arg5, 0x2::balance::zero<T0>(), 1, v0, 0, false);
            0x2::balance::destroy_zero<T1>(v2);
            let (v3, v4) = internal_swap<0x2::sui::SUI, T0, T3>(arg0, arg6, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, false);
            let (_, _, _) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg8, arg9, v3, arg10);
            0x2::balance::destroy_zero<T0>(v4);
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
    }

    public entry fun harvest_sui_one_hop_via_x_y_sui_y<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<T0, T1, T2>, arg6: &mut LiquidityPool<0x2::sui::SUI, T1, T3>, arg7: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg8: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg7);
        if (0x2::balance::value<T0>(&v0) > 0) {
            let (v1, v2) = internal_swap<T0, T1, T2>(arg0, arg5, v0, 0, 0x2::balance::zero<T1>(), 1, true);
            0x2::balance::destroy_zero<T0>(v1);
            let (v3, v4) = internal_swap<0x2::sui::SUI, T1, T3>(arg0, arg6, 0x2::balance::zero<0x2::sui::SUI>(), 1, v2, 0, false);
            let (_, _, _) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg8, arg9, v3, arg10);
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun harvest_sui_one_hop_via_x_y_x_sui<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<T0, T1, T2>, arg6: &mut LiquidityPool<T0, 0x2::sui::SUI, T3>, arg7: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T1>, arg8: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T1>(&arg3.fee_claim_cap, arg7);
        if (0x2::balance::value<T1>(&v0) > 0) {
            let (v1, v2) = internal_swap<T0, T1, T2>(arg0, arg5, 0x2::balance::zero<T0>(), 1, v0, 0, false);
            0x2::balance::destroy_zero<T1>(v2);
            let (v3, v4) = internal_swap<T0, 0x2::sui::SUI, T3>(arg0, arg6, v1, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
            let (_, _, _) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg8, arg9, v4, arg10);
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
    }

    public entry fun harvest_sui_one_hop_via_x_y_y_sui<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &PoolRegistry, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut LiquidityPool<T0, T1, T2>, arg6: &mut LiquidityPool<T1, 0x2::sui::SUI, T3>, arg7: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<T0>, arg8: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg7);
        if (0x2::balance::value<T0>(&v0) > 0) {
            let (v1, v2) = internal_swap<T0, T1, T2>(arg0, arg5, v0, 0, 0x2::balance::zero<T1>(), 1, true);
            0x2::balance::destroy_zero<T0>(v1);
            let (v3, v4) = internal_swap<T1, 0x2::sui::SUI, T3>(arg0, arg6, v2, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
            let (_, _, _) = stake_and_distribute_harvested_degensui(arg1, arg4, arg2, arg8, arg9, v4, arg10);
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    fun imbalanced_exit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : (u64, vector<u64>) {
        let (v0, v1) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v2 = v1;
        let (v3, v4) = if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            let (v5, v6) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::imbalanced_liquidity_withdraw(v0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(arg3), v2), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v6;
            (v3, v5)
        } else {
            let (v7, v8) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::imbalanced_liquidity_withdraw(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(arg3), v2), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v8;
            (v3, v7)
        };
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 0) / *0x1::vector::borrow<u256>(&v2, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 1) / *0x1::vector::borrow<u256>(&v2, 1)) as u64));
        ((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256(v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64), v9)
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

    public entry fun initialize_pool_registry(arg0: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::TwoAmmFeeClaimCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                    : 0x2::object::new(arg1),
            kraft_fee             : 0,
            krafted_pools_list    : 0x2::linked_table::new<PoolRegistryItem, 0x2::object::ID>(arg1),
            fee_claim_cap         : arg0,
            sui_hive_pool_addr    : 0x1::option::none<address>(),
            sui_for_hive_pool_pct : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::init_hive_pol_pct(),
            sui_bee_pool_addr     : 0x1::option::none<address>(),
            sui_for_bee_pool_pct  : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::init_bee_pol_pct(),
            third_pool_addr       : 0x1::option::none<address>(),
            public_kraft_enabled  : false,
            module_version        : 0,
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
        let v3 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v4 = arg1.fee_info.total_fee_bps;
        let v5 = arg1.fee_info.hive_fee_percent;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v6, v7) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v8 = v7;
        let v9 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v2 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128)));
        let (v10, v11) = if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            let (v12, v13) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::add_liquidity_computation(arg0, 0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(v3, v8), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v9);
            let v10 = v13;
            let v11 = v12;
            let (v14, v15, v16, v17) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v18, v19, v20, v21) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v22 = InternalPricesUpdated<T0, T1, T2>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v14,
                oracle_prices         : v15,
                last_prices           : v16,
                last_prices_timestamp : v17,
                virtual_price         : v19,
                xcp_profit            : v20,
                not_adjusted          : v21,
                _D                    : v18,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v22);
            (v10, v11)
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            0x1::debug::print<u256>(&v9);
            0x1::debug::print<u256>(&v9);
            0x1::debug::print<u256>(&v9);
            let (v23, v24) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::add_liquidity_computation(v6, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(v3, v8), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, v9);
            let v10 = v24;
            let v11 = v23;
            0x1::debug::print<u256>(&v11);
            (v10, v11)
        } else {
            let (v25, v26) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::add_liquidity_computation(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(v3, v8), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, v9);
            let v10 = v26;
            let v11 = v25;
            (v10, v11)
        };
        let v27 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256(v11, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64);
        let v28 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v28, ((*0x1::vector::borrow<u256>(&v10, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v28, ((*0x1::vector::borrow<u256>(&v10, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
        assert!(v27 > 0, 5007);
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, arg3);
        let v29 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v28, 0));
        let v30 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v28, 1));
        let v31 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v32 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v28, 0) as u128), (v5 as u128), (v31 as u128)) as u64);
        let v33 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v28, 1) as u128), (v5 as u128), (v31 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v29, v32));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v30, v33));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v29);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v30);
        let v34 = LiquidityAddedToPool<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : v0,
            coin_y_amount : v1,
            lp_minted     : v27,
            total_x_fee   : *0x1::vector::borrow<u64>(&v28, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v28, 1),
            x_hive_fee    : v32,
            y_hive_fee    : v33,
        };
        0x2::event::emit<LiquidityAddedToPool<T0, T1, T2>>(v34);
        v27
    }

    fun internal_register_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: u8, arg6: u8, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg2.module_version == 0, 5036);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::collect_fee_for_coin<0x2::sui::SUI>(arg4, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, arg2.kraft_fee));
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::assert_valid_curve<T2>();
        let v0 = 0x2::object::new(arg10);
        registry_add<T0, T1, T2>(arg2, arg1, arg5, arg6, 0x2::object::uid_to_inner(&v0));
        let (v1, v2) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::get_fee_info<T2>(arg1);
        let v3 = NewPoolCreated<T0, T1, T2>{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewPoolCreated<T0, T1, T2>>(v3);
        let v4 = LP<T0, T1, T2>{dummy_field: false};
        let v5 = PoolFeeInfo{
            total_fee_bps    : v1,
            hive_fee_percent : v2,
        };
        let v6 = LiquidityPool<T0, T1, T2>{
            id                 : v0,
            coin_x_reserve     : 0x2::balance::zero<T0>(),
            coin_x_decimals    : arg5,
            coin_y_reserve     : 0x2::balance::zero<T1>(),
            coin_y_decimals    : arg6,
            lp_supply          : 0x2::balance::create_supply<LP<T0, T1, T2>>(v4),
            total_lp_krafted   : 0,
            curved_config      : 0x1::option::none<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(),
            stable_config      : 0x1::option::none<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(),
            weighted_config    : 0x1::option::none<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(),
            hive_x             : 0x2::balance::zero<T0>(),
            hive_y             : 0x2::balance::zero<T1>(),
            fee_info           : v5,
            is_locked          : false,
            cumulative_x_price : 0,
            cumulative_y_price : 0,
            last_timestamp     : 0x2::clock::timestamp_ms(arg0),
            pool_hive_addr     : 0x1::option::none<address>(),
            is_swap_enabled    : true,
            module_version     : 0,
        };
        let v7 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v7, 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::computeScalingFactor(arg5));
        0x1::vector::push_back<u256>(&mut v7, 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::computeScalingFactor(arg6));
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            assert!(0x1::option::is_some<vector<u256>>(&arg8), 5003);
            v6.curved_config = 0x1::option::some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::initialize_curved_config(arg0, arg7, 0x1::option::extract<vector<u256>>(&mut arg8), v7, (2 as u128), arg10));
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            v6.stable_config = 0x1::option::some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::StablePoolConfig>(0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::initialize_stable_config(arg0, arg7, v7, arg10));
        } else {
            assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_weighted<T2>(), 5024);
            assert!(0x1::option::is_some<vector<u64>>(&arg9), 5004);
            v6.weighted_config = 0x1::option::some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::initialize_weighted_config(arg7, 0x1::option::extract<vector<u64>>(&mut arg9), v7, 2, arg10));
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1, T2>>(v6);
        if (!0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::is_fee_collector_present<T0>(arg1)) {
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::create_fee_collector<T0>(arg1, arg10);
        };
        if (!0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::is_fee_collector_present<T1>(arg1)) {
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::create_fee_collector<T1>(arg1, arg10);
        };
        (0x2::object::uid_to_address(&v0), arg3)
    }

    fun internal_remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64) {
        assert!(!arg1.is_locked, 5009);
        let v0 = (arg1.total_lp_krafted as u128);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = arg1.fee_info.total_fee_bps;
        let v4 = arg1.fee_info.hive_fee_percent;
        let v5 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v6 = arg2;
        let v7 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::create_zero_vector(2);
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        if (arg3 == 0 && arg4 == 0) {
            *0x1::vector::borrow_mut<u64>(&mut v5, 0) = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), (v1 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v5, 1) = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), (v2 as u256), (v0 as u256)) as u64);
            if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
                0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::reduce_d(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v0 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))));
            };
        } else {
            if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
                abort 5011
            };
            let (v8, v9) = imbalanced_exit<T0, T1, T2>(arg0, arg1, (v0 as u64), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()), v5, v3);
            v7 = v9;
            v6 = v8;
        };
        assert!(v6 > 0, 5010);
        let v10 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v5, 0));
        let v11 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v5, 1));
        let v12 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision();
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_weighted<T2>()) {
            let v13 = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_exit_fee(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config));
            *0x1::vector::borrow_mut<u64>(&mut v7, 0) = *0x1::vector::borrow<u64>(&v7, 0) + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(*0x1::vector::borrow<u64>(&v5, 0), v13, v12);
            *0x1::vector::borrow_mut<u64>(&mut v7, 1) = *0x1::vector::borrow<u64>(&v7, 1) + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(*0x1::vector::borrow<u64>(&v5, 1), v13, v12);
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
        let v16 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v17 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 0) as u128), (v4 as u128), (v16 as u128)) as u64);
        let v18 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 1) as u128), (v4 as u128), (v16 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v14, v17));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v15, v18));
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
        let (v0, v1, v2) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::get_asset_index_and_amount(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::create_vector(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg4)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v2, 5012);
        let (v3, v4, v5) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::get_asset_index_and_amount(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v5, 5013);
        assert!(v1 != v4, 5014);
        let v6 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v7 = (arg1.total_lp_krafted as u128);
        let v8 = arg1.fee_info.total_fee_bps;
        let v9 = arg1.fee_info.hive_fee_percent;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v13, v14) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v15 = v14;
        let v16 = *0x1::vector::borrow<u256>(&v15, v4);
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            if (arg6) {
                v10 = v0;
                let (v17, v18) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::compute_ask_amount(arg0, 0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v0 as u256) * *0x1::vector::borrow<u256>(&v15, v1), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v15), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v7 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))));
                v11 = ((v17 / v16) as u64);
                v12 = ((v18 / v16) as u64);
            } else {
                let (v19, v20) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::compute_offer_amount(arg0, 0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v3 as u256) * v16, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v15), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v7 as u256), 1000000000000000000, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_u256(10, (6 as u128))));
                v10 = ((v19 / *0x1::vector::borrow<u256>(&v15, v1)) as u64);
                let v21 = ((v20 / v16) as u64);
                v12 = v21;
                v11 = v3 + v21;
            };
            let (v22, v23, v24, v25) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_prices_info(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v26, v27, v28, v29) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config));
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
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            if (arg6) {
                v10 = v0;
                let v31 = ((0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::compute_ask_amount(v13, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v15, v1), v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v15)) / v16) as u64);
                v11 = v31;
                v12 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((v8 as u128), (v31 as u128), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v32, v33) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::compute_offer_amount(v13, (v3 as u256) * v16, v4, v1, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v15), v8);
                v10 = ((v32 / *0x1::vector::borrow<u256>(&v15, v1)) as u64);
                let v34 = ((v33 / v16) as u64);
                v12 = v34;
                v11 = v3 + v34;
            };
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_weighted<T2>()) {
            let (v35, v36) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config), v1, true);
            let (v37, v38) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config), v4, true);
            if (arg6) {
                v10 = v0;
                let v39 = ((0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::compute_ask_amount((v0 as u256) * v36, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v36, (v35 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v38, (v37 as u256)) / v38) as u64);
                v11 = v39;
                v12 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((v8 as u128), (v39 as u128), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v40, v41) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::compute_offer_amount((v3 as u256) * v38, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v38, (v37 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v36, (v35 as u256), v8);
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
            let (v51, v52) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::process_coin_balances_processing_for_swap<T0, T1>(&mut arg1.coin_x_reserve, &mut arg2, v10, &mut arg1.coin_y_reserve, &mut arg4, v11, v12, v9);
            v50 = v52;
            0x2::balance::join<T1>(&mut arg1.hive_y, v51);
        } else if (v1 == 1 && v4 == 0) {
            v46 = v10;
            v44 = v11 - v12;
            v45 = v12;
            let (v53, v54) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::process_coin_balances_processing_for_swap<T1, T0>(&mut arg1.coin_y_reserve, &mut arg4, v10, &mut arg1.coin_x_reserve, &mut arg2, v11, v12, v9);
            v49 = v54;
            0x2::balance::join<T0>(&mut arg1.hive_x, v53);
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

    public fun lock_in_sui_bee_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut PoolRegistry, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = get_decimal_for_coin<T0>(arg2);
        let (v1, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg5, arg6, v0, 0x2::coin::get_decimals<T1>(arg4), arg7, arg8, arg9, arg10);
        arg3.sui_bee_pool_addr = 0x1::option::some<address>(v1);
        let v3 = SUI_BEE_Pool_Krafted{sui_bee_pool_addr: v1};
        0x2::event::emit<SUI_BEE_Pool_Krafted>(v3);
        (v1, v2)
    }

    public fun lock_in_sui_hive_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg2: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut PoolRegistry, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg3.module_version == 0, 5036);
        assert!(0x1::type_name::get<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>() == 0x1::type_name::get<T1>(), 5001);
        assert!(0x1::option::is_none<address>(&arg3.sui_hive_pool_addr), 5030);
        let v0 = get_decimal_for_coin<T0>(arg2);
        let (v1, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg5, arg6, v0, 0x2::coin::get_decimals<T1>(arg4), arg7, arg8, arg9, arg10);
        arg3.sui_hive_pool_addr = 0x1::option::some<address>(v1);
        let v3 = SUI_HIVE_Pool_Krafted{sui_hive_pool_addr: v1};
        0x2::event::emit<SUI_HIVE_Pool_Krafted>(v3);
        (v1, v2)
    }

    public fun pay_flashloan<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: Flashloan<T0, T1, T2>) {
        assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg0.module_version == 0, 5036);
        let Flashloan {
            x_loan : v0,
            y_loan : v1,
        } = arg3;
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 >= v0 && v3 >= v1, 5020);
        let v4 = arg0.fee_info.total_fee_bps;
        let v5 = arg0.fee_info.hive_fee_percent;
        let v6 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision();
        let v7 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v2 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v8 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v3 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v9 = 0x2::balance::split<T0>(&mut arg1, v7);
        let v10 = 0x2::balance::split<T1>(&mut arg2, v8);
        let v11 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v12 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(v7, v5, v11);
        let v13 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(v8, v5, v11);
        0x2::balance::join<T0>(&mut arg0.hive_x, 0x2::balance::split<T0>(&mut v9, v12));
        0x2::balance::join<T1>(&mut arg0.hive_y, 0x2::balance::split<T1>(&mut v10, v13));
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
        let (v0, v1, v2) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::get_asset_index_and_amount(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::create_vector(0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v2) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        let (v3, v4, v5) = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::get_asset_index_and_amount(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        if (v1 == v4) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        let v6 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        if (v3 > *0x1::vector::borrow<u64>(&v6, v4)) {
            return (0, 0, 0, 0, 0, 0, 5028)
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let (v10, v11) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v12 = v11;
        let v13 = *0x1::vector::borrow<u256>(&v12, v4);
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            if (arg6) {
                v7 = v0;
                let (v14, v15) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::query_ask_amount(arg0, 0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v12), (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), v1, v4);
                v8 = ((v14 / v13) as u64);
                v9 = ((v15 / v13) as u64);
            } else {
                let (v16, v17) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::query_offer_amount(arg0, 0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg1.curved_config), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v12), (v3 as u256) * v13, v1, v4);
                v7 = ((v16 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v18 = ((v17 / v13) as u64);
                v9 = v18;
                v8 = v3 + v18;
            };
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_stable<T2>()) {
            if (arg6) {
                v7 = v0;
                let v19 = ((0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::compute_ask_amount(v10, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v12)) / v13) as u64);
                v8 = v19;
                v9 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v19 as u128), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v20, v21) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::stable_math::compute_offer_amount(v10, (v3 as u256) * v13, v4, v1, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::multiply_vectors_u256(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::vector_u64_to_u256(v6), v12), arg1.fee_info.total_fee_bps);
                v7 = ((v20 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v22 = ((v21 / v13) as u64);
                v9 = v22;
                v8 = v3 + v22;
            };
        } else if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_weighted<T2>()) {
            let v23 = 0x1::option::borrow<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::WeightedConfig>(&arg1.weighted_config);
            let (v24, v25) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_weight_and_sf_at_index(v23, v1, true);
            let (v26, v27) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::get_weight_and_sf_at_index(v23, v4, true);
            if (arg6) {
                v7 = v0;
                let v28 = ((0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::compute_ask_amount((v0 as u256) * v25, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v25, (v24 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v27, (v26 as u256)) / v27) as u64);
                v8 = v28;
                v9 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v28 as u128), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::amm_fee_precision() as u128)) as u64);
            } else {
                let (v29, v30) = 0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::weighted_math::compute_offer_amount((v3 as u256) * v27, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v27, (v26 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v25, (v24 as u256), arg1.fee_info.total_fee_bps);
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

    public fun register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2.public_kraft_enabled, 5032);
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::get_decimals<T0>(arg5), 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v1
    }

    public fun register_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: vector<u64>, arg6: 0x1::option::Option<vector<u256>>, arg7: 0x1::option::Option<vector<u64>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg1);
        let v1 = get_decimal_for_coin<T1>(arg1);
        let (_, v3) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, v1, arg5, arg6, arg7, arg8);
        v3
    }

    public fun register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T1>(arg1);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::get_decimals<T0>(arg5), v0, arg6, arg7, arg8, arg9);
        v2
    }

    public fun register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut PoolRegistry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg1);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, 0x2::coin::get_decimals<T1>(arg5), arg6, arg7, arg8, arg9);
        v2
    }

    fun registry_add<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: u8, arg3: u8, arg4: 0x2::object::ID) {
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::curves::is_curved<T2>()) {
            assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::valid_curved_coins_2_pool<T0, T1>(arg1), 5005);
        } else {
            assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::is_sorted<T0, T1>(), 5006);
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
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5034);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5034);
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

    public(friend) fun remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg1.module_version == 0, 5036);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5033);
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

    public fun set_pool_hive_addr<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: address) {
        assert!(arg0.module_version == 0, 5036);
        assert!(!0x1::option::is_some<address>(&arg0.pool_hive_addr), 5027);
        arg0.pool_hive_addr = 0x1::option::some<address>(arg2);
    }

    public fun stake_and_distribute_harvested_degensui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg2: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg5) > 0) {
            let v3 = 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg0, arg1, arg5, 0x1::option::none<address>(), arg6);
            let (v4, v5) = distribute_degensui(arg2, arg3, arg4, v3);
            (0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v3), v4, v5)
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg5);
            (0, 0, 0)
        }
    }

    public entry fun stake_and_harvest_collected_sui_fee(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &PoolRegistry, arg3: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::FeeCollector<0x2::sui::SUI>, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let (_, _, _) = stake_and_distribute_harvested_degensui(arg0, arg3, arg1, arg5, arg6, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::extract_fee_for_coin_2amm<0x2::sui::SUI>(&arg2.fee_claim_cap, arg4), arg7);
    }

    public(friend) fun swap_bee_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>(), 5033);
        internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun switch_swap_switch<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 5036);
        arg0.is_swap_enabled = arg2;
    }

    fun update_cumulative_prices<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>) {
        let v0 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::twap_precision() as u8);
        let v1 = 0x2::clock::timestamp_ms(arg0) - arg1.last_timestamp;
        let v2 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v3 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        if (v1 > 0 && v2 != 0 && v3 != 0) {
            arg1.cumulative_x_price = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::overflow_add_u256(arg1.cumulative_x_price, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v3 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_10(v0) as u256), (v2 as u256)) * (v1 as u256));
            arg1.cumulative_y_price = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::overflow_add_u256(arg1.cumulative_y_price, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v2 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow_10(v0) as u256), (v3 as u256)) * (v1 as u256));
            arg1.last_timestamp = 0x2::clock::timestamp_ms(arg0);
        };
        let v4 = CumPriceUpdatedEvent<T0, T1, T2>{
            id                 : 0x2::object::uid_to_inner(&arg1.id),
            cumulative_x_price : arg1.cumulative_x_price,
            cumulative_y_price : arg1.cumulative_y_price,
            timestamp          : arg1.last_timestamp,
        };
        0x2::event::emit<CumPriceUpdatedEvent<T0, T1, T2>>(v4);
    }

    public entry fun update_curved_A_and_gamma<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::update_A_and_gamma(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5);
        let v0 = CurvedConfigUpdatedAmp<T0, T1, T2>{
            id                  : 0x2::object::uid_to_inner(&arg0.id),
            init_A_gamma_time   : arg2,
            next_amp            : arg3,
            next_gamma          : arg4,
            future_A_gamma_time : arg5,
        };
        0x2::event::emit<CurvedConfigUpdatedAmp<T0, T1, T2>>(v0);
    }

    public fun update_curved_config_fee_params<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(0x1::option::is_some<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::update_config_fee_params(0x1::option::borrow_mut<0x58e5326222054b56d735184fe84442b5c0f27fa65cb25ab6f49e3dd98091d543::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5, arg6, arg7);
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

    public fun update_fee_for_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::PoolHiveCapability, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        assert!(arg2 >= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_swap_fee() && arg2 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_swap_fee(), 5000);
        assert!(arg3 >= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_hive_fee() && arg3 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_hive_fee(), 5026);
        arg0.fee_info.total_fee_bps = arg2;
        arg0.fee_info.hive_fee_percent = arg3;
        let v0 = PoolFeeUpdated{
            id               : 0x2::object::uid_to_inner(&arg0.id),
            total_fee_bps    : arg2,
            hive_fee_percent : arg3,
        };
        0x2::event::emit<PoolFeeUpdated>(v0);
    }

    public fun update_kraft_fee(arg0: &mut PoolRegistry, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg2: u64) {
        assert!(arg0.module_version == 0, 5036);
        arg0.kraft_fee = arg2;
    }

    public fun update_sui_pol_distribution(arg0: &mut PoolRegistry, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 5036);
        if (arg2 > 0) {
            arg0.sui_for_hive_pool_pct = arg2;
        };
        if (arg3 > 0) {
            arg0.sui_for_bee_pool_pct = arg3;
        };
        assert!(arg0.sui_for_hive_pool_pct + arg0.sui_for_bee_pool_pct <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision(), 5039);
        let v0 = SuiPolDistributionUpdated{
            sui_for_hive_pool_pct : arg0.sui_for_hive_pool_pct,
            sui_for_bee_pool_pct  : arg0.sui_for_bee_pool_pct,
        };
        0x2::event::emit<SuiPolDistributionUpdated>(v0);
    }

    public fun update_third_pool_for_pol<T0, T1>(arg0: &mut PoolRegistry, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg2: &mut LiquidityPool<0x2::sui::SUI, T0, T1>) {
        assert!(arg0.module_version == 0, 5036);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        arg0.third_pool_addr = 0x1::option::some<address>(v0);
        let v1 = SuiPolThirdPoolUpdated{third_pool_addr: v0};
        0x2::event::emit<SuiPolThirdPoolUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

