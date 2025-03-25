module 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::lp_pool {
    struct Registry has key {
        id: 0x2::object::UID,
        num_pool: u64,
        liquidity_pool_registry: 0x2::object::UID,
    }

    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        liquidity_tokens: vector<0x1::type_name::TypeName>,
        token_pools: vector<TokenPool>,
        pool_info: LiquidityPoolInfo,
        liquidated_unsettled_receipts: vector<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct TokenPool has store {
        token_type: 0x1::type_name::TypeName,
        config: Config,
        state: State,
    }

    struct LiquidityPoolInfo has copy, drop, store {
        lp_token_decimal: u64,
        total_share_supply: u64,
        tvl_usd: u64,
        is_active: bool,
    }

    struct Config has copy, drop, store {
        oracle_id: address,
        liquidity_token_decimal: u64,
        spot_config: SpotConfig,
        margin_config: MarginConfig,
        u64_padding: vector<u64>,
    }

    struct SpotConfig has copy, drop, store {
        min_deposit: u64,
        max_capacity: u64,
        target_weight_bp: u64,
        basic_mint_fee_bp: u64,
        additional_mint_fee_bp: u64,
        basic_burn_fee_bp: u64,
        additional_burn_fee_bp: u64,
        swap_fee_bp: u64,
        swap_fee_protocol_share_bp: u64,
        lending_protocol_share_bp: u64,
        u64_padding: vector<u64>,
    }

    struct MarginConfig has copy, drop, store {
        basic_borrow_rate_0: u64,
        basic_borrow_rate_1: u64,
        basic_borrow_rate_2: u64,
        utilization_threshold_bp_0: u64,
        utilization_threshold_bp_1: u64,
        borrow_interval_ts_ms: u64,
        max_order_reserve_ratio_bp: u64,
        u64_padding: vector<u64>,
    }

    struct State has copy, drop, store {
        liquidity_amount: u64,
        value_in_usd: u64,
        reserved_amount: u64,
        update_ts_ms: u64,
        is_active: bool,
        last_borrow_rate_ts_ms: u64,
        cumulative_borrow_rate: u64,
        previous_last_borrow_rate_ts_ms: u64,
        previous_cumulative_borrow_rate: u64,
        current_lending_amount: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct RemoveLiquidityTokenProcess {
        liquidity_token: 0x1::type_name::TypeName,
        removed_positions_base_token: vector<0x1::type_name::TypeName>,
        removed_orders_base_token: vector<0x1::type_name::TypeName>,
        removed_token_oracle_id: address,
        removed_usd: u64,
        repaid_usd: u64,
        status: u64,
    }

    struct NewLiquidityPoolEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        lp_token_decimal: u64,
        u64_padding: vector<u64>,
    }

    struct AddLiquidityTokenEvent has copy, drop {
        sender: address,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        config: Config,
        state: State,
        u64_padding: vector<u64>,
    }

    struct UpdateSpotConfigEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        previous_spot_config: SpotConfig,
        new_spot_config: SpotConfig,
        u64_padding: vector<u64>,
    }

    struct UpdateMarginConfigEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        previous_margin_config: MarginConfig,
        new_margin_config: MarginConfig,
        u64_padding: vector<u64>,
    }

    struct MintLpEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_amount_usd: u64,
        mint_fee_usd: u64,
        lp_token_type: 0x1::type_name::TypeName,
        minted_lp_amount: u64,
        u64_padding: vector<u64>,
    }

    struct BurnLpEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        burn_lp_amount: u64,
        burn_amount_usd: u64,
        burn_fee_usd: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        withdraw_token_amount: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateBorrowInfoEvent has copy, drop {
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        previous_borrow_ts_ms: u64,
        previous_cumulative_borrow_rate: u64,
        borrow_interval_ts_ms: u64,
        last_borrow_rate_ts_ms: u64,
        last_cumulative_borrow_rate: u64,
        u64_padding: vector<u64>,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        index: u64,
        from_token_type: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token_type: 0x1::type_name::TypeName,
        min_to_amount: u64,
        actual_to_amount: u64,
        fee_amount: u64,
        fee_amount_usd: u64,
        oracle_price_from_token: u64,
        oracle_price_to_token: u64,
        u64_padding: vector<u64>,
    }

    struct SuspendPoolEvent has copy, drop {
        sender: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct ResumePoolEvent has copy, drop {
        sender: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct SuspendTokenPoolEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct ResumeTokenPoolEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct DepositScallopEvent has copy, drop {
        index: u64,
        token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        minted_market_coin_amount: u64,
        latest_lending_amount: u64,
        latest_market_coin_amount: u64,
        latest_reserved_amount: u64,
        latest_liquidity_amount: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawScallopEvent has copy, drop {
        index: u64,
        token_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        withdrawn_collateral_amount: u64,
        latest_lending_amount: u64,
        latest_market_coin_amount: u64,
        latest_reserved_amount: u64,
        latest_liquidity_amount: u64,
        lending_interest: u64,
        protocol_share: u64,
        u64_padding: vector<u64>,
    }

    struct StartRemoveLiquidityTokenProcessEvent has copy, drop {
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct ManagerFlashRemoveLiquidityEvent has copy, drop {
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        price: u64,
        price_decimal: u64,
        remove_amount: u64,
        removed_usd: u64,
        u64_padding: vector<u64>,
    }

    struct ManagerFlashRepayLiquidityEvent has copy, drop {
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        price: u64,
        price_decimal: u64,
        repaid_amount: u64,
        repaid_usd: u64,
        u64_padding: vector<u64>,
    }

    struct CompleteRemoveLiquidityTokenProcessEvent has copy, drop {
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        removed_usd: u64,
        repaid_usd: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateLiquidityValueEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        price: u64,
        value_in_usd: u64,
        lp_pool_tvl_usd: u64,
        u64_padding: vector<u64>,
    }

    public fun swap<T0, T1>(arg0: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        update_borrow_info(arg0, arg1, arg2, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg7, 0);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg7, 0);
        let v5 = 0x2::coin::value<T0>(&arg5);
        let v6 = 0x1::type_name::get<T0>();
        let v7 = 0x1::type_name::get<T1>();
        let v8 = get_mut_token_pool(v0, &v6);
        let v9 = v8.config;
        let v10 = get_mut_token_pool(v0, &v7);
        let v11 = v10.config;
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v9.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v11.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        let v12 = get_mut_token_pool(v0, &v6);
        let v13 = v12.state;
        let v14 = get_mut_token_pool(v0, &v7);
        let v15 = v14.state;
        assert!(v13.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        assert!(v15.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        let v16 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v5, v9.liquidity_token_decimal, v1, v2);
        let (v17, v18) = calculate_swap_fee(v0, v6, v5, v16, true);
        let (_, v20) = calculate_swap_fee(v0, v7, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v16, v11.liquidity_token_decimal, v3, v4), v16, false);
        let (v21, v22) = if (v18 > v20) {
            (v17, v18)
        } else {
            (0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v20, v9.liquidity_token_decimal, v1, v2), v20)
        };
        let v23 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v16 - v22, v11.liquidity_token_decimal, v3, v4);
        assert!(v23 >= arg6, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::reach_slippage_threshold());
        let v24 = get_mut_token_pool(v0, &v6);
        let v25 = 0x2::coin::into_balance<T0>(arg5);
        let v26 = 0x2::balance::value<T0>(&v25);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v25, (((v21 as u128) * (v24.config.spot_config.swap_fee_protocol_share_bp as u128) / 10000) as u64)));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v6), v25);
        let v27 = get_mut_token_pool(v0, &v6);
        assert!(v27.state.liquidity_amount + v26 <= v27.config.spot_config.max_capacity, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::reach_max_capacity());
        v27.state.liquidity_amount = v27.state.liquidity_amount + v26;
        update_tvl(arg0, v0, v6, arg3, arg7);
        let v28 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.id, v7), v23);
        let v29 = get_mut_token_pool(v0, &v7);
        v29.state.liquidity_amount = v29.state.liquidity_amount - 0x2::balance::value<T1>(&v28);
        assert!(v29.state.liquidity_amount >= v29.state.reserved_amount, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_not_enough());
        update_tvl(arg0, v0, v7, arg4, arg7);
        let v30 = SwapEvent{
            sender                  : 0x2::tx_context::sender(arg8),
            index                   : arg2,
            from_token_type         : v6,
            from_amount             : v5,
            to_token_type           : v7,
            min_to_amount           : arg6,
            actual_to_amount        : v23,
            fee_amount              : v21,
            fee_amount_usd          : v22,
            oracle_price_from_token : v1,
            oracle_price_to_token   : v3,
            u64_padding             : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SwapEvent>(v30);
        0x2::coin::from_balance<T1>(v28, arg8)
    }

    fun deposit_scallop_basic<T0>(arg0: &mut LiquidityPool, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg4);
        let v2 = get_mut_token_pool(arg0, &v0);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::set_u64_vector_value(&mut v2.state.current_lending_amount, 0, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v2.state.current_lending_amount, 0) + 0x2::balance::value<T0>(&v1));
        let (v3, v4) = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::lending::deposit_scallop_basic<T0>(v1, arg1, arg2, arg3, arg5);
        let v5 = v4;
        let v6 = 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v6)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v6), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v3));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v6, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v3));
        };
        let v7 = get_token_pool(arg0, &v0);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v7.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v6)));
        0x1::vector::push_back<u64>(v9, v7.state.reserved_amount);
        0x1::vector::push_back<u64>(v9, v7.state.liquidity_amount);
        0x1::vector::append<u64>(&mut v5, v8);
        v5
    }

    fun withdraw_scallop_basic<T0>(arg0: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut LiquidityPool, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        let (v1, v2) = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::lending::withdraw_scallop_basic<T0>(0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg1.id, v0), arg5), arg6), arg2, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::type_name::get<T0>();
        let v6 = get_token_pool(arg1, &v5);
        let v7 = (((0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v6.state.current_lending_amount, 0) as u128) * (arg5 as u128) / (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0)) as u128)) as u64);
        let v8 = if (0x2::balance::value<T0>(&v4) >= v7) {
            0x2::balance::value<T0>(&v4) - v7
        } else {
            0
        };
        let v9 = (((v8 as u128) * (v6.config.spot_config.lending_protocol_share_bp as u128) / 10000) as u64);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v4, v9));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v5), v4);
        let v10 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.id, v5));
        let v11 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0));
        let v12 = get_mut_token_pool(arg1, &v5);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::set_u64_vector_value(&mut v12.state.current_lending_amount, 0, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v12.state.current_lending_amount, 0) - v7);
        v12.state.liquidity_amount = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v12.state.current_lending_amount, 0) + 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v12.state.current_lending_amount, 1) + v10;
        let v13 = 0x1::vector::empty<u64>();
        let v14 = &mut v13;
        0x1::vector::push_back<u64>(v14, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v12.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v14, v11);
        0x1::vector::push_back<u64>(v14, v12.state.reserved_amount);
        0x1::vector::push_back<u64>(v14, v12.state.liquidity_amount);
        0x1::vector::push_back<u64>(v14, v8);
        0x1::vector::push_back<u64>(v14, v9);
        0x1::vector::append<u64>(&mut v3, v13);
        v3
    }

    entry fun add_liquidity_token<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg23);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.liquidity_tokens, v1);
            let v2 = SpotConfig{
                min_deposit                : arg6,
                max_capacity               : arg7,
                target_weight_bp           : arg5,
                basic_mint_fee_bp          : arg8,
                additional_mint_fee_bp     : arg9,
                basic_burn_fee_bp          : arg10,
                additional_burn_fee_bp     : arg11,
                swap_fee_bp                : arg12,
                swap_fee_protocol_share_bp : arg13,
                lending_protocol_share_bp  : arg14,
                u64_padding                : 0x1::vector::empty<u64>(),
            };
            let v3 = MarginConfig{
                basic_borrow_rate_0        : arg15,
                basic_borrow_rate_1        : arg16,
                basic_borrow_rate_2        : arg17,
                utilization_threshold_bp_0 : arg18,
                utilization_threshold_bp_1 : arg19,
                borrow_interval_ts_ms      : arg20,
                max_order_reserve_ratio_bp : arg21,
                u64_padding                : 0x1::vector::empty<u64>(),
            };
            let v4 = Config{
                oracle_id               : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3),
                liquidity_token_decimal : arg4,
                spot_config             : v2,
                margin_config           : v3,
                u64_padding             : 0x1::vector::empty<u64>(),
            };
            let v5 = 0x2::clock::timestamp_ms(arg22);
            let v6 = State{
                liquidity_amount                : 0,
                value_in_usd                    : 0,
                reserved_amount                 : 0,
                update_ts_ms                    : v5,
                is_active                       : true,
                last_borrow_rate_ts_ms          : v5,
                cumulative_borrow_rate          : 0,
                previous_last_borrow_rate_ts_ms : v5,
                previous_cumulative_borrow_rate : 0,
                current_lending_amount          : 0x1::vector::empty<u64>(),
                u64_padding                     : 0x1::vector::empty<u64>(),
            };
            let v7 = TokenPool{
                token_type : v1,
                config     : v4,
                state      : v6,
            };
            0x1::vector::push_back<TokenPool>(&mut v0.token_pools, v7);
            if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v0.id, v1)) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v1, 0x2::balance::zero<T0>());
            };
            let v8 = AddLiquidityTokenEvent{
                sender      : 0x2::tx_context::sender(arg23),
                index       : arg2,
                token_type  : v1,
                config      : v4,
                state       : v6,
                u64_padding : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<AddLiquidityTokenEvent>(v8);
        };
    }

    public fun burn_lp<T0, T1>(arg0: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::treasury_caps::TreasuryCaps, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let v3 = 0x2::coin::into_balance<T1>(arg5);
        let v4 = 0x2::balance::value<T1>(&v3);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let v5 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::get<T1>() == v5.lp_token_type, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::lp_token_type_mismatched());
        assert!(v5.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        assert!(check_tvl_updated(v5, arg6), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::tvl_not_yet_updated());
        let v6 = get_token_pool(v5, &v0);
        assert!(v6.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v6.config.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        update_borrow_info(arg0, arg1, arg2, arg6);
        let (v7, v8, v9, v10) = calculate_burn_lp(arg1, arg2, v0, v1, v2, v4);
        let v11 = get_mut_liquidity_pool(arg1, arg2);
        let v12 = get_mut_token_pool(v11, &v0);
        v12.state.liquidity_amount = v12.state.liquidity_amount - v9 - v10;
        assert!(v12.state.liquidity_amount >= v12.state.reserved_amount, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_not_enough());
        let v13 = get_mut_liquidity_pool(arg1, arg2);
        v13.pool_info.total_share_supply = v13.pool_info.total_share_supply - v4;
        update_tvl(arg0, v13, v0, arg4, arg6);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::token_interface::burn<T1>(0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::treasury_caps::get_mut_treasury_cap<T1>(arg3), 0x2::coin::from_balance<T1>(v3, arg7));
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v13.id, v0), v10));
        let v14 = BurnLpEvent{
            sender                : 0x2::tx_context::sender(arg7),
            index                 : arg2,
            lp_token_type         : v13.lp_token_type,
            burn_lp_amount        : v4,
            burn_amount_usd       : v7,
            burn_fee_usd          : v8,
            liquidity_token_type  : v0,
            withdraw_token_amount : v9,
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<BurnLpEvent>(v14);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v13.id, v0), v9), arg7)
    }

    public(friend) fun calculate_burn_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = get_token_pool(v0, &arg2);
        assert!(v0.pool_info.total_share_supply > 0, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::zero_total_supply());
        let v2 = (((arg5 as u128) * (v0.pool_info.tvl_usd as u128) / (v0.pool_info.total_share_supply as u128)) as u64);
        let v3 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v2, v1.config.liquidity_token_decimal, arg3, arg4);
        let (v4, v5) = calculate_lp_fee(v0, arg2, v3, v2, false);
        (v2, v5, v3 - v4, v4)
    }

    public(friend) fun calculate_lp_fee(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = get_token_pool(arg0, &arg1);
        let v1 = v0.config.spot_config;
        let v2 = v0.state.value_in_usd;
        let v3 = if (arg0.pool_info.tvl_usd > 0) {
            (((arg0.pool_info.tvl_usd as u128) * (v1.target_weight_bp as u128) / 10000) as u64)
        } else {
            0
        };
        let v4 = if (v3 > v2) {
            v3 - v2
        } else {
            v2 - v3
        };
        let v5 = if (arg4) {
            v2 + arg3
        } else {
            assert!(v2 >= arg3, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_not_enough());
            v2 - arg3
        };
        let v6 = if (v3 > v5) {
            v3 - v5
        } else {
            v5 - v3
        };
        let v7 = if (arg4) {
            v1.basic_mint_fee_bp
        } else {
            v1.basic_burn_fee_bp
        };
        let v8 = if (arg4) {
            v1.additional_mint_fee_bp
        } else {
            v1.additional_burn_fee_bp
        };
        let v9 = if (v6 > v4) {
            if (v3 == 0) {
                v7
            } else {
                (((v8 as u128) * ((v6 + v4) as u128) / 2 / (v3 as u128)) as u64)
            }
        } else {
            0
        };
        let v10 = if (v9 > v7) {
            v7
        } else {
            v9
        };
        let v11 = v7 + v10;
        ((((arg2 as u128) * (v11 as u128) / 10000) as u64), (((arg3 as u128) * (v11 as u128) / 10000) as u64))
    }

    public(friend) fun calculate_mint_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(arg5, get_token_pool(v0, &arg2).config.liquidity_token_decimal, arg3, arg4);
        let (_, v3) = calculate_lp_fee(v0, arg2, arg5, v1, true);
        assert!(v1 >= v3, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::insufficient_amount_for_mint_fee());
        let v4 = if (v0.pool_info.tvl_usd > 0) {
            ((((v1 - v3) as u128) * (v0.pool_info.total_share_supply as u128) / (v0.pool_info.tvl_usd as u128)) as u64)
        } else {
            v1 - v3
        };
        (v1, v3, v4)
    }

    fun calculate_swap_fee(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = get_token_pool(arg0, &arg1);
        let v1 = v0.config.spot_config;
        let v2 = v0.state.value_in_usd;
        let v3 = (((arg0.pool_info.tvl_usd as u128) * (v1.target_weight_bp as u128) / 10000) as u64);
        let v4 = if (v3 > v2) {
            v3 - v2
        } else {
            v2 - v3
        };
        let v5 = if (arg4) {
            v2 + arg3
        } else {
            assert!(v2 >= arg3, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_not_enough());
            v2 - arg3
        };
        let v6 = if (v3 > v5) {
            v3 - v5
        } else {
            v5 - v3
        };
        let v7 = v1.swap_fee_bp;
        let v8 = if (v6 > v4) {
            (((v1.swap_fee_bp as u128) * ((v6 + v4) as u128) / 2 / (v3 as u128)) as u64)
        } else {
            0
        };
        let v9 = if (v8 > v7) {
            v7
        } else {
            v8
        };
        let v10 = v7 + v9;
        ((((arg2 as u128) * (v10 as u128) / 10000) as u64), (((arg3 as u128) * (v10 as u128) / 10000) as u64))
    }

    public(friend) fun check_remove_liquidity_token_process_status(arg0: &RemoveLiquidityTokenProcess, arg1: u64) {
        let v0 = if (arg0.status == 0) {
            0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::process_should_remove_position()
        } else if (arg0.status == 1) {
            0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::process_should_remove_order()
        } else if (arg0.status == 2) {
            0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::process_should_swap()
        } else {
            assert!(arg0.status == 3, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::unsupported_process_status_code());
            0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::process_should_repay_liquidity()
        };
        assert!(arg0.status == arg1, v0);
    }

    public(friend) fun check_token_pool_status<T0>(arg0: &Registry, arg1: u64, arg2: bool) {
        let v0 = 0x1::type_name::get<T0>();
        if (arg2) {
            assert!(get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        } else {
            assert!(!get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_already_active());
        };
    }

    public(friend) fun check_trading_order_size_valid(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        let v0 = get_token_pool(arg0, &arg1);
        (((v0.state.liquidity_amount as u128) * (v0.config.margin_config.max_order_reserve_ratio_bp as u128) / 10000) as u64) >= arg2
    }

    fun check_tvl_updated(arg0: &LiquidityPool, arg1: &0x2::clock::Clock) : bool {
        let v0 = arg0.liquidity_tokens;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v0) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            if (get_token_pool(arg0, &v1).state.update_ts_ms < 0x2::clock::timestamp_ms(arg1)) {
                return false
            };
        };
        true
    }

    public fun complete_remove_liquidity_token_process<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: RemoveLiquidityTokenProcess, arg4: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg4);
        check_token_pool_status<T0>(arg1, arg2, false);
        check_remove_liquidity_token_process_status(&arg3, 3);
        let v0 = false;
        if (arg3.repaid_usd <= arg3.removed_usd) {
            if (arg3.removed_usd > 0) {
                if (((((arg3.removed_usd - arg3.repaid_usd) as u128) * 10000 / (arg3.removed_usd as u128)) as u64) < 200) {
                    v0 = true;
                };
            };
        } else {
            v0 = true;
        };
        assert!(v0, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::friction_too_large());
        let RemoveLiquidityTokenProcess {
            liquidity_token              : _,
            removed_positions_base_token : _,
            removed_orders_base_token    : _,
            removed_token_oracle_id      : _,
            removed_usd                  : v5,
            repaid_usd                   : v6,
            status                       : _,
        } = arg3;
        let v8 = 0x1::type_name::get<T0>();
        let v9 = get_mut_liquidity_pool(arg1, arg2);
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9.id, 0x1::type_name::get<T0>()));
        let (_, v11) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v9.liquidity_tokens, &v8);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut v9.liquidity_tokens, v11);
        let v12 = 0;
        while (v12 < 0x1::vector::length<TokenPool>(&v9.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&v9.token_pools, v12).token_type == v8) {
                break
            };
            v12 = v12 + 1;
        };
        let TokenPool {
            token_type : _,
            config     : _,
            state      : _,
        } = 0x1::vector::remove<TokenPool>(&mut v9.token_pools, v12);
        let v16 = CompleteRemoveLiquidityTokenProcessEvent{
            index           : arg2,
            liquidity_token : v8,
            removed_usd     : v5,
            repaid_usd      : v6,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CompleteRemoveLiquidityTokenProcessEvent>(v16);
    }

    public(friend) fun get_borrow_rate_decimal() : u64 {
        9
    }

    public(friend) fun get_cumulative_borrow_rate(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        get_token_pool(arg0, &arg1).state.cumulative_borrow_rate
    }

    public(friend) fun get_expired_receipt_collateral_bcs(arg0: &Registry, arg1: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &get_liquidity_pool(arg0, arg2).liquidated_unsettled_receipts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(v1)) {
            let v3 = 0x1::vector::borrow<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(v1, v2);
            let v4 = true;
            let v5 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::get_bid_receipts(v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v5)) {
                if (!0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg1, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v5, v6))) {
                    v4 = false;
                };
                v6 = v6 + 1;
            };
            if (v4) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(v3));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun get_liquidity_amount(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName) : u64 {
        get_token_pool(get_liquidity_pool(arg0, arg1), &arg2).state.liquidity_amount
    }

    public(friend) fun get_liquidity_pool(arg0: &Registry, arg1: u64) : &LiquidityPool {
        0x2::dynamic_object_field::borrow<u64, LiquidityPool>(&arg0.liquidity_pool_registry, arg1)
    }

    public(friend) fun get_liquidity_token_decimal(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName) : u64 {
        get_token_pool(get_liquidity_pool(arg0, arg1), &arg2).config.liquidity_token_decimal
    }

    public(friend) fun get_lp_token_type(arg0: &Registry, arg1: u64) : 0x1::type_name::TypeName {
        get_liquidity_pool(arg0, arg1).lp_token_type
    }

    public(friend) fun get_mut_liquidity_pool(arg0: &mut Registry, arg1: u64) : &mut LiquidityPool {
        0x2::dynamic_object_field::borrow_mut<u64, LiquidityPool>(&mut arg0.liquidity_pool_registry, arg1)
    }

    public(friend) fun get_mut_token_pool(arg0: &mut LiquidityPool, arg1: &0x1::type_name::TypeName) : &mut TokenPool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0).token_type == *arg1) {
                return 0x1::vector::borrow_mut<TokenPool>(&mut arg0.token_pools, v0)
            };
            v0 = v0 + 1;
        };
        abort 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed()
    }

    public(friend) fun get_receipt_collateral(arg0: &mut LiquidityPool) : vector<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt> {
        let v0 = 0x1::vector::empty<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>();
        while (0x1::vector::length<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(&arg0.liquidated_unsettled_receipts) > 0) {
            0x1::vector::push_back<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(&mut v0, 0x1::vector::pop_back<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(&mut arg0.liquidated_unsettled_receipts));
        };
        v0
    }

    public(friend) fun get_receipt_collateral_bcs(arg0: &Registry, arg1: u64) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &get_liquidity_pool(arg0, arg1).liquidated_unsettled_receipts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(v1)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(0x1::vector::borrow<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun get_remove_liquidity_token_process_token(arg0: &RemoveLiquidityTokenProcess, arg1: bool) : vector<0x1::type_name::TypeName> {
        if (arg1) {
            arg0.removed_positions_base_token
        } else {
            arg0.removed_orders_base_token
        }
    }

    public(friend) fun get_token_pool(arg0: &LiquidityPool, arg1: &0x1::type_name::TypeName) : &TokenPool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0).token_type == *arg1) {
                return 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0)
            };
            v0 = v0 + 1;
        };
        abort 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed()
    }

    public(friend) fun get_token_pool_state(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : vector<u64> {
        let v0 = get_token_pool(arg0, &arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.state.liquidity_amount);
        0x1::vector::push_back<u64>(v2, v0.state.value_in_usd);
        0x1::vector::push_back<u64>(v2, v0.state.reserved_amount);
        0x1::vector::push_back<u64>(v2, v0.state.update_ts_ms);
        0x1::vector::push_back<u64>(v2, v0.state.last_borrow_rate_ts_ms);
        0x1::vector::push_back<u64>(v2, v0.state.cumulative_borrow_rate);
        v1
    }

    public(friend) fun get_tvl_usd(arg0: &LiquidityPool) : u64 {
        arg0.pool_info.tvl_usd
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                      : 0x2::object::new(arg0),
            num_pool                : 0,
            liquidity_pool_registry : 0x2::object::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    entry fun manager_deposit_scallop<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_already_active());
        let v3 = v2.state.liquidity_amount - v2.state.reserved_amount;
        let v4 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v2.state.current_lending_amount, 0) + 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::get_u64_vector_value(&v2.state.current_lending_amount, 1);
        let v5 = if (v3 >= v4) {
            v3 - v4
        } else {
            0
        };
        let v6 = if (0x1::option::is_none<u64>(&arg6)) {
            v5
        } else {
            let v7 = 0x1::option::extract<u64>(&mut arg6);
            if (v5 >= v7) {
                v7
            } else {
                v5
            }
        };
        if (v6 > 0) {
            let v8 = deposit_scallop_basic<T0>(v0, arg3, arg4, arg5, v6, arg7);
            let v9 = DepositScallopEvent{
                index                     : arg2,
                token_type                : 0x1::type_name::get<T0>(),
                deposit_amount            : *0x1::vector::borrow<u64>(&v8, 0),
                minted_market_coin_amount : *0x1::vector::borrow<u64>(&v8, 1),
                latest_lending_amount     : *0x1::vector::borrow<u64>(&v8, 2),
                latest_market_coin_amount : *0x1::vector::borrow<u64>(&v8, 3),
                latest_reserved_amount    : *0x1::vector::borrow<u64>(&v8, 4),
                latest_liquidity_amount   : *0x1::vector::borrow<u64>(&v8, 5),
                u64_padding               : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<DepositScallopEvent>(v9);
        };
    }

    public fun manager_flash_remove_liquidity<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: RemoveLiquidityTokenProcess, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, RemoveLiquidityTokenProcess) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg6);
        check_token_pool_status<T0>(arg1, arg2, false);
        check_remove_liquidity_token_process_status(&arg4, 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_mut_liquidity_pool(arg1, arg2);
        let v2 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, v0));
        let v3 = get_mut_token_pool(v1, &v0);
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v3.config.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        v3.state.liquidity_amount = v3.state.liquidity_amount - v2;
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg5, 0);
        arg4.removed_usd = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v2, v3.config.liquidity_token_decimal, v4, v5);
        let v6 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), v2);
        let v7 = &mut arg4;
        update_remove_liquidity_token_process_status(v7, 3);
        update_tvl(arg0, v1, v0, arg3, arg5);
        let v8 = ManagerFlashRemoveLiquidityEvent{
            index           : arg2,
            liquidity_token : v0,
            price           : v4,
            price_decimal   : v5,
            remove_amount   : v2,
            removed_usd     : arg4.removed_usd,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerFlashRemoveLiquidityEvent>(v8);
        (v6, arg4)
    }

    public fun manager_flash_repay_liquidity<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: RemoveLiquidityTokenProcess, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : RemoveLiquidityTokenProcess {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg7);
        check_remove_liquidity_token_process_status(&arg4, 3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_mut_liquidity_pool(arg1, arg2);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = get_mut_token_pool(v1, &v2);
        assert!(v3.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v3.config.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        let v4 = 0x2::balance::value<T0>(&arg5);
        v3.state.liquidity_amount = v3.state.liquidity_amount + v4;
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        let v7 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v4, v3.config.liquidity_token_decimal, v5, v6);
        let v8 = ManagerFlashRepayLiquidityEvent{
            index           : arg2,
            liquidity_token : v0,
            price           : v5,
            price_decimal   : v6,
            repaid_amount   : v4,
            repaid_usd      : v7,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerFlashRepayLiquidityEvent>(v8);
        arg4.repaid_usd = arg4.repaid_usd + v7;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), arg5);
        update_tvl(arg0, v1, v0, arg3, arg6);
        arg4
    }

    entry fun manager_withdraw_scallop<T0>(arg0: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_already_active());
        let v3 = if (0x1::option::is_none<u64>(&arg6)) {
            0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v0.id, 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>()))
        } else {
            0x1::option::extract<u64>(&mut arg6)
        };
        if (v3 > 0) {
            let v4 = withdraw_scallop_basic<T0>(arg0, v0, arg3, arg4, arg5, v3, arg7);
            let v5 = WithdrawScallopEvent{
                index                       : arg2,
                token_type                  : 0x1::type_name::get<T0>(),
                withdraw_amount             : *0x1::vector::borrow<u64>(&v4, 0),
                withdrawn_collateral_amount : *0x1::vector::borrow<u64>(&v4, 1),
                latest_lending_amount       : *0x1::vector::borrow<u64>(&v4, 2),
                latest_market_coin_amount   : *0x1::vector::borrow<u64>(&v4, 3),
                latest_reserved_amount      : *0x1::vector::borrow<u64>(&v4, 4),
                latest_liquidity_amount     : *0x1::vector::borrow<u64>(&v4, 5),
                lending_interest            : *0x1::vector::borrow<u64>(&v4, 6),
                protocol_share              : *0x1::vector::borrow<u64>(&v4, 7),
                u64_padding                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<WithdrawScallopEvent>(v5);
        };
    }

    public fun mint_lp<T0, T1>(arg0: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: &mut 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::treasury_caps::TreasuryCaps, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        let v3 = 0x2::coin::into_balance<T0>(arg5);
        let v4 = 0x2::balance::value<T0>(&v3);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let v5 = get_liquidity_pool(arg1, arg4);
        assert!(0x1::type_name::get<T1>() == v5.lp_token_type, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::lp_token_type_mismatched());
        assert!(v5.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        assert!(check_tvl_updated(v5, arg6), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::tvl_not_yet_updated());
        let v6 = get_token_pool(v5, &v0);
        assert!(v4 >= v6.config.spot_config.min_deposit, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::deposit_amount_insufficient());
        assert!(v6.state.liquidity_amount + v4 <= v6.config.spot_config.max_capacity, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::reach_max_capacity());
        assert!(v6.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v6.config.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        update_borrow_info(arg0, arg1, arg4, arg6);
        let (v7, v8, v9) = calculate_mint_lp(arg1, arg4, v0, v1, v2, v4);
        let v10 = get_mut_liquidity_pool(arg1, arg4);
        v10.pool_info.total_share_supply = v10.pool_info.total_share_supply + v9;
        let v11 = 0x2::balance::split<T0>(&mut v3, (((v4 as u128) * (v8 as u128) / (v7 as u128)) as u64));
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::charge_fee<T0>(arg0, v11);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10.id, v0), v3);
        let v12 = get_mut_token_pool(v10, &v0);
        v12.state.liquidity_amount = v12.state.liquidity_amount + v4 - 0x2::balance::value<T0>(&v11);
        update_tvl(arg0, v10, v0, arg3, arg6);
        let v13 = MintLpEvent{
            sender               : 0x2::tx_context::sender(arg7),
            index                : arg4,
            liquidity_token_type : v0,
            deposit_amount       : v4,
            deposit_amount_usd   : v7,
            mint_fee_usd         : v8,
            lp_token_type        : v10.lp_token_type,
            minted_lp_amount     : v9,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<MintLpEvent>(v13);
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::token_interface::mint<T1>(0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::treasury_caps::get_mut_treasury_cap<T1>(arg2), v9, arg7)
    }

    entry fun new_liquidity_pool<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg3);
        let v0 = LiquidityPoolInfo{
            lp_token_decimal   : arg2,
            total_share_supply : 0,
            tvl_usd            : 0,
            is_active          : true,
        };
        let v1 = LiquidityPool{
            id                            : 0x2::object::new(arg3),
            index                         : arg1.num_pool,
            lp_token_type                 : 0x1::type_name::get<T0>(),
            liquidity_tokens              : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_pools                   : 0x1::vector::empty<TokenPool>(),
            pool_info                     : v0,
            liquidated_unsettled_receipts : 0x1::vector::empty<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(),
            u64_padding                   : 0x1::vector::empty<u64>(),
            bcs_padding                   : 0x1::vector::empty<u8>(),
        };
        0x2::dynamic_object_field::add<u64, LiquidityPool>(&mut arg1.liquidity_pool_registry, arg1.num_pool, v1);
        arg1.num_pool = arg1.num_pool + 1;
        let v2 = NewLiquidityPoolEvent{
            sender           : 0x2::tx_context::sender(arg3),
            index            : arg1.num_pool - 1,
            lp_token_type    : 0x1::type_name::get<T0>(),
            lp_token_decimal : arg2,
            u64_padding      : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewLiquidityPoolEvent>(v2);
    }

    public(friend) fun oracle_matched(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            let v1 = 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0);
            if (v1.token_type == arg1 && v1.config.oracle_id == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun order_filled<T0>(arg0: &mut LiquidityPool, arg1: bool, arg2: u64, arg3: 0x2::balance::Balance<T0>) {
        assert!(arg0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        update_reserve_amount<T0>(arg0, arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg3);
    }

    public(friend) fun put_collateral<T0>(arg0: &mut LiquidityPool, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = get_mut_token_pool(arg0, &v0);
        let v2 = v1.config;
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg1);
        v1.state.value_in_usd = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v1.state.liquidity_amount, v2.liquidity_token_decimal, arg2, arg3);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v3 = v3 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v4).state.value_in_usd;
            v4 = v4 + 1;
        };
        arg0.pool_info.tvl_usd = v3;
    }

    public(friend) fun put_receipt_collaterals(arg0: &mut LiquidityPool, arg1: vector<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>) {
        0x1::vector::append<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::escrow::UnsettledBidReceipt>(&mut arg0.liquidated_unsettled_receipts, arg1);
    }

    public(friend) fun request_collateral<T0>(arg0: &mut LiquidityPool, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v2 = get_mut_token_pool(arg0, &v0);
        let v3 = v2.config;
        v2.state.liquidity_amount = v2.state.liquidity_amount - arg1;
        v2.state.value_in_usd = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v2.state.liquidity_amount, v3.liquidity_token_decimal, arg2, arg3);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v4 = v4 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v5).state.value_in_usd;
            v5 = v5 + 1;
        };
        arg0.pool_info.tvl_usd = v4;
        v1
    }

    entry fun resume_pool(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(!v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_already_active());
        v0.pool_info.is_active = true;
        let v1 = ResumePoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumePoolEvent>(v1);
    }

    entry fun resume_token_pool<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(!v2.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_already_active());
        v2.state.is_active = true;
        let v3 = ResumeTokenPoolEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            liquidity_token : 0x1::type_name::get<T0>(),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeTokenPoolEvent>(v3);
    }

    public(friend) fun safety_check(arg0: &LiquidityPool) {
        assert!(arg0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
    }

    public fun start_remove_liquidity_token_process<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::tx_context::TxContext) : RemoveLiquidityTokenProcess {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg4);
        check_token_pool_status<T0>(arg1, arg2, false);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_token_pool(get_liquidity_pool(arg1, arg2), &v0).config;
        let v2 = 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3);
        assert!(v2 == v1.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        let v3 = StartRemoveLiquidityTokenProcessEvent{
            index           : arg2,
            liquidity_token : 0x1::type_name::get<T0>(),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<StartRemoveLiquidityTokenProcessEvent>(v3);
        RemoveLiquidityTokenProcess{
            liquidity_token              : 0x1::type_name::get<T0>(),
            removed_positions_base_token : 0x1::vector::empty<0x1::type_name::TypeName>(),
            removed_orders_base_token    : 0x1::vector::empty<0x1::type_name::TypeName>(),
            removed_token_oracle_id      : v2,
            removed_usd                  : 0,
            repaid_usd                   : 0,
            status                       : 0,
        }
    }

    entry fun suspend_pool(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        v0.pool_info.is_active = false;
        let v1 = SuspendPoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendPoolEvent>(v1);
    }

    entry fun suspend_token_pool<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        v2.state.is_active = false;
        let v3 = SuspendTokenPoolEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            liquidity_token : 0x1::type_name::get<T0>(),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendTokenPoolEvent>(v3);
    }

    public(friend) fun token_pool_is_active(arg0: &TokenPool) : bool {
        arg0.state.is_active
    }

    public fun update_borrow_info(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = v0.liquidity_tokens;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            let v3 = get_mut_token_pool(v0, &v2);
            let v4 = v3.config;
            let v5 = 0x2::clock::timestamp_ms(arg3) / v4.margin_config.borrow_interval_ts_ms * v4.margin_config.borrow_interval_ts_ms;
            let v6 = v3.state.last_borrow_rate_ts_ms;
            let v7 = v3.state.cumulative_borrow_rate;
            if (v5 - v3.state.last_borrow_rate_ts_ms >= v4.margin_config.borrow_interval_ts_ms) {
                let v8 = if (v3.state.liquidity_amount == 0) {
                    0
                } else {
                    ((10000 * (v3.state.reserved_amount as u128) / (v3.state.liquidity_amount as u128)) as u64)
                };
                let v9 = if (v8 < v4.margin_config.utilization_threshold_bp_0) {
                    (((v4.margin_config.basic_borrow_rate_0 as u128) * (v8 as u128) / (v4.margin_config.utilization_threshold_bp_0 as u128)) as u64)
                } else if (v8 < v4.margin_config.utilization_threshold_bp_1) {
                    v4.margin_config.basic_borrow_rate_0 + (((v4.margin_config.basic_borrow_rate_1 as u128) * ((v8 - v4.margin_config.utilization_threshold_bp_0) as u128) / ((v4.margin_config.utilization_threshold_bp_1 - v4.margin_config.utilization_threshold_bp_0) as u128)) as u64)
                } else {
                    v4.margin_config.basic_borrow_rate_0 + v4.margin_config.basic_borrow_rate_1 + (((v4.margin_config.basic_borrow_rate_2 as u128) * ((v8 - v4.margin_config.utilization_threshold_bp_1) as u128) / ((10000 - v4.margin_config.utilization_threshold_bp_1) as u128)) as u64)
                };
                v3.state.previous_last_borrow_rate_ts_ms = v6;
                v3.state.previous_cumulative_borrow_rate = v7;
                v3.state.cumulative_borrow_rate = v3.state.cumulative_borrow_rate + v9 * (v5 - v3.state.last_borrow_rate_ts_ms) / v4.margin_config.borrow_interval_ts_ms;
                v3.state.last_borrow_rate_ts_ms = v5;
                let v10 = UpdateBorrowInfoEvent{
                    index                           : arg2,
                    liquidity_token_type            : v2,
                    previous_borrow_ts_ms           : v6,
                    previous_cumulative_borrow_rate : v7,
                    borrow_interval_ts_ms           : v4.margin_config.borrow_interval_ts_ms,
                    last_borrow_rate_ts_ms          : v3.state.last_borrow_rate_ts_ms,
                    last_cumulative_borrow_rate     : v3.state.cumulative_borrow_rate,
                    u64_padding                     : 0x1::vector::empty<u64>(),
                };
                0x2::event::emit<UpdateBorrowInfoEvent>(v10);
                continue
            };
        };
    }

    public fun update_liquidity_value<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v1 = 0x1::type_name::get<T0>();
        let v2 = update_tvl(arg0, v0, v1, arg3, arg4);
        let v3 = UpdateLiquidityValueEvent{
            sender          : 0x2::tx_context::sender(arg5),
            index           : arg2,
            liquidity_token : v1,
            price           : 0x1::vector::pop_back<u64>(&mut v2),
            value_in_usd    : 0x1::vector::pop_back<u64>(&mut v2),
            lp_pool_tvl_usd : 0x1::vector::pop_back<u64>(&mut v2),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateLiquidityValueEvent>(v3);
    }

    entry fun update_margin_config<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg10);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed());
        let v2 = get_mut_token_pool(v0, &v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            v2.config.margin_config.basic_borrow_rate_0 = 0x1::option::extract<u64>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v2.config.margin_config.basic_borrow_rate_1 = 0x1::option::extract<u64>(&mut arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v2.config.margin_config.basic_borrow_rate_2 = 0x1::option::extract<u64>(&mut arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v2.config.margin_config.utilization_threshold_bp_0 = 0x1::option::extract<u64>(&mut arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v2.config.margin_config.utilization_threshold_bp_1 = 0x1::option::extract<u64>(&mut arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            v2.config.margin_config.borrow_interval_ts_ms = 0x1::option::extract<u64>(&mut arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            v2.config.margin_config.max_order_reserve_ratio_bp = 0x1::option::extract<u64>(&mut arg9);
        };
        let v3 = UpdateMarginConfigEvent{
            sender                 : 0x2::tx_context::sender(arg10),
            index                  : arg2,
            liquidity_token_type   : v1,
            previous_margin_config : v2.config.margin_config,
            new_margin_config      : v2.config.margin_config,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateMarginConfigEvent>(v3);
    }

    public(friend) fun update_remove_liquidity_token_process_status(arg0: &mut RemoveLiquidityTokenProcess, arg1: u64) {
        arg0.status = arg1;
    }

    public(friend) fun update_remove_liquidity_token_process_token<T0>(arg0: &mut RemoveLiquidityTokenProcess, arg1: bool) {
        if (arg1) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.removed_positions_base_token, 0x1::type_name::get<T0>());
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.removed_orders_base_token, 0x1::type_name::get<T0>());
        };
    }

    public(friend) fun update_reserve_amount<T0>(arg0: &mut LiquidityPool, arg1: bool, arg2: u64) {
        assert!(arg0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        if (arg1) {
            v1.state.reserved_amount = v1.state.reserved_amount + arg2;
        } else {
            v1.state.reserved_amount = v1.state.reserved_amount - arg2;
        };
    }

    entry fun update_spot_config<T0>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: &0x2::tx_context::TxContext) {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::verify(arg0, arg13);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed());
        let v2 = get_mut_token_pool(v0, &v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            v2.config.spot_config.target_weight_bp = 0x1::option::extract<u64>(&mut arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v2.config.spot_config.min_deposit = 0x1::option::extract<u64>(&mut arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v2.config.spot_config.max_capacity = 0x1::option::extract<u64>(&mut arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v2.config.spot_config.basic_mint_fee_bp = 0x1::option::extract<u64>(&mut arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v2.config.spot_config.additional_mint_fee_bp = 0x1::option::extract<u64>(&mut arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            v2.config.spot_config.basic_burn_fee_bp = 0x1::option::extract<u64>(&mut arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            v2.config.spot_config.additional_burn_fee_bp = 0x1::option::extract<u64>(&mut arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            v2.config.spot_config.swap_fee_bp = 0x1::option::extract<u64>(&mut arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            v2.config.spot_config.swap_fee_protocol_share_bp = 0x1::option::extract<u64>(&mut arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            v2.config.spot_config.lending_protocol_share_bp = 0x1::option::extract<u64>(&mut arg12);
        };
        let v3 = UpdateSpotConfigEvent{
            sender               : 0x2::tx_context::sender(arg13),
            index                : arg2,
            liquidity_token_type : v1,
            previous_spot_config : v2.config.spot_config,
            new_spot_config      : v2.config.spot_config,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateSpotConfigEvent>(v3);
    }

    fun update_tvl(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &mut LiquidityPool, arg2: 0x1::type_name::TypeName, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg4, 0);
        let v3 = get_mut_token_pool(arg1, &arg2);
        let v4 = v3.config;
        assert!(v4.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        v3.state.value_in_usd = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(v3.state.liquidity_amount, v4.liquidity_token_decimal, v1, v2);
        v3.state.update_ts_ms = 0x2::clock::timestamp_ms(arg4);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v3.state.value_in_usd);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<TokenPool>(&arg1.token_pools)) {
            v5 = v5 + 0x1::vector::borrow<TokenPool>(&arg1.token_pools, v6).state.value_in_usd;
            v6 = v6 + 1;
        };
        arg1.pool_info.tvl_usd = v5;
        0x1::vector::push_back<u64>(&mut v0, v5);
        v0
    }

    public(friend) fun view_swap_result<T0, T1>(arg0: &0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::Version, arg1: &Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: &0x2::clock::Clock) : vector<u64> {
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::admin::version_check(arg0);
        let v0 = get_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::pool_inactive());
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = 0x1::type_name::get<T1>();
        let v7 = get_token_pool(v0, &v5).config;
        let v8 = get_token_pool(v0, &v6).config;
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v7.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v8.oracle_id, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::oracle_mismatched());
        let v9 = get_token_pool(v0, &v5).state;
        let v10 = get_token_pool(v0, &v6).state;
        assert!(v9.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        assert!(v10.is_active, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::token_pool_inactive());
        let v11 = 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::amount_to_usd(arg5, v7.liquidity_token_decimal, v1, v2);
        let (v12, v13) = calculate_swap_fee(v0, v5, arg5, v11, true);
        let (_, v15) = calculate_swap_fee(v0, v6, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v11, v8.liquidity_token_decimal, v3, v4), v11, false);
        let (v16, v17) = if (v13 > v15) {
            (v12, v13)
        } else {
            (0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v15, v7.liquidity_token_decimal, v1, v2), v15)
        };
        let v18 = 0x1::vector::empty<u64>();
        let v19 = &mut v18;
        0x1::vector::push_back<u64>(v19, 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::math::usd_to_amount(v11 - v17, v8.liquidity_token_decimal, v3, v4));
        0x1::vector::push_back<u64>(v19, v16);
        0x1::vector::push_back<u64>(v19, v17);
        v18
    }

    // decompiled from Move bytecode v6
}

