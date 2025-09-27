module 0xfaadf16158c8194de9a8eb306389bf3cd709f6bbfee1a8bef66892f36486f34e::two_pool {
    struct LP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct AmmAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        kraft_fee: u64,
        krafted_pools_list: 0x2::linked_table::LinkedTable<PoolRegistryItem, 0x2::object::ID>,
        fee_claim_cap: 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::TwoAmmAccess,
        sui_honey_pool_addr: address,
        enable_public_pools: bool,
        supported_tokens_list: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        dynamic_fee_configs: 0x2::linked_table::LinkedTable<u64, DynamicFeeConfig>,
        is_buyback_enabled: bool,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct PoolRegistryItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        curve: 0x1::type_name::TypeName,
    }

    struct DynamicFeeConfig has copy, drop, store {
        start_range: u64,
        end_range: u64,
        creator_fee_bps: u64,
        amm_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct CollectedFees<phantom T0, phantom T1> has store {
        sui_fees: 0x2::balance::Balance<T0>,
        ggsui_fees: 0x2::balance::Balance<T1>,
    }

    struct LiquidityPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_x_decimals: u8,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        coin_y_decimals: u8,
        lp_supply: 0x2::balance::Supply<LP<T0, T1, T2>>,
        total_lp_krafted: u64,
        curved_config: 0x1::option::Option<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>,
        stable_config: 0x1::option::Option<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>,
        weighted_config: 0x1::option::Option<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>,
        collected_fee_x: 0x2::balance::Balance<T0>,
        collected_fee_y: 0x2::balance::Balance<T1>,
        fee_info: PoolFeeInfo,
        is_locked: bool,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        last_timestamp: u64,
        pool_hive_addr: 0x1::option::Option<address>,
        is_swap_enabled: bool,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct PoolFeeInfo has store {
        total_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct Flashloan<phantom T0, phantom T1, phantom T2> {
        x_loan: u64,
        y_loan: u64,
    }

    struct WeightedConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        new_weights: vector<u64>,
        new_exit_fee: u64,
    }

    struct NewPoolCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_id: 0x2::object::ID,
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

    struct CurvedConfigUpdatedAmp<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_A_gamma_time: u64,
        next_amp: u64,
        next_gamma: u256,
        future_A_gamma_time: u64,
    }

    struct StableConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_amp_time: u64,
        next_amp: u64,
        next_amp_time: u64,
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

    struct SuiPolDistributionUpdated has copy, drop {
        sui_for_hive_pool_pct: u64,
        sui_for_honey_pool_pct: u64,
    }

    struct SuiPolThirdPoolUpdated has copy, drop {
        third_pool_addr: address,
    }

    struct StableConfigUpdatedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        init_amp_time: u64,
        next_amp: u64,
        next_amp_time: u64,
    }

    struct WeightedConfigUpdatedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        new_weights: vector<u64>,
        new_exit_fee: u64,
    }

    struct CurvedConfigUpdatedAmpEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        init_A_gamma_time: u64,
        next_amp: u64,
        next_gamma: u256,
        future_A_gamma_time: u64,
    }

    struct CurvedConfigUpdatedParamsEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        new_mid_fee: u64,
        new_out_fee: u64,
        new_fee_gamma: u64,
        new_ma_half_time: u64,
        new_allowed_extra_profit: u64,
        new_adjustment_step: u64,
    }

    struct NewPoolCreatedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        id_identifier_str: 0x1::string::String,
    }

    struct LiquidityAddedToPoolEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_minted: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct LiquidityRemovedFromPoolEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
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

    struct TokensSwappedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        x_offer_amt: u64,
        y_offer_amt: u64,
        x_return_amt: u64,
        y_return_amt: u64,
    }

    struct SwapFeeChargedEvent has copy, drop {
        id: 0x2::object::ID,
        is_supported: bool,
        supported_token_type: 0x1::ascii::String,
        fee_token_type: 0x1::ascii::String,
        creator_fee_amt: u64,
        amm_fee_amt: u64,
        protocol_fee_amt: u64,
        x_fee_curved_pool: u64,
        y_fee_curved_pool: u64,
    }

    struct FlashLoanExecutedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        x_loan: u64,
        y_loan: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct CumPriceUpdatedEventV2 has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        timestamp: u64,
    }

    struct InternalPricesUpdatedEvent has copy, drop {
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        type_curve: 0x1::type_name::TypeName,
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

    struct XFeeUsedForBuybacks has copy, drop {
        pool_addr: address,
        x_type: 0x1::ascii::String,
        x_for_honey_buyback: u64,
        honey_bought_amt: u64,
        honey_as_fee: u64,
        honey_for_treasury: u64,
        honey_as_buyback: u64,
    }

    struct SuiFeeUsedForBuybacks has copy, drop {
        pool_addr: address,
        sui_for_treasury: u64,
        sui_for_honey_buyback: u64,
        honey_bought_amt: u64,
    }

    struct SuiForYieldFarm has copy, drop {
        sui_for_treasury: u64,
        sui_for_honey_buyback: u64,
        honey_bought_amt: u64,
    }

    struct PoolFeeUpdated has copy, drop {
        id: 0x2::object::ID,
        total_fee_bps: u64,
        protocol_fee_pct: u64,
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

    struct DynamicFeeConfigUpdated has copy, drop {
        index: u64,
        start_range: u64,
        end_range: u64,
        creator_fee_bps: u64,
        amm_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct DynamicFeeCharged has copy, drop {
        pool_id: 0x2::object::ID,
        supported_token_type: 0x1::ascii::String,
        fee_token_type: 0x1::ascii::String,
        creator_fee_amount: u64,
        protocol_fee_amount: u64,
        total_fee_amount: u64,
    }

    struct CreatorFeesCollected has copy, drop {
        token_type: 0x1::ascii::String,
        sui_amount: u64,
        ggsui_amount: u64,
        collector: address,
    }

    struct PoolFeeInfoUpdated has copy, drop {
        total_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct SwapResultInfo has copy, drop {
        x_ret_offer_amt: u64,
        x_return_amt: u64,
        x_total_fee: u64,
        y_ret_offer_amt: u64,
        y_return_amt: u64,
        y_total_fee: u64,
        creator_fee_amt: u64,
        amm_fee_amt: u64,
        protocol_fee_amt: u64,
        error: u64,
    }

    struct PoolsInfo has drop, store {
        x_identifiers: vector<0x1::string::String>,
        y_identifiers: vector<0x1::string::String>,
        curve_identifiers: vector<0x1::string::String>,
        pools_list: vector<address>,
        total_pools: u64,
    }

    struct PoolReservesInfo has drop, store {
        lp_total_minted: u64,
        lp_in_circulation: u64,
        lp_burnt: u64,
    }

    struct PoolStableConfigInfo has drop, store {
        init_amp_time: u64,
        init_amp: u64,
        next_amp_time: u64,
        next_amp: u64,
        scaling_factor: vector<u256>,
    }

    struct PoolWeightedConfigInfo has drop, store {
        weights: vector<u64>,
        scaling_factor: vector<u256>,
        total_weight: u64,
        exit_fee: u64,
    }

    struct PoolCurvedConfigInfo has drop, store {
        init_A_gamma_time: u64,
        future_A_gamma_time: u64,
        init_amp: u64,
        next_amp: u64,
        init_gamma: u256,
        next_gamma: u256,
    }

    struct PoolCurvedConfigFeeInfo has drop, store {
        mid_fee: u64,
        out_fee: u64,
        fee_gamma: u64,
        ma_half_time: u256,
        allowed_extra_profit: u256,
        adjustment_step: u256,
    }

    struct PoolCurvedConfigPricesInfo has drop, store {
        price_scale: vector<u256>,
        oracle_prices: vector<u256>,
        last_prices: vector<u256>,
        last_prices_timestamp: u64,
    }

    struct PoolCurvedConfigXcpInfo has drop, store {
        invariant: u256,
        virtual_price: u256,
        xcp_profit: u256,
        not_adjusted: bool,
    }

    struct CreatorFeeConfigInfo has drop, store {
        creator_fee_bps: u64,
        start_range: u64,
        end_range: u64,
    }

    struct CreatorFeeConfigsInfo has drop, store {
        creator_fee_bps: vector<u64>,
        amm_fee_bps: vector<u64>,
        protocol_fee_pct: vector<u64>,
        start_range: vector<u64>,
        end_range: vector<u64>,
    }

    public fun swap<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg2.is_locked, 5009);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg1.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 5047);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg1.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), 5047);
        let (v0, v1, _, _) = internal_swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        (v0, v1)
    }

    public fun set_token_taxes<T0>(arg0: &mut PoolRegistry, arg1: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::TokenRules, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &0x2::token::TokenPolicyCap<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::set_token_taxes<T0>(&arg0.fee_claim_cap, arg1, arg2, arg3, arg4, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::token_rules::new_honey_tax_config(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14), arg13, arg14);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), true);
    }

    public fun update_initial_prices<T0, T1, T2>(arg0: &AmmAdminCap, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: vector<u256>) {
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::update_initial_prices(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), arg2);
    }

    public fun update_stable_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.module_version == 2, 5036);
        assert!(0x1::option::is_some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(&arg0.stable_config), 5025);
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::update_stable_config(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(&mut arg0.stable_config), arg3, arg2, arg4);
        let v0 = StableConfigUpdatedEvent{
            type_x        : 0x1::type_name::with_defining_ids<T0>(),
            type_y        : 0x1::type_name::with_defining_ids<T1>(),
            type_curve    : 0x1::type_name::with_defining_ids<T2>(),
            id            : 0x2::object::uid_to_inner(&arg0.id),
            init_amp_time : arg3,
            next_amp      : arg2,
            next_amp_time : arg4,
        };
        0x2::event::emit<StableConfigUpdatedEvent>(v0);
    }

    public fun update_weighted_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: vector<u64>, arg3: u64) {
        assert!(arg0.module_version == 2, 5036);
        assert!(0x1::option::is_some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg0.weighted_config), 5025);
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::update_weighted_config(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&mut arg0.weighted_config), arg2, arg3);
        let v0 = WeightedConfigUpdatedEvent{
            type_x       : 0x1::type_name::with_defining_ids<T0>(),
            type_y       : 0x1::type_name::with_defining_ids<T1>(),
            type_curve   : 0x1::type_name::with_defining_ids<T2>(),
            id           : 0x2::object::uid_to_inner(&arg0.id),
            new_weights  : arg2,
            new_exit_fee : arg3,
        };
        0x2::event::emit<WeightedConfigUpdatedEvent>(v0);
    }

    public fun add_fees_obj_to_pool<T0, T1, T2, T3, T4>(arg0: &PoolRegistry, arg1: &mut LiquidityPool<T0, T1, T2>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, v0)) {
            if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0)) {
                let v2 = CollectedFees<T3, T4>{
                    sui_fees   : 0x2::balance::zero<T3>(),
                    ggsui_fees : 0x2::balance::zero<T4>(),
                };
                0x2::dynamic_field::add<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg1.id, v0, v2);
            };
        };
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, v1)) {
            if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v1)) {
                let v3 = CollectedFees<T3, T4>{
                    sui_fees   : 0x2::balance::zero<T3>(),
                    ggsui_fees : 0x2::balance::zero<T4>(),
                };
                0x2::dynamic_field::add<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg1.id, v1, v3);
            };
        };
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64) : 0x2::balance::Balance<LP<T0, T1, T2>> {
        assert!(arg1.module_version == 2, 5036);
        let v0 = internal_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert!(v0 >= arg4, 5008);
        arg1.total_lp_krafted = arg1.total_lp_krafted + v0;
        0x2::balance::increase_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, v0)
    }

    public fun claim_fees_honey_x_pool<T0, T1, T2, T3, T4>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>) {
        let v0 = 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg3.collected_fee_y);
        let (v2, v3, _, _) = internal_swap<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0, T1, T3, T4>(arg1, arg0, arg3, 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::join<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut v0, v2);
        0x2::balance::join<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut v0, 0x2::balance::withdraw_all<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg3.collected_fee_x));
        let (v6, v7, _, _) = internal_swap<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2, T3, T4>(arg1, arg0, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 1, v0, 0, true);
        0x2::balance::destroy_zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(v7);
        convert_sui_fees_to_honey<T2, T3, T4>(arg0, arg1, arg2, v6, 0x2::object::uid_to_address(&arg3.id), arg4);
    }

    public fun claim_fees_one_hop_via_sui_x_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: &mut LiquidityPool<0x2::sui::SUI, T0, T3>, arg4: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T4>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg2.collected_fee_y);
        let (v2, v3, _, _) = internal_swap<T0, T1, T2, T5, T6>(arg1, arg0, arg2, 0x2::balance::zero<T0>(), 1, v1, 0, true);
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut arg2.collected_fee_x));
        let (v7, v8, _, _) = internal_swap<0x2::sui::SUI, T0, T3, T5, T6>(arg1, arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, v6, 0, true);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v7);
        convert_sui_fees_to_honey<T4, T5, T6>(arg0, arg1, arg4, v0, 0x2::object::uid_to_address(&arg2.id), arg5);
    }

    public fun claim_fees_one_hop_via_sui_y_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: &mut LiquidityPool<0x2::sui::SUI, T1, T3>, arg4: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T4>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.collected_fee_x);
        let (v2, v3, _, _) = internal_swap<T0, T1, T2, T5, T6>(arg1, arg0, arg2, v1, 0, 0x2::balance::zero<T1>(), 1, true);
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(&mut arg2.collected_fee_y));
        let (v7, v8, _, _) = internal_swap<0x2::sui::SUI, T1, T3, T5, T6>(arg1, arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, v6, 0, true);
        0x2::balance::destroy_zero<T1>(v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v7);
        convert_sui_fees_to_honey<T4, T5, T6>(arg0, arg1, arg4, v0, 0x2::object::uid_to_address(&arg2.id), arg5);
    }

    public fun claim_fees_one_hop_via_x_sui_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: &mut LiquidityPool<T0, 0x2::sui::SUI, T3>, arg4: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T4>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg2.collected_fee_y);
        let (v2, v3, _, _) = internal_swap<T0, T1, T2, T5, T6>(arg1, arg0, arg2, 0x2::balance::zero<T0>(), 1, v1, 0, true);
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut arg2.collected_fee_x));
        let (v7, v8, _, _) = internal_swap<T0, 0x2::sui::SUI, T3, T5, T6>(arg1, arg0, arg3, v6, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v8);
        convert_sui_fees_to_honey<T4, T5, T6>(arg0, arg1, arg4, v0, 0x2::object::uid_to_address(&arg2.id), arg5);
    }

    public fun claim_fees_one_hop_via_y_sui_pool<T0, T1, T2, T3, T4, T5, T6>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: &mut LiquidityPool<T1, 0x2::sui::SUI, T3>, arg4: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg5: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T4>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg2.collected_fee_x);
        let (v2, v3, _, _) = internal_swap<T0, T1, T2, T5, T6>(arg1, arg0, arg2, v1, 0, 0x2::balance::zero<T1>(), 1, true);
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(&mut arg2.collected_fee_y));
        let (v7, v8, _, _) = internal_swap<T1, 0x2::sui::SUI, T3, T5, T6>(arg1, arg0, arg3, v6, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T1>(v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v8);
        convert_sui_fees_to_honey<T4, T5, T6>(arg0, arg1, arg4, v0, 0x2::object::uid_to_address(&arg2.id), arg5);
    }

    public fun claim_fees_sui_honey_pool<T0, T1, T2>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg3.collected_fee_y);
        let (v2, v3, _, _) = internal_swap<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0, T1, T2>(arg1, arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.collected_fee_x));
        let v6 = 0x2::object::uid_to_address(&arg3.id);
        convert_sui_fees_to_honey<T0, T1, T2>(arg0, arg1, arg2, v0, v6, arg3);
    }

    public fun claim_fees_sui_x_pool<T0, T1, T2, T3, T4>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg3.collected_fee_y);
        let (v2, v3, _, _) = internal_swap<0x2::sui::SUI, T0, T1, T3, T4>(arg1, arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, v1, 0, true);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.collected_fee_x));
        convert_sui_fees_to_honey<T2, T3, T4>(arg0, arg1, arg2, v0, 0x2::object::uid_to_address(&arg3.id), arg4);
    }

    public fun claim_fees_x_honey_pool<T0, T1, T2, T3, T4>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<T0, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>) {
        let v0 = 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg3.collected_fee_x);
        let (v2, v3, _, _) = internal_swap<T0, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T1, T3, T4>(arg1, arg0, arg3, v1, 0, 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(), 1, true);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut v0, v3);
        0x2::balance::join<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut v0, 0x2::balance::withdraw_all<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&mut arg3.collected_fee_y));
        let (v6, v7, _, _) = internal_swap<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2, T3, T4>(arg1, arg0, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 1, v0, 0, true);
        0x2::balance::destroy_zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(v7);
        convert_sui_fees_to_honey<T2, T3, T4>(arg0, arg1, arg2, v6, 0x2::object::uid_to_address(&arg3.id), arg4);
    }

    public fun claim_fees_x_sui_pool<T0, T1, T2, T3, T4>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg3.collected_fee_x);
        let (v2, v3, _, _) = internal_swap<T0, 0x2::sui::SUI, T1, T3, T4>(arg1, arg0, arg3, v1, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.collected_fee_y));
        convert_sui_fees_to_honey<T2, T3, T4>(arg0, arg1, arg2, v0, 0x2::object::uid_to_address(&arg3.id), arg4);
    }

    public fun collect_creator_fees_honey_pool<T0, T1, T2>(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::TreasuryClaimCap, arg1: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0>, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg1.module_version == 2, 5036);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0), 5048);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, CollectedFees<T1, T2>>(&mut arg1.id, v0);
        let v2 = CreatorFeesCollected{
            token_type   : v0,
            sui_amount   : 0x2::balance::value<T1>(&v1.sui_fees),
            ggsui_amount : 0x2::balance::value<T2>(&v1.ggsui_fees),
            collector    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreatorFeesCollected>(v2);
        (0x2::balance::withdraw_all<T1>(&mut v1.sui_fees), 0x2::balance::withdraw_all<T2>(&mut v1.ggsui_fees))
    }

    public fun collect_creator_fees_x_pool<T0, T1, T2, T3, T4>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T4>) {
        assert!(arg1.module_version == 2, 5036);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0), 5048);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg1.id, v0);
        let v2 = CreatorFeesCollected{
            token_type   : v0,
            sui_amount   : 0x2::balance::value<T3>(&v1.sui_fees),
            ggsui_amount : 0x2::balance::value<T4>(&v1.ggsui_fees),
            collector    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreatorFeesCollected>(v2);
        (0x2::balance::withdraw_all<T3>(&mut v1.sui_fees), 0x2::balance::withdraw_all<T4>(&mut v1.ggsui_fees))
    }

    public fun collect_creator_fees_y_pool<T0, T1, T2, T3, T4>(arg0: &0x2::token::TokenPolicyCap<T1>, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T4>) {
        assert!(arg1.module_version == 2, 5036);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0), 5048);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg1.id, v0);
        let v2 = CreatorFeesCollected{
            token_type   : v0,
            sui_amount   : 0x2::balance::value<T3>(&v1.sui_fees),
            ggsui_amount : 0x2::balance::value<T4>(&v1.ggsui_fees),
            collector    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreatorFeesCollected>(v2);
        (0x2::balance::withdraw_all<T3>(&mut v1.sui_fees), 0x2::balance::withdraw_all<T4>(&mut v1.ggsui_fees))
    }

    public fun compute_dynamic_fee<T0, T1, T2>(arg0: &PoolRegistry, arg1: &LiquidityPool<T0, T1, T2>) : (bool, 0x1::ascii::String, 0x1::ascii::String, u64, u64, u64, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>());
        let v4 = false;
        let v5 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>());
        let v6 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>());
        let v7 = 0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, v0);
        let v8 = 0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, v1);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = false;
        let v13 = 0;
        let v14 = if (v7) {
            if (!v8) {
                v1 == v2 || v1 == v3
            } else {
                false
            }
        } else {
            false
        };
        let v15 = if (v14) {
            true
        } else if (!v7) {
            if (v8) {
                v0 == v2 || v0 == v3
            } else {
                false
            }
        } else {
            false
        };
        if (v15) {
            let v16 = if (v7) {
                v1
            } else {
                v0
            };
            v6 = v16;
            let v17 = if (v7) {
                v0
            } else {
                v1
            };
            v5 = v17;
            v4 = true;
            if (v16 == v0) {
                v13 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
                v12 = true;
            } else {
                v13 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
                v12 = false;
            };
        };
        if (v13 == 0) {
            return (false, v5, v6, 0, 0, 0, false)
        };
        let v18 = *0x2::linked_table::front<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs);
        while (0x1::option::is_some<u64>(&v18)) {
            let v19 = *0x1::option::borrow<u64>(&v18);
            let v20 = *0x2::linked_table::borrow<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, v19);
            if (v13 >= v20.start_range && v13 <= v20.end_range) {
                v9 = v20.creator_fee_bps;
                v10 = v20.amm_fee_bps;
                v11 = v20.protocol_fee_pct;
                break
            };
            v18 = *0x2::linked_table::next<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, v19);
        };
        (v4, v5, v6, v9, v10, v11, v12)
    }

    fun compute_fees_decrease_amt(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let v0 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((arg1 as u128), (arg0 as u128), (arg4 as u128)) as u64);
        let v1 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((arg2 as u128), (arg0 as u128), (arg4 as u128)) as u64);
        (arg0 - v0 - v1, v0, v1, (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((arg3 as u128), (v1 as u128), (100 as u128)) as u64))
    }

    fun compute_fees_increase_amt(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        let v0 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg0 as u256), (arg4 as u256), ((arg4 - arg1) as u256)) as u64);
        let v1 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v0 as u256), (arg4 as u256), ((arg4 - arg2) as u256)) as u64);
        let v2 = v1 - v0;
        (v1, v0 - arg0, v2, (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((arg3 as u128), (v2 as u128), (100 as u128)) as u64))
    }

    fun convert_sui_fees_to_honey<T0, T1, T2>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: address, arg5: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0>) {
        assert!(arg0.module_version == 2 && arg5.module_version == 2, 5035);
        assert!(arg0.is_buyback_enabled, 5044);
        assert!(arg0.sui_honey_pool_addr == 0x2::object::uid_to_address(&arg5.id), 5045);
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) > 0) {
            let (v0, _) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::get_sui_fee_distribution_info(arg2);
            let v2 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg3), v0, 100);
            0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::add_to_treasury(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v2));
            let (v3, v4, _, _) = internal_swap<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0, T1, T2>(arg1, arg0, arg5, arg3, 0, 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(), 1, true);
            let v7 = v4;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::add_honey_bought_back(arg2, v7);
            let v8 = SuiFeeUsedForBuybacks{
                pool_addr             : arg4,
                sui_for_treasury      : v2,
                sui_for_honey_buyback : 0x2::balance::value<0x2::sui::SUI>(&arg3) - v2,
                honey_bought_amt      : 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&v7),
            };
            0x2::event::emit<SuiFeeUsedForBuybacks>(v8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public fun dangerous_burn_lp_coins<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg0.module_version == 2, 5036);
        let v0 = LpBurntForever{
            pool_addr : 0x2::object::uid_to_address(&arg0.id),
            lp_burned : 0x2::balance::value<LP<T0, T1, T2>>(&arg1),
        };
        0x2::event::emit<LpBurntForever>(v0);
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg0.lp_supply, arg1);
    }

    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &AmmAdminCap, arg2: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut PoolRegistry, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, true, arg4, false, arg5, 0x2::coin::get_decimals<T0>(arg6), 0x2::coin::get_decimals<T1>(arg7), arg8, arg9, arg10, arg11);
        v1
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &AmmAdminCap, arg2: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut PoolRegistry, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, true, arg4, false, arg5, 0x2::coin::get_decimals<T0>(arg6), get_decimal_for_coin<T1>(arg2), arg7, arg8, arg9, arg10);
        v1
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &AmmAdminCap, arg2: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut PoolRegistry, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, true, arg4, false, arg5, get_decimal_for_coin<T0>(arg2), 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v1
    }

    public fun enable_public_pools(arg0: &mut PoolRegistry, arg1: &AmmAdminCap, arg2: bool) {
        assert!(arg0.module_version == 2, 5036);
        arg0.enable_public_pools = arg2;
    }

    public fun flashloan<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Flashloan<T0, T1, T2>, u64, u64) {
        assert!(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg2 > 0 || arg3 > 0, 5018);
        assert!(!arg1.is_locked, 5009);
        assert!(arg1.module_version == 2, 5036);
        let v0 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, arg2);
        let v1 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, arg3);
        let v2 = arg1.fee_info.total_fee_bps;
        arg1.is_locked = true;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let v3 = 10000;
        let v4 = arg2 + (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v5 = arg3 + (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg3 as u256), (v2 as u256), (v3 as u256)) as u64);
        let v6 = Flashloan<T0, T1, T2>{
            x_loan : v4,
            y_loan : v5,
        };
        (v0, v1, v6, v4, v5)
    }

    public fun get_collected_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.collected_fee_x), 0x2::balance::value<T1>(&arg0.collected_fee_y))
    }

    fun get_decimal_for_coin<T0>(arg0: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield) : u8 {
        let (v0, v1) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::get_decimals_for_coin<T0>(arg0);
        assert!(v0, 5001);
        v1
    }

    public fun get_dynamic_fee_config(arg0: &PoolRegistry, arg1: u64) : CreatorFeeConfigInfo {
        if (0x2::linked_table::contains<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, arg1)) {
            let v1 = 0x2::linked_table::borrow<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, arg1);
            CreatorFeeConfigInfo{creator_fee_bps: v1.creator_fee_bps, start_range: v1.start_range, end_range: v1.end_range}
        } else {
            CreatorFeeConfigInfo{creator_fee_bps: 0, start_range: 0, end_range: 0}
        }
    }

    public fun get_dynamic_fee_configs(arg0: &PoolRegistry) : CreatorFeeConfigsInfo {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = *0x2::linked_table::front<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs);
        while (0x1::option::is_some<u64>(&v5)) {
            let v6 = *0x1::option::borrow<u64>(&v5);
            let v7 = *0x2::linked_table::borrow<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, v6);
            0x1::vector::push_back<u64>(&mut v0, v7.creator_fee_bps);
            0x1::vector::push_back<u64>(&mut v1, v7.amm_fee_bps);
            0x1::vector::push_back<u64>(&mut v2, v7.protocol_fee_pct);
            0x1::vector::push_back<u64>(&mut v3, v7.start_range);
            0x1::vector::push_back<u64>(&mut v4, v7.end_range);
            v5 = *0x2::linked_table::next<u64, DynamicFeeConfig>(&arg0.dynamic_fee_configs, v6);
        };
        CreatorFeeConfigsInfo{
            creator_fee_bps  : v0,
            amm_fee_bps      : v1,
            protocol_fee_pct : v2,
            start_range      : v3,
            end_range        : v4,
        }
    }

    public fun get_kraft_fee(arg0: &PoolRegistry) : u64 {
        arg0.kraft_fee
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

    public fun get_pool_curved_config_amp_gamma<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolCurvedConfigInfo {
        let (v0, v1, v2, v3, v4, v5) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_amp_gamma_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config));
        PoolCurvedConfigInfo{
            init_A_gamma_time   : v0,
            future_A_gamma_time : v1,
            init_amp            : v2,
            next_amp            : v3,
            init_gamma          : v4,
            next_gamma          : v5,
        }
    }

    public fun get_pool_curved_config_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolCurvedConfigFeeInfo {
        let (v0, v1, v2, v3, v4, v5) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_fee_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config));
        PoolCurvedConfigFeeInfo{
            mid_fee              : v0,
            out_fee              : v1,
            fee_gamma            : v2,
            ma_half_time         : v3,
            allowed_extra_profit : v4,
            adjustment_step      : v5,
        }
    }

    public fun get_pool_curved_config_precision<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : vector<u256> {
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_prices_info<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolCurvedConfigPricesInfo {
        let (v0, v1, v2, v3) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config));
        PoolCurvedConfigPricesInfo{
            price_scale           : v0,
            oracle_prices         : v1,
            last_prices           : v2,
            last_prices_timestamp : v3,
        }
    }

    public fun get_pool_curved_config_xcp<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolCurvedConfigXcpInfo {
        let (v0, v1, v2, v3) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config));
        PoolCurvedConfigXcpInfo{
            invariant     : v0,
            virtual_price : v1,
            xcp_profit    : v2,
            not_adjusted  : v3,
        }
    }

    public fun get_pool_fee_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (arg0.fee_info.total_fee_bps, arg0.fee_info.protocol_fee_pct)
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &PoolRegistry) : 0x2::object::ID {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::with_defining_ids<T0>(),
            b     : 0x1::type_name::with_defining_ids<T1>(),
            curve : 0x1::type_name::with_defining_ids<T2>(),
        };
        *0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun get_pool_id_as_address<T0, T1, T2>(arg0: &PoolRegistry) : address {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::with_defining_ids<T0>(),
            b     : 0x1::type_name::with_defining_ids<T1>(),
            curve : 0x1::type_name::with_defining_ids<T2>(),
        };
        0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0))
    }

    public fun get_pool_registry(arg0: &PoolRegistry) : (u64, address) {
        (0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list), arg0.sui_honey_pool_addr)
    }

    public fun get_pool_reserves<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve))
    }

    public fun get_pool_reserves_decimals<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u8, u8) {
        (arg0.coin_x_decimals, arg0.coin_y_decimals)
    }

    public fun get_pool_stable_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolStableConfigInfo {
        let (v0, v1, v2, v3, v4) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::get_stable_config_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(&arg0.stable_config));
        PoolStableConfigInfo{
            init_amp_time  : v0,
            init_amp       : v1,
            next_amp_time  : v2,
            next_amp       : v3,
            scaling_factor : v4,
        }
    }

    public fun get_pool_total_supply<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolReservesInfo {
        let v0 = arg0.total_lp_krafted;
        let v1 = 0x2::balance::supply_value<LP<T0, T1, T2>>(&arg0.lp_supply);
        PoolReservesInfo{
            lp_total_minted   : v0,
            lp_in_circulation : v1,
            lp_burnt          : v0 - v1,
        }
    }

    public fun get_pool_weighted_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : PoolWeightedConfigInfo {
        let (v0, v1, v2, v3) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_weighted_config_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg0.weighted_config));
        PoolWeightedConfigInfo{
            weights        : v0,
            scaling_factor : v1,
            total_weight   : v2,
            exit_fee       : v3,
        }
    }

    public fun get_poolhive_addr<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : address {
        *0x1::option::borrow<address>(&arg0.pool_hive_addr)
    }

    public fun get_scaling_factor<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>) : (u64, vector<u256>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            v1 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg1.curved_config));
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            let (v2, v3) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(&arg1.stable_config));
            v1 = v3;
            v0 = v2;
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_weighted<T2>()) {
            v1 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg1.weighted_config));
        };
        (v0, v1)
    }

    public fun get_sui_hive_pool_for_pol(arg0: &PoolRegistry) : address {
        arg0.sui_honey_pool_addr
    }

    public fun harvest_honey_fee(arg0: &PoolRegistry, arg1: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>, arg3: &0x2::tx_context::TxContext) {
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::add_honey_bought_back(arg1, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::extract_fee_for_coin<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&arg0.fee_claim_cap, arg2));
    }

    fun imbalanced_exit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : (u64, vector<u64>) {
        let (v0, v1) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v2 = v1;
        let (v3, v4) = if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            let (v5, v6) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::imbalanced_liquidity_withdraw(v0, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v2), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v6;
            (v3, v5)
        } else {
            let (v7, v8) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::imbalanced_liquidity_withdraw(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg1.weighted_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v2), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg4), v2), arg5);
            let v3 = v8;
            (v3, v7)
        };
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 0) / *0x1::vector::borrow<u256>(&v2, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v9, ((*0x1::vector::borrow<u256>(&v3, 1) / *0x1::vector::borrow<u256>(&v2, 1)) as u64));
        ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(v4, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64), v9)
    }

    public fun increment_liquidity_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>) {
        assert!(arg0.module_version == 2, 5035);
        arg0.module_version = 2;
    }

    public fun increment_pool_registry(arg0: &mut PoolRegistry) {
        assert!(arg0.module_version == 2, 5035);
        arg0.module_version = 2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AmmAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AmmAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_pool_registry(arg0: &AmmAdminCap, arg1: 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::TwoAmmAccess, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                    : 0x2::object::new(arg3),
            kraft_fee             : 0,
            krafted_pools_list    : 0x2::linked_table::new<PoolRegistryItem, 0x2::object::ID>(arg3),
            fee_claim_cap         : arg1,
            sui_honey_pool_addr   : arg2,
            enable_public_pools   : false,
            supported_tokens_list : 0x2::linked_table::new<0x1::ascii::String, bool>(arg3),
            dynamic_fee_configs   : 0x2::linked_table::new<u64, DynamicFeeConfig>(arg3),
            is_buyback_enabled    : false,
            bag                   : 0x2::bag::new(arg3),
            module_version        : 2,
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
        let v3 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v4 = arg1.fee_info.total_fee_bps;
        let v5 = arg1.fee_info.protocol_fee_pct;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v6, v7) = get_scaling_factor<T0, T1, T2>(arg0, arg1);
        let v8 = v7;
        let (v9, v10) = if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            let (v11, v12) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::add_liquidity_computation(arg0, 0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(v3, v8), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
            let v9 = v12;
            let (v13, v14, v15, v16) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v17, v18, v19, v20) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v21 = InternalPricesUpdatedEvent{
                type_x                : 0x1::type_name::with_defining_ids<T0>(),
                type_y                : 0x1::type_name::with_defining_ids<T1>(),
                type_curve            : 0x1::type_name::with_defining_ids<T2>(),
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
            0x2::event::emit<InternalPricesUpdatedEvent>(v21);
            (v9, v11)
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            let (v22, v23) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::add_liquidity_computation(v6, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(v3, v8), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
            let v9 = v23;
            (v9, v22)
        } else {
            let (v24, v25) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::add_liquidity_computation(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg1.weighted_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(v3, v8), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), v4, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
            let v9 = v25;
            (v9, v24)
        };
        let v26 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(v10, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64);
        let v27 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v27, ((*0x1::vector::borrow<u256>(&v9, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
        0x1::vector::push_back<u64>(&mut v27, ((*0x1::vector::borrow<u256>(&v9, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
        assert!(v26 > 0, 5007);
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, arg3);
        let v28 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v27, 0));
        let v29 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v27, 1));
        let v30 = 100;
        let v31 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((*0x1::vector::borrow<u64>(&v27, 0) as u128), (v5 as u128), (v30 as u128)) as u64);
        let v32 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((*0x1::vector::borrow<u64>(&v27, 1) as u128), (v5 as u128), (v30 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.collected_fee_x, 0x2::balance::split<T0>(&mut v28, v31));
        0x2::balance::join<T1>(&mut arg1.collected_fee_y, 0x2::balance::split<T1>(&mut v29, v32));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v28);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v29);
        let v33 = LiquidityAddedToPoolEvent{
            type_x        : 0x1::type_name::with_defining_ids<T0>(),
            type_y        : 0x1::type_name::with_defining_ids<T1>(),
            type_curve    : 0x1::type_name::with_defining_ids<T2>(),
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : v0,
            coin_y_amount : v1,
            lp_minted     : v26,
            total_x_fee   : *0x1::vector::borrow<u64>(&v27, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v27, 1),
            x_hive_fee    : v31,
            y_hive_fee    : v32,
        };
        0x2::event::emit<LiquidityAddedToPoolEvent>(v33);
        v26
    }

    fun internal_register_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: bool, arg4: &mut PoolRegistry, arg5: bool, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: u8, arg8: u8, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg4.module_version == 2, 5036);
        if (arg5) {
            assert!(arg4.enable_public_pools, 5046);
        };
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::collect_fee_for_coin<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg6, arg4.kraft_fee));
        0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::assert_valid_curve<T2>();
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::ascii::append(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        0x1::ascii::append(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()));
        let v1 = 0x1::string::from_ascii(v0);
        let v2 = 0x2::derived_object::claim<0x1::string::String>(&mut arg4.id, v1);
        registry_add<T0, T1, T2>(arg4, arg7, arg8, 0x2::object::uid_to_inner(&v2), arg3);
        let (v3, v4) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::get_fee_info<T2>(arg1);
        let v5 = NewPoolCreatedEvent{
            type_x            : 0x1::type_name::with_defining_ids<T0>(),
            type_y            : 0x1::type_name::with_defining_ids<T1>(),
            type_curve        : 0x1::type_name::with_defining_ids<T2>(),
            pool_id           : 0x2::object::uid_to_inner(&v2),
            id_identifier_str : v1,
        };
        0x2::event::emit<NewPoolCreatedEvent>(v5);
        let v6 = LP<T0, T1, T2>{dummy_field: false};
        let v7 = PoolFeeInfo{
            total_fee_bps    : v3,
            protocol_fee_pct : v4,
        };
        let v8 = LiquidityPool<T0, T1, T2>{
            id                 : v2,
            coin_x_reserve     : 0x2::balance::zero<T0>(),
            coin_x_decimals    : arg7,
            coin_y_reserve     : 0x2::balance::zero<T1>(),
            coin_y_decimals    : arg8,
            lp_supply          : 0x2::balance::create_supply<LP<T0, T1, T2>>(v6),
            total_lp_krafted   : 0,
            curved_config      : 0x1::option::none<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(),
            stable_config      : 0x1::option::none<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(),
            weighted_config    : 0x1::option::none<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(),
            collected_fee_x    : 0x2::balance::zero<T0>(),
            collected_fee_y    : 0x2::balance::zero<T1>(),
            fee_info           : v7,
            is_locked          : false,
            cumulative_x_price : 0,
            cumulative_y_price : 0,
            last_timestamp     : 0x2::clock::timestamp_ms(arg0),
            pool_hive_addr     : 0x1::option::none<address>(),
            is_swap_enabled    : true,
            bag                : 0x2::bag::new(arg12),
            module_version     : 2,
        };
        let v9 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v9, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::computeScalingFactor(arg7));
        0x1::vector::push_back<u256>(&mut v9, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::computeScalingFactor(arg8));
        if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            assert!(0x1::option::is_some<vector<u256>>(&arg10), 5003);
            v8.curved_config = 0x1::option::some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::initialize_curved_config(arg0, arg9, 0x1::option::extract<vector<u256>>(&mut arg10), v9, (2 as u128), arg12));
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            v8.stable_config = 0x1::option::some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::StablePoolConfig>(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::initialize_stable_config(arg0, arg9, v9, arg12));
        } else {
            assert!(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_weighted<T2>(), 5024);
            assert!(0x1::option::is_some<vector<u64>>(&arg11), 5004);
            v8.weighted_config = 0x1::option::some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::initialize_weighted_config(arg9, 0x1::option::extract<vector<u64>>(&mut arg11), v9, 2, arg12));
        };
        let v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg4.supported_tokens_list, v10)) {
            let v11 = CollectedFees<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>{
                sui_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
                ggsui_fees : 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>(),
            };
            0x2::dynamic_field::add<0x1::ascii::String, CollectedFees<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>>(&mut v8.id, v10, v11);
        };
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg4.supported_tokens_list, v12)) {
            let v13 = CollectedFees<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>{
                sui_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
                ggsui_fees : 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>(),
            };
            0x2::dynamic_field::add<0x1::ascii::String, CollectedFees<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>>(&mut v8.id, v12, v13);
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1, T2>>(v8);
        (0x2::object::uid_to_address(&v2), arg6)
    }

    fun internal_remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64) {
        assert!(!arg1.is_locked, 5009);
        let v0 = (arg1.total_lp_krafted as u128);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = arg1.fee_info.total_fee_bps;
        let v4 = arg1.fee_info.protocol_fee_pct;
        let v5 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v6 = arg2;
        let v7 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::create_zero_vector(2);
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        if (arg3 == 0 && arg4 == 0) {
            *0x1::vector::borrow_mut<u64>(&mut v5, 0) = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), (v1 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v5, 1) = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), (v2 as u256), (v0 as u256)) as u64);
            if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
                0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::reduce_d(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v0 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
            };
        } else {
            if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
                abort 5011
            };
            let (v8, v9) = imbalanced_exit<T0, T1, T2>(arg0, arg1, (v0 as u64), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()), v5, v3);
            v7 = v9;
            v6 = v8;
        };
        assert!(v6 > 0 && v6 <= arg2, 5010);
        let v10 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v5, 0));
        let v11 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v5, 1));
        let v12 = 10000;
        if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_weighted<T2>()) {
            let v13 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_exit_fee(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg1.weighted_config));
            *0x1::vector::borrow_mut<u64>(&mut v7, 0) = *0x1::vector::borrow<u64>(&v7, 0) + 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(*0x1::vector::borrow<u64>(&v5, 0), v13, v12);
            *0x1::vector::borrow_mut<u64>(&mut v7, 1) = *0x1::vector::borrow<u64>(&v7, 1) + 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(*0x1::vector::borrow<u64>(&v5, 1), v13, v12);
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
        let v16 = 100;
        let v17 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 0) as u128), (v4 as u128), (v16 as u128)) as u64);
        let v18 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 1) as u128), (v4 as u128), (v16 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.collected_fee_x, 0x2::balance::split<T0>(&mut v14, v17));
        0x2::balance::join<T1>(&mut arg1.collected_fee_y, 0x2::balance::split<T1>(&mut v15, v18));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v14);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v15);
        let v19 = LiquidityRemovedFromPoolEvent{
            type_x        : 0x1::type_name::with_defining_ids<T0>(),
            type_y        : 0x1::type_name::with_defining_ids<T1>(),
            type_curve    : 0x1::type_name::with_defining_ids<T2>(),
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : *0x1::vector::borrow<u64>(&v5, 0),
            coin_y_amount : *0x1::vector::borrow<u64>(&v5, 1),
            lp_burned     : v6,
            total_x_fee   : *0x1::vector::borrow<u64>(&v7, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v7, 1),
            x_hive_fee    : v17,
            y_hive_fee    : v18,
        };
        0x2::event::emit<LiquidityRemovedFromPoolEvent>(v19);
        (v10, v11, arg2 - v6)
    }

    fun internal_swap<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::ascii::String, u64) {
        assert!(!arg2.is_locked, 5009);
        assert!(arg2.module_version == 2, 5036);
        assert!(arg2.is_swap_enabled, 5040);
        let v0 = 10000;
        let (v1, v2, v3, v4, v5, v6, v7) = compute_dynamic_fee<T0, T1, T2>(arg1, arg2);
        let v8 = v6;
        let v9 = v5;
        let v10 = v3;
        let v11 = false;
        if (v5 == 0) {
            v9 = arg2.fee_info.total_fee_bps;
            v8 = arg2.fee_info.protocol_fee_pct;
        };
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        let v17 = 0x2::balance::zero<T0>();
        let v18 = 0x2::balance::zero<T1>();
        let (v19, v20, v21) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::get_asset_index_and_amount(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::create_vector(0x1::option::some<u64>(0x2::balance::value<T0>(&arg3)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg5)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v22 = v19;
        assert!(!v21, 5012);
        let (v23, v24, v25) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::get_asset_index_and_amount(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::create_vector(0x1::option::some<u64>(arg4), 0x1::option::some<u64>(arg6), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v26 = v23;
        assert!(!v25, 5013);
        assert!(v20 != v24, 5014);
        let v27 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg2.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v28 = (arg2.total_lp_krafted as u128);
        let v29 = if (v20 == 0) {
            if (v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v29) {
            if (arg7) {
                let (v30, v31, v32, v33) = compute_fees_decrease_amt(v19, v4, v9, v8, v0);
                v14 = v33;
                v13 = v32;
                v12 = v31;
                v22 = v30;
                0x2::balance::join<T0>(&mut v17, 0x2::balance::split<T0>(&mut arg3, v31 + v32));
            } else {
                v11 = true;
            };
        };
        let v34 = if (v20 == 1) {
            if (v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v34) {
            if (arg7) {
                v11 = true;
            } else {
                let (v35, v36, v37, v38) = compute_fees_increase_amt(v23, v4, v9, v8, v0);
                v14 = v38;
                v13 = v37;
                v12 = v36;
                v26 = v35;
            };
        };
        let v39 = if (v20 == 0) {
            if (!v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v39) {
            if (arg7) {
                v11 = true;
            } else {
                let (v40, v41, v42, v43) = compute_fees_increase_amt(v26, v4, v9, v8, v0);
                v14 = v43;
                v13 = v42;
                v12 = v41;
                v26 = v40;
            };
        };
        let v44 = if (v20 == 1) {
            if (!v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v44) {
            if (arg7) {
                let (v45, v46, v47, v48) = compute_fees_decrease_amt(v22, v4, v9, v8, v0);
                v14 = v48;
                v13 = v47;
                v12 = v46;
                v22 = v45;
                0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(&mut arg5, v46 + v47));
            } else {
                v11 = true;
            };
        };
        if (!v1) {
            if (arg7) {
                let (v49, v50, v51, v52) = compute_fees_decrease_amt(v22, v4, v9, v8, v0);
                v14 = v52;
                v13 = v51;
                v12 = v50;
                v22 = v49;
                if (v20 == 0) {
                    v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
                    0x2::balance::join<T0>(&mut v17, 0x2::balance::split<T0>(&mut arg3, v50 + v51));
                } else {
                    v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
                    0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(&mut arg5, v50 + v51));
                };
            } else {
                let (v53, v54, v55, v56) = compute_fees_increase_amt(v26, v4, v9, v8, v0);
                v14 = v56;
                v13 = v55;
                v12 = v54;
                v26 = v53;
                v11 = true;
            };
        };
        let v57 = 0;
        let v58 = 0;
        let v59 = 0;
        update_cumulative_prices<T0, T1, T2>(arg0, arg2);
        let (v60, v61) = get_scaling_factor<T0, T1, T2>(arg0, arg2);
        let v62 = v61;
        let v63 = *0x1::vector::borrow<u256>(&v62, v24);
        if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            if (arg7) {
                v57 = v22;
                let (v64, v65) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::compute_ask_amount(arg0, 0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg2.curved_config), v20, v24, (v22 as u256) * *0x1::vector::borrow<u256>(&v62, v20), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(v27), v62), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v28 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
                v58 = ((v64 / v63) as u64);
                v59 = ((v65 / v63) as u64);
            } else {
                let (v66, v67) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::compute_offer_amount(arg0, 0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg2.curved_config), v20, v24, (v26 as u256) * v63, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(v27), v62), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v28 as u256), 1000000000000000000, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_u256(10, (6 as u128))));
                v57 = ((v66 / *0x1::vector::borrow<u256>(&v62, v20)) as u64);
                let v68 = ((v67 / v63) as u64);
                v59 = v68;
                v58 = v26 + v68;
            };
            let (v69, v70, v71, v72) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg2.curved_config));
            let (v73, v74, v75, v76) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg2.curved_config));
            let v77 = InternalPricesUpdatedEvent{
                type_x                : 0x1::type_name::with_defining_ids<T0>(),
                type_y                : 0x1::type_name::with_defining_ids<T1>(),
                type_curve            : 0x1::type_name::with_defining_ids<T2>(),
                id                    : 0x2::object::uid_to_inner(&arg2.id),
                price_scale           : v69,
                oracle_prices         : v70,
                last_prices           : v71,
                last_prices_timestamp : v72,
                virtual_price         : v74,
                xcp_profit            : v75,
                not_adjusted          : v76,
                _D                    : v73,
            };
            0x2::event::emit<InternalPricesUpdatedEvent>(v77);
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            if (arg7) {
                v57 = v22;
                v58 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::compute_ask_amount(v60, v20, (v22 as u256) * *0x1::vector::borrow<u256>(&v62, v20), v24, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(v27), v62)) / v63) as u64);
            } else {
                v57 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::compute_offer_amount(v60, (v26 as u256) * v63, v24, v20, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(v27), v62)) / *0x1::vector::borrow<u256>(&v62, v20)) as u64);
                v58 = v26;
            };
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_weighted<T2>()) {
            let (v78, v79) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg2.weighted_config), v20, true);
            let (v80, v81) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg2.weighted_config), v24, true);
            if (arg7) {
                v57 = v22;
                v58 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::compute_ask_amount((v22 as u256) * v79, (*0x1::vector::borrow<u64>(&v27, v20) as u256) * v79, (v78 as u256), (*0x1::vector::borrow<u64>(&v27, v24) as u256) * v81, (v80 as u256)) / v81) as u64);
            } else {
                v57 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::compute_offer_amount((v26 as u256) * v81, (*0x1::vector::borrow<u64>(&v27, v24) as u256) * v81, (v80 as u256), (*0x1::vector::borrow<u64>(&v27, v20) as u256) * v79, (v78 as u256)) / v79) as u64);
                v58 = v26;
            };
        };
        assert!(v58 >= v26, 5016);
        assert!(v57 <= v22, 5017);
        if (!v1) {
            if (v20 == 0) {
                0x2::balance::join<T0>(&mut arg2.coin_x_reserve, 0x2::balance::split<T0>(&mut arg3, v57));
                0x2::balance::join<T1>(&mut arg5, 0x2::balance::split<T1>(&mut arg2.coin_y_reserve, v58));
            } else {
                0x2::balance::join<T1>(&mut arg2.coin_y_reserve, 0x2::balance::split<T1>(&mut arg5, v57));
                0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2.coin_x_reserve, v58));
            };
            if (!arg7) {
                if (v24 == 0) {
                    v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
                    0x2::balance::join<T0>(&mut v17, 0x2::balance::split<T0>(&mut arg3, v13));
                } else {
                    v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
                    0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(&mut arg5, v13));
                };
            };
        };
        let v82 = if (v20 == 0) {
            if (v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v82) {
            if (v11) {
                let (v83, v84, v85, v86) = compute_fees_increase_amt(v57, v4, v9, v8, v0);
                v14 = v86;
                v13 = v85;
                v12 = v84;
                0x2::balance::join<T0>(&mut v17, 0x2::balance::split<T0>(&mut arg3, v84 + v85));
                v57 = v83 - v84 - v85;
            };
            0x2::balance::join<T0>(&mut arg2.coin_x_reserve, 0x2::balance::split<T0>(&mut arg3, v57));
            0x2::balance::join<T1>(&mut arg5, 0x2::balance::split<T1>(&mut arg2.coin_y_reserve, v58));
        };
        let v87 = if (v20 == 1) {
            if (v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v87) {
            if (v11) {
                let (v88, v89, v90, v91) = compute_fees_decrease_amt(v58, v4, v9, v8, v0);
                v14 = v91;
                v13 = v90;
                v12 = v89;
                v58 = v88;
            } else {
                let v92 = v58 - v12;
                v58 = v92 - v13;
            };
            0x2::balance::join<T0>(&mut v17, 0x2::balance::split<T0>(&mut arg2.coin_x_reserve, v12 + v13));
            0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2.coin_x_reserve, v58));
            0x2::balance::join<T1>(&mut arg2.coin_y_reserve, 0x2::balance::split<T1>(&mut arg5, v57));
        };
        let v93 = if (v20 == 0) {
            if (!v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v93) {
            if (v11) {
                let (v94, v95, v96, v97) = compute_fees_decrease_amt(v58, v4, v9, v8, v0);
                v14 = v97;
                v13 = v96;
                v12 = v95;
                v58 = v94;
            } else {
                let v98 = v58 - v12;
                v58 = v98 - v13;
            };
            0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(&mut arg2.coin_y_reserve, v12 + v13));
            0x2::balance::join<T0>(&mut arg2.coin_x_reserve, 0x2::balance::split<T0>(&mut arg3, v57));
            0x2::balance::join<T1>(&mut arg5, 0x2::balance::split<T1>(&mut arg2.coin_y_reserve, v58));
        };
        let v99 = if (v20 == 1) {
            if (!v7) {
                v1
            } else {
                false
            }
        } else {
            false
        };
        if (v99) {
            if (v11) {
                let (v100, v101, v102, v103) = compute_fees_increase_amt(v57, v4, v9, v8, v0);
                v14 = v103;
                v13 = v102;
                v12 = v101;
                0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(&mut arg5, v101 + v102));
                v57 = v100 - v101 - v102;
            };
            0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2.coin_x_reserve, v58));
            0x2::balance::join<T1>(&mut arg2.coin_y_reserve, 0x2::balance::split<T1>(&mut arg5, v57));
        };
        if (v59 > 0 && 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            if (v24 == 0) {
                v15 = v59;
                0x2::balance::join<T0>(&mut arg2.coin_x_reserve, 0x2::balance::split<T0>(&mut arg3, v59));
            } else {
                v16 = v59;
                0x2::balance::join<T1>(&mut arg2.coin_y_reserve, 0x2::balance::split<T1>(&mut arg5, v59));
            };
        };
        if (0x2::balance::value<T0>(&v17) > 0) {
            if (v1 && v10 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())) {
                store_creator_fees_sui<T0, T1, T2, T0, T4>(arg2, v2, 0x2::balance::split<T0>(&mut v17, v12));
            } else if (v1 && v10 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>())) {
                store_creator_fees_ggsui<T0, T1, T2, T3, T0>(arg2, v2, 0x2::balance::split<T0>(&mut v17, v12));
            };
            0x2::balance::join<T0>(&mut arg2.collected_fee_x, 0x2::balance::split<T0>(&mut v17, v14));
            0x2::balance::join<T0>(&mut arg2.coin_x_reserve, v17);
        } else {
            0x2::balance::join<T0>(&mut arg2.coin_x_reserve, v17);
        };
        if (0x2::balance::value<T1>(&v18) > 0) {
            if (v1 && v10 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())) {
                store_creator_fees_sui<T0, T1, T2, T1, T4>(arg2, v2, 0x2::balance::split<T1>(&mut v18, v12));
            } else if (v1 && v10 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::ggsui::GGSUI>())) {
                store_creator_fees_ggsui<T0, T1, T2, T3, T1>(arg2, v2, 0x2::balance::split<T1>(&mut v18, v12));
            };
            0x2::balance::join<T1>(&mut arg2.collected_fee_y, 0x2::balance::split<T1>(&mut v18, v14));
            0x2::balance::join<T1>(&mut arg2.coin_y_reserve, v18);
        } else {
            0x2::balance::join<T1>(&mut arg2.coin_y_reserve, v18);
        };
        let v104 = 0;
        let v105 = 0;
        let v106 = 0;
        let v107 = 0;
        if (v20 == 0) {
            v107 = 0x2::balance::value<T0>(&arg3) - 0x2::balance::value<T0>(&arg3);
            v104 = 0x2::balance::value<T1>(&arg5) - 0x2::balance::value<T1>(&arg5);
        } else {
            v106 = 0x2::balance::value<T1>(&arg5) - 0x2::balance::value<T1>(&arg5);
            v105 = 0x2::balance::value<T0>(&arg3) - 0x2::balance::value<T0>(&arg3);
        };
        let v108 = TokensSwappedEvent{
            type_x       : 0x1::type_name::with_defining_ids<T0>(),
            type_y       : 0x1::type_name::with_defining_ids<T1>(),
            type_curve   : 0x1::type_name::with_defining_ids<T2>(),
            id           : 0x2::object::uid_to_inner(&arg2.id),
            x_offer_amt  : v107,
            y_offer_amt  : v106,
            x_return_amt : v105,
            y_return_amt : v104,
        };
        0x2::event::emit<TokensSwappedEvent>(v108);
        let v109 = SwapFeeChargedEvent{
            id                   : 0x2::object::uid_to_inner(&arg2.id),
            is_supported         : v1,
            supported_token_type : v2,
            fee_token_type       : v10,
            creator_fee_amt      : v12,
            amm_fee_amt          : v13,
            protocol_fee_amt     : v14,
            x_fee_curved_pool    : v15,
            y_fee_curved_pool    : v16,
        };
        0x2::event::emit<SwapFeeChargedEvent>(v109);
        (arg3, arg5, v10, v12 + v13 + v14)
    }

    public fun is_pool_registered<T0, T1, T2>(arg0: &PoolRegistry) : bool {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::with_defining_ids<T0>(),
            b     : 0x1::type_name::with_defining_ids<T1>(),
            curve : 0x1::type_name::with_defining_ids<T2>(),
        };
        0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun is_supported_token<T0>(arg0: &PoolRegistry) : bool {
        0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun pay_flashloan<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: Flashloan<T0, T1, T2>) {
        assert!(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg0.module_version == 2, 5036);
        let Flashloan {
            x_loan : v0,
            y_loan : v1,
        } = arg3;
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 >= v0 && v3 >= v1, 5020);
        let v4 = arg0.fee_info.total_fee_bps;
        let v5 = arg0.fee_info.protocol_fee_pct;
        let v6 = 10000;
        let v7 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v2 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v8 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v3 as u256), (v4 as u256), (v6 as u256)) as u64);
        let v9 = 0x2::balance::split<T0>(&mut arg1, v7);
        let v10 = 0x2::balance::split<T1>(&mut arg2, v8);
        let v11 = 100;
        let v12 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(v7, v5, v11);
        let v13 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(v8, v5, v11);
        0x2::balance::join<T0>(&mut arg0.collected_fee_x, 0x2::balance::split<T0>(&mut v9, v12));
        0x2::balance::join<T1>(&mut arg0.collected_fee_y, 0x2::balance::split<T1>(&mut v10, v13));
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, arg2);
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, v9);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, v10);
        let v14 = FlashLoanExecutedEvent{
            type_x      : 0x1::type_name::with_defining_ids<T0>(),
            type_y      : 0x1::type_name::with_defining_ids<T1>(),
            type_curve  : 0x1::type_name::with_defining_ids<T2>(),
            id          : 0x2::object::uid_to_inner(&arg0.id),
            x_loan      : v0,
            y_loan      : v1,
            total_x_fee : v7,
            total_y_fee : v8,
            x_hive_fee  : v12,
            y_hive_fee  : v13,
        };
        0x2::event::emit<FlashLoanExecutedEvent>(v14);
        arg0.is_locked = false;
    }

    public fun query_across_all_pools<T0, T1, T2>(arg0: &PoolRegistry, arg1: u64) : PoolsInfo {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = PoolRegistryItem{
            a     : 0x1::type_name::with_defining_ids<T0>(),
            b     : 0x1::type_name::with_defining_ids<T1>(),
            curve : 0x1::type_name::with_defining_ids<T2>(),
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
        PoolsInfo{
            x_identifiers     : v1,
            y_identifiers     : v2,
            curve_identifiers : v3,
            pools_list        : v0,
            total_pools       : 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list),
        }
    }

    fun query_internal_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &LiquidityPool<T0, T1, T2>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 10000;
        if (arg2.is_locked) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5009)
        };
        let v1 = 0;
        let v2 = 0;
        if (arg8) {
            let v3 = if (arg4 > 0) {
                arg4
            } else {
                0
            };
            v1 = v3;
            let v4 = if (arg6 > 0) {
                arg6
            } else {
                0
            };
            v2 = v4;
        };
        let (v5, _, _, v8, v9, v10, v11) = compute_dynamic_fee<T0, T1, T2>(arg1, arg2);
        let v12 = v10;
        let v13 = v9;
        let v14 = false;
        if (v9 == 0) {
            v13 = arg2.fee_info.total_fee_bps;
            v12 = arg2.fee_info.protocol_fee_pct;
        };
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let (v18, v19, v20) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::get_asset_index_and_amount(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::create_vector(0x1::option::some<u64>(arg4), 0x1::option::some<u64>(arg6), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v21 = v18;
        if (v20) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5012)
        };
        let (v22, v23, v24) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::get_asset_index_and_amount(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::create_vector(0x1::option::some<u64>(arg5), 0x1::option::some<u64>(arg7), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v25 = v22;
        if (v24) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5012)
        };
        if (v19 == v23) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5014)
        };
        if (v22 > *0x1::vector::borrow<u64>(&arg3, v23)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5028)
        };
        let v26 = if (v19 == 0) {
            if (v11) {
                v5
            } else {
                false
            }
        } else {
            false
        };
        if (v26) {
            if (arg8) {
                let (v27, v28, v29, v30) = compute_fees_decrease_amt(v18, v8, v13, v12, v0);
                v17 = v30;
                v16 = v29;
                v15 = v28;
                v21 = v27;
            } else {
                v14 = true;
            };
        };
        let v31 = if (v19 == 1) {
            if (v11) {
                v5
            } else {
                false
            }
        } else {
            false
        };
        if (v31) {
            if (arg8) {
                v14 = true;
            } else {
                let (v32, v33, v34, v35) = compute_fees_increase_amt(v22, v8, v13, v12, v0);
                v17 = v35;
                v16 = v34;
                v15 = v33;
                v25 = v32;
            };
        };
        let v36 = if (v19 == 0) {
            if (!v11) {
                v5
            } else {
                false
            }
        } else {
            false
        };
        if (v36) {
            if (arg8) {
                v14 = true;
            } else {
                let (v37, v38, v39, v40) = compute_fees_increase_amt(v25, v8, v13, v12, v0);
                v17 = v40;
                v16 = v39;
                v15 = v38;
                v25 = v37;
            };
        };
        let v41 = if (v19 == 1) {
            if (!v11) {
                v5
            } else {
                false
            }
        } else {
            false
        };
        if (v41) {
            if (arg8) {
                let (v42, v43, v44, v45) = compute_fees_decrease_amt(v21, v8, v13, v12, v0);
                v17 = v45;
                v16 = v44;
                v15 = v43;
                v21 = v42;
            } else {
                v14 = true;
            };
        };
        if (!v5) {
            if (arg8) {
                let (v46, v47, v48, v49) = compute_fees_decrease_amt(v21, v8, v13, v12, v0);
                v17 = v49;
                v16 = v48;
                v15 = v47;
                v21 = v46;
            } else {
                let (v50, v51, v52, v53) = compute_fees_increase_amt(v25, v8, v13, v12, v0);
                v17 = v53;
                v16 = v52;
                v15 = v51;
                v25 = v50;
                v14 = true;
            };
        };
        let v54 = 0;
        let v55 = 0;
        let v56 = 0;
        let (v57, v58) = get_scaling_factor<T0, T1, T2>(arg0, arg2);
        let v59 = v58;
        let v60 = *0x1::vector::borrow<u256>(&v59, v23);
        if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
            if (arg8) {
                v54 = v21;
                let (v61, v62) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::query_ask_amount(arg0, 0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg2.curved_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v59), (v21 as u256) * *0x1::vector::borrow<u256>(&v59, v19), v19, v23);
                v55 = ((v61 / v60) as u64);
                v56 = ((v62 / v60) as u64);
            } else {
                let (v63, v64) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::query_offer_amount(arg0, 0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg2.curved_config), 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v59), (v25 as u256) * v60, v19, v23);
                v54 = ((v63 / *0x1::vector::borrow<u256>(&v59, v19)) as u64);
                let v65 = ((v64 / v60) as u64);
                v56 = v65;
                v55 = v25 + v65;
            };
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_stable<T2>()) {
            if (arg8) {
                v54 = v21;
                v55 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::compute_ask_amount(v57, v19, (v21 as u256) * *0x1::vector::borrow<u256>(&v59, v19), v23, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v59)) / v60) as u64);
            } else {
                v54 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::stable_math::compute_offer_amount(v57, (v25 as u256) * v60, v23, v19, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::multiply_vectors_u256(0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_u64_to_u256(arg3), v59)) / *0x1::vector::borrow<u256>(&v59, v19)) as u64);
                v55 = v25;
            };
        } else if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_weighted<T2>()) {
            let v66 = 0x1::option::borrow<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::WeightedConfig>(&arg2.weighted_config);
            let (v67, v68) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_weight_and_sf_at_index(v66, v19, true);
            let (v69, v70) = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::get_weight_and_sf_at_index(v66, v23, true);
            if (arg8) {
                v54 = v21;
                v55 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::compute_ask_amount((v21 as u256) * v68, (*0x1::vector::borrow<u64>(&arg3, v19) as u256) * v68, (v67 as u256), (*0x1::vector::borrow<u64>(&arg3, v23) as u256) * v70, (v69 as u256)) / v70) as u64);
            } else {
                v54 = ((0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::weighted_math::compute_offer_amount((v25 as u256) * v70, (*0x1::vector::borrow<u64>(&arg3, v23) as u256) * v70, (v69 as u256), (*0x1::vector::borrow<u64>(&arg3, v19) as u256) * v68, (v67 as u256)) / v68) as u64);
                v55 = v25;
            };
        };
        if (v14) {
            let v71 = if (v19 == 0) {
                if (v11) {
                    v5
                } else {
                    false
                }
            } else {
                false
            };
            if (v71) {
                let (v72, v73, v74, v75) = compute_fees_increase_amt(v54, v8, v13, v12, v0);
                v17 = v75;
                v16 = v74;
                v15 = v73;
                v54 = v72;
            } else {
                let v76 = if (v19 == 1) {
                    if (v11) {
                        v5
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v76) {
                    let (v77, v78, v79, v80) = compute_fees_decrease_amt(v55, v8, v13, v12, v0);
                    v17 = v80;
                    v16 = v79;
                    v15 = v78;
                    v55 = v77;
                } else {
                    let v81 = if (v19 == 0) {
                        if (!v11) {
                            v5
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v81) {
                        let (v82, v83, v84, v85) = compute_fees_decrease_amt(v55, v8, v13, v12, v0);
                        v17 = v85;
                        v16 = v84;
                        v15 = v83;
                        v55 = v82;
                    } else {
                        let v86 = if (v19 == 1) {
                            if (!v11) {
                                v5
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v86) {
                            let (v87, v88, v89, v90) = compute_fees_increase_amt(v54, v8, v13, v12, v0);
                            v17 = v90;
                            v16 = v89;
                            v15 = v88;
                            v54 = v87;
                        } else if (!v5) {
                            v55 = v55 - v16;
                        };
                    };
                };
            };
        };
        if (v55 < v25) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5016)
        };
        if (v54 > v21) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5017)
        };
        let v91 = 0;
        let v92 = 0;
        let v93 = 0;
        let v94 = 0;
        if (v19 == 0 && v23 == 1) {
            let v95 = if (!arg8) {
                v54
            } else {
                v1
            };
            v1 = v95;
            v93 = v55;
            if (v5 && v11) {
                v92 = v15 + v16;
            } else if (v5 && !v11) {
                v94 = v15 + v16;
            } else if (!v5) {
                let v96 = if (arg8) {
                    v16
                } else {
                    0
                };
                v92 = v96;
                let v97 = if (arg8) {
                    0
                } else {
                    v16
                };
                v94 = v97;
            };
            let v98 = if (v94 > 0) {
                if (v5) {
                    !arg8
                } else {
                    false
                }
            } else {
                false
            };
            if (v98) {
                v93 = v55 - v94;
            };
            if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
                v94 = v94 + v56;
                v93 = v93 - v56;
            };
        } else if (v19 == 1 && v23 == 0) {
            let v99 = if (!arg8) {
                v54
            } else {
                v2
            };
            v2 = v99;
            v91 = v55;
            if (v5 && v11) {
                v92 = v15 + v16;
            } else if (v5 && !v11) {
                v94 = v15 + v16;
            } else if (!v5) {
                let v100 = if (arg8) {
                    v16
                } else {
                    0
                };
                v94 = v100;
                let v101 = if (!arg8) {
                    v16
                } else {
                    0
                };
                v92 = v101;
            };
            let v102 = if (v92 > 0) {
                if (v5) {
                    !arg8
                } else {
                    false
                }
            } else {
                false
            };
            if (v102) {
                v91 = v55 - v92;
            };
            if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
                v92 = v92 + v56;
                v91 = v91 - v56;
            };
        };
        (v1, v91, v92, v2, v93, v94, v15, v16, v17, 0)
    }

    public fun query_internal_swap_info<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &LiquidityPool<T0, T1, T2>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : SwapResultInfo {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = query_internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        SwapResultInfo{
            x_ret_offer_amt  : v0,
            x_return_amt     : v1,
            x_total_fee      : v2,
            y_ret_offer_amt  : v3,
            y_return_amt     : v4,
            y_total_fee      : v5,
            creator_fee_amt  : v6,
            amm_fee_amt      : v7,
            protocol_fee_amt : v8,
            error            : v9,
        }
    }

    public fun query_simulate_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &LiquidityPool<T0, T1, T2>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        query_internal_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun query_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &LiquidityPool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        query_internal_swap<T0, T1, T2>(arg0, arg1, arg2, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg2.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()), arg3, arg4, arg5, arg6, arg7)
    }

    public fun register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, true, arg3, true, arg4, 0x2::coin::get_decimals<T0>(arg5), 0x2::coin::get_decimals<T1>(arg6), arg7, arg8, arg9, arg10);
        v1
    }

    public fun register_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: vector<u64>, arg6: 0x1::option::Option<vector<u256>>, arg7: 0x1::option::Option<vector<u64>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, true, arg3, true, arg4, get_decimal_for_coin<T0>(arg1), get_decimal_for_coin<T1>(arg1), arg5, arg6, arg7, arg8);
        v1
    }

    public fun register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, true, arg3, true, arg4, 0x2::coin::get_decimals<T0>(arg5), get_decimal_for_coin<T1>(arg1), arg6, arg7, arg8, arg9);
        v1
    }

    public fun register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut PoolRegistry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: vector<u64>, arg7: 0x1::option::Option<vector<u256>>, arg8: 0x1::option::Option<vector<u64>>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, true, arg3, true, arg4, get_decimal_for_coin<T0>(arg1), 0x2::coin::get_decimals<T1>(arg5), arg6, arg7, arg8, arg9);
        v1
    }

    fun registry_add<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: bool) {
        if (arg4) {
            if (0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::curves::is_curved<T2>()) {
                assert!(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::valid_curved_coins_2_pool<T0, T1>(), 5005);
            } else {
                assert!(0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::coin_helper::is_sorted<T0, T1>(), 5006);
            };
        };
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::with_defining_ids<T0>(),
            b     : 0x1::type_name::with_defining_ids<T1>(),
            curve : 0x1::type_name::with_defining_ids<T2>(),
        };
        assert!(!0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0), 5002);
        0x2::linked_table::push_back<PoolRegistryItem, 0x2::object::ID>(&mut arg0.krafted_pools_list, v0, arg3);
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: 0x2::balance::Balance<LP<T0, T1, T2>>, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg2.module_version == 2, 5036);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 5047);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.supported_tokens_list, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), 5047);
        let v0 = 0x2::balance::value<LP<T0, T1, T2>>(&arg3);
        let (v1, v2, v3) = internal_remove_liquidity<T0, T1, T2>(arg1, arg2, v0, arg4, arg5);
        let v4 = v0 - v3;
        if (arg6 > 0) {
            assert!(v4 <= arg6, 5015);
        };
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg2.lp_supply, 0x2::balance::split<LP<T0, T1, T2>>(&mut arg3, v4));
        arg2.total_lp_krafted = arg2.total_lp_krafted - v4;
        (v1, v2, arg3)
    }

    public fun remove_liquidity_burn_tax<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        assert!(arg1.module_version == 2, 5036);
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

    public fun set_dynamic_fee_config(arg0: &AmmAdminCap, arg1: &mut PoolRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.module_version == 2, 5036);
        assert!(arg5 <= 300, 5049);
        let v0 = DynamicFeeConfig{
            start_range      : arg3,
            end_range        : arg4,
            creator_fee_bps  : arg5,
            amm_fee_bps      : arg6,
            protocol_fee_pct : arg7,
        };
        if (0x2::linked_table::contains<u64, DynamicFeeConfig>(&arg1.dynamic_fee_configs, arg2)) {
            *0x2::linked_table::borrow_mut<u64, DynamicFeeConfig>(&mut arg1.dynamic_fee_configs, arg2) = v0;
        } else {
            0x2::linked_table::push_back<u64, DynamicFeeConfig>(&mut arg1.dynamic_fee_configs, arg2, v0);
        };
        let v1 = DynamicFeeConfigUpdated{
            index            : arg2,
            start_range      : arg3,
            end_range        : arg4,
            creator_fee_bps  : arg5,
            amm_fee_bps      : arg6,
            protocol_fee_pct : arg7,
        };
        0x2::event::emit<DynamicFeeConfigUpdated>(v1);
    }

    fun store_creator_fees_ggsui<T0, T1, T2, T3, T4>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x1::ascii::String, arg2: 0x2::balance::Balance<T4>) {
        0x2::balance::join<T4>(&mut 0x2::dynamic_field::borrow_mut<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg0.id, arg1).ggsui_fees, arg2);
    }

    fun store_creator_fees_sui<T0, T1, T2, T3, T4>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x1::ascii::String, arg2: 0x2::balance::Balance<T3>) {
        0x2::balance::join<T3>(&mut 0x2::dynamic_field::borrow_mut<0x1::ascii::String, CollectedFees<T3, T4>>(&mut arg0.id, arg1).sui_fees, arg2);
    }

    public fun swap_with_tax<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &PoolRegistry, arg2: &mut LiquidityPool<T0, T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg2.is_locked, 5009);
        let (v0, v1, _, _) = internal_swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        (v0, v1)
    }

    public fun switch_buyback(arg0: &AmmAdminCap, arg1: &mut PoolRegistry) {
        arg1.is_buyback_enabled = !arg1.is_buyback_enabled;
    }

    public fun switch_swap_switch<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 2, 5036);
        arg0.is_swap_enabled = arg2;
    }

    fun update_cumulative_prices<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>) {
        let v0 = 9;
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
            arg1.cumulative_x_price = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::overflow_add_u256(arg1.cumulative_x_price, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v3 as u256), (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_10(v0) as u256), (v2 as u256)) * (v1 as u256));
            arg1.cumulative_y_price = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::overflow_add_u256(arg1.cumulative_y_price, 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v2 as u256), (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::pow_10(v0) as u256), (v3 as u256)) * (v1 as u256));
            arg1.last_timestamp = 0x2::clock::timestamp_ms(arg0);
        };
        let v5 = CumPriceUpdatedEventV2{
            type_x             : 0x1::type_name::with_defining_ids<T0>(),
            type_y             : 0x1::type_name::with_defining_ids<T1>(),
            type_curve         : 0x1::type_name::with_defining_ids<T2>(),
            id                 : 0x2::object::uid_to_inner(&arg1.id),
            cumulative_x_price : arg1.cumulative_x_price,
            cumulative_y_price : arg1.cumulative_y_price,
            timestamp          : arg1.last_timestamp,
        };
        0x2::event::emit<CumPriceUpdatedEventV2>(v5);
    }

    public fun update_curved_A_and_gamma<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(arg0.module_version == 2, 5036);
        assert!(0x1::option::is_some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::update_A_and_gamma(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5);
        let v0 = CurvedConfigUpdatedAmpEvent{
            type_x              : 0x1::type_name::with_defining_ids<T0>(),
            type_y              : 0x1::type_name::with_defining_ids<T1>(),
            type_curve          : 0x1::type_name::with_defining_ids<T2>(),
            id                  : 0x2::object::uid_to_inner(&arg0.id),
            init_A_gamma_time   : arg2,
            next_amp            : arg3,
            next_gamma          : arg4,
            future_A_gamma_time : arg5,
        };
        0x2::event::emit<CurvedConfigUpdatedAmpEvent>(v0);
    }

    public fun update_curved_config_fee_params<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg0.module_version == 2, 5036);
        assert!(0x1::option::is_some<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::update_config_fee_params(0x1::option::borrow_mut<0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurvedConfigUpdatedParamsEvent{
            type_x                   : 0x1::type_name::with_defining_ids<T0>(),
            type_y                   : 0x1::type_name::with_defining_ids<T1>(),
            type_curve               : 0x1::type_name::with_defining_ids<T2>(),
            id                       : 0x2::object::uid_to_inner(&arg0.id),
            new_mid_fee              : arg2,
            new_out_fee              : arg3,
            new_fee_gamma            : arg4,
            new_ma_half_time         : arg5,
            new_allowed_extra_profit : arg6,
            new_adjustment_step      : arg7,
        };
        0x2::event::emit<CurvedConfigUpdatedParamsEvent>(v0);
    }

    public fun update_kraft_fee(arg0: &mut PoolRegistry, arg1: &AmmAdminCap, arg2: u64) {
        assert!(arg0.module_version == 2, 5036);
        arg0.kraft_fee = arg2;
    }

    public fun update_pool_fee_info<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &AmmAdminCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) {
        assert!(arg0.module_version == 2, 5036);
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.fee_info.total_fee_bps = *0x1::option::borrow<u64>(&arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.fee_info.protocol_fee_pct = *0x1::option::borrow<u64>(&arg3);
        };
        let v0 = PoolFeeInfoUpdated{
            total_fee_bps    : arg0.fee_info.total_fee_bps,
            protocol_fee_pct : arg0.fee_info.protocol_fee_pct,
        };
        0x2::event::emit<PoolFeeInfoUpdated>(v0);
    }

    public fun use_sui_for_buybacks<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0>) {
        use_sui_for_yield_farm<T0, T1, T2>(arg0, arg1, arg2, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::extract_fee_for_coin<0x2::sui::SUI>(&arg0.fee_claim_cap, arg3), arg4);
    }

    fun use_sui_for_yield_farm<T0, T1, T2>(arg0: &PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0>) {
        assert!(arg0.module_version == 2 && arg4.module_version == 2, 5035);
        assert!(arg0.is_buyback_enabled, 5044);
        assert!(arg0.sui_honey_pool_addr == 0x2::object::uid_to_address(&arg4.id), 5045);
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) > 0) {
            let (v0, _) = 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::get_sui_fee_distribution_info(arg2);
            let v2 = 0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg3), v0, 100);
            0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::add_to_treasury(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v2));
            let (v3, v4, _, _) = internal_swap<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T0, T1, T2>(arg1, arg0, arg4, arg3, 0, 0x2::balance::zero<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(), 1, true);
            let v7 = v4;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::add_honey_bought_back(arg2, v7);
            let v8 = SuiForYieldFarm{
                sui_for_treasury      : v2,
                sui_for_honey_buyback : 0x2::balance::value<0x2::sui::SUI>(&arg3) - v2,
                honey_bought_amt      : 0x2::balance::value<0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY>(&v7),
            };
            0x2::event::emit<SuiForYieldFarm>(v8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public fun use_x_for_buybacks_via_sui_x_pool<T0, T1, T2, T3, T4>(arg0: &mut PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>, arg5: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>) {
        let (v0, v1, _, _) = internal_swap<0x2::sui::SUI, T0, T1, T3, T4>(arg1, arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::extract_fee_for_coin<T0>(&arg0.fee_claim_cap, arg5), 0, true);
        0x2::balance::destroy_zero<T0>(v1);
        use_sui_for_yield_farm<T2, T3, T4>(arg0, arg1, arg2, v0, arg4);
    }

    public fun use_x_for_buybacks_via_x_sui_pool<T0, T1, T2, T3, T4>(arg0: &mut PoolRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::HoneyYield, arg3: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg4: &mut LiquidityPool<0x2::sui::SUI, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey::HONEY, T2>, arg5: &mut 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::FeeCollector<T0>) {
        let (v0, v1, _, _) = internal_swap<T0, 0x2::sui::SUI, T1, T3, T4>(arg1, arg0, arg3, 0xe40c3d6a24938abb6c01a8801b46b26cc449c78ae5e0a64b6c61a157498d0be::honey_yield::extract_fee_for_coin<T0>(&arg0.fee_claim_cap, arg5), 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        0x2::balance::destroy_zero<T0>(v0);
        use_sui_for_yield_farm<T2, T3, T4>(arg0, arg1, arg2, v1, arg4);
    }

    // decompiled from Move bytecode v6
}

