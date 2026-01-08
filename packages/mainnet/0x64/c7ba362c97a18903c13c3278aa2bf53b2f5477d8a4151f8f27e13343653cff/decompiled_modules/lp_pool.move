module 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::lp_pool {
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
        liquidated_unsettled_receipts: vector<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>,
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

    struct DeactivatingShares<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        redeem_ts_ms: u64,
        unlock_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct ManagerDepositReceipt has store, key {
        id: 0x2::object::UID,
        index: u64,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        u64_padding: vector<u64>,
    }

    struct NewLiquidityPoolEvent has copy, drop {
        sender: address,
        index: u64,
        lp_token_type: 0x1::type_name::TypeName,
        lp_token_decimal: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateUnlockCountdownTsMsEvent has copy, drop {
        sender: address,
        index: u64,
        previous_unlock_countdown_ts_ms: u64,
        new_unlock_countdown_ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct UpdateRebalanceCostThresholdBpEvent has copy, drop {
        sender: address,
        index: u64,
        previous_rebalance_cost_threshold_bp: u64,
        new_rebalance_cost_threshold_bp: u64,
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

    struct ManagerEmergencyDepositEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        amount: u64,
        u64_padding: vector<u64>,
    }

    struct ManagerEmergencyWithdrawEvent has copy, drop {
        sender: address,
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        amount: u64,
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

    struct RedeemEvent has copy, drop {
        sender: address,
        index: u64,
        share: u64,
        share_price: u64,
        timestamp_ts_ms: u64,
        unlock_ts_ms: u64,
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

    struct DepositLendingEvent has copy, drop {
        index: u64,
        lending_index: u64,
        c_token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        minted_market_coin_amount: u64,
        latest_lending_amount: u64,
        latest_market_coin_amount: u64,
        latest_reserved_amount: u64,
        latest_liquidity_amount: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawLendingEvent has copy, drop {
        index: u64,
        lending_index: u64,
        c_token_type: 0x1::type_name::TypeName,
        r_token_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        withdrawn_collateral_amount: u64,
        latest_lending_amount: u64,
        latest_market_coin_amount: u64,
        latest_reserved_amount: u64,
        latest_liquidity_amount: u64,
        lending_interest: u64,
        protocol_share: u64,
        lending_reward: u64,
        reward_protocol_share: u64,
        u64_padding: vector<u64>,
    }

    struct ManagerRemoveLiquidityTokenEvent has copy, drop {
        index: u64,
        liquidity_token: 0x1::type_name::TypeName,
        u64_padding: vector<u64>,
    }

    struct RebalanceProcess {
        index: u64,
        token_type_a: 0x1::type_name::TypeName,
        token_decimal_a: u64,
        token_amount_a: u64,
        oracle_price_a: u64,
        reduced_usd: u64,
        token_type_b: 0x1::type_name::TypeName,
        token_decimal_b: u64,
        oracle_price_b: u64,
    }

    struct RebalanceEvent has copy, drop {
        index: u64,
        from_token: 0x1::type_name::TypeName,
        to_token: 0x1::type_name::TypeName,
        rebalance_amount: u64,
        from_token_oracle_price: u64,
        to_token_oracle_price: u64,
        reduced_usd: u64,
        tvl_usd: u64,
        from_token_liquidity_amount: u64,
        to_token_liquidity_amount: u64,
        u64_padding: vector<u64>,
    }

    struct CompleteRebalancingEvent has copy, drop {
        index: u64,
        from_token: 0x1::type_name::TypeName,
        to_token: 0x1::type_name::TypeName,
        from_token_oracle_price: u64,
        to_token_oracle_price: u64,
        swapped_back_usd: u64,
        tvl_usd: u64,
        from_token_liquidity_amount: u64,
        to_token_liquidity_amount: u64,
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

    public fun swap<T0, T1>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        update_borrow_info(arg0, arg1, arg2, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg7, 0);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg7, 0);
        let v5 = 0x2::coin::value<T0>(&arg5);
        let v6 = 0x1::type_name::with_defining_ids<T0>();
        let v7 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v6 != v7, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_token_type());
        let v8 = get_mut_token_pool(v0, &v6);
        let v9 = v8.config;
        let v10 = get_mut_token_pool(v0, &v7);
        let v11 = v10.config;
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v9.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v11.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        let v12 = get_mut_token_pool(v0, &v6);
        let v13 = v12.state;
        let v14 = get_mut_token_pool(v0, &v7);
        let v15 = v14.state;
        assert!(v13.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        assert!(v15.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        let v16 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(v5, v9.liquidity_token_decimal, v1, v2);
        let (v17, v18) = calculate_swap_fee(v0, v6, v5, v16, true);
        let (_, v20) = calculate_swap_fee(v0, v7, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v16, v11.liquidity_token_decimal, v3, v4), v16, false);
        let (v21, v22) = if (v18 > v20) {
            (v17, v18)
        } else {
            (0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v20, v9.liquidity_token_decimal, v1, v2), v20)
        };
        let v23 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v16 - v22, v11.liquidity_token_decimal, v3, v4);
        assert!(v23 >= arg6, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::reach_slippage_threshold());
        let v24 = get_mut_token_pool(v0, &v6);
        let v25 = 0x2::coin::into_balance<T0>(arg5);
        let v26 = 0x2::balance::value<T0>(&v25);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v25, (((v21 as u128) * (v24.config.spot_config.swap_fee_protocol_share_bp as u128) / 10000) as u64)));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v6), v25);
        let v27 = get_mut_token_pool(v0, &v6);
        assert!(v27.state.liquidity_amount + v26 <= v27.config.spot_config.max_capacity, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::reach_max_capacity());
        v27.state.liquidity_amount = v27.state.liquidity_amount + v26;
        update_tvl(arg0, v0, v6, arg3, arg7);
        let v28 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.id, v7), v23);
        let v29 = get_mut_token_pool(v0, &v7);
        v29.state.liquidity_amount = v29.state.liquidity_amount - 0x2::balance::value<T1>(&v28);
        assert!(v29.state.liquidity_amount >= v29.state.reserved_amount, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_not_enough());
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
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg4);
        let v2 = get_mut_token_pool(arg0, &v0);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v2.state.current_lending_amount, 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v2.state.current_lending_amount, 0) + 0x2::balance::value<T0>(&v1));
        let (v3, v4) = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::lending::deposit_scallop_basic<T0>(v1, arg1, arg2, arg3, arg5);
        let v5 = v4;
        let v6 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v6)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v6), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v3));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v6, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v3));
        };
        let v7 = get_token_pool(arg0, &v0);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v7.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v6)));
        0x1::vector::push_back<u64>(v9, v7.state.reserved_amount);
        0x1::vector::push_back<u64>(v9, v7.state.liquidity_amount);
        0x1::vector::append<u64>(&mut v5, v8);
        v5
    }

    fun withdraw_scallop_basic<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut LiquidityPool, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        let (v1, v2) = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::lending::withdraw_scallop_basic<T0>(0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg1.id, v0), arg5), arg6), arg2, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        let v6 = get_token_pool(arg1, &v5);
        let v7 = (((0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v6.state.current_lending_amount, 0) as u128) * (arg5 as u128) / (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0)) as u128)) as u64);
        let v8 = if (0x2::balance::value<T0>(&v4) >= v7) {
            0x2::balance::value<T0>(&v4) - v7
        } else {
            0
        };
        let v9 = (((v8 as u128) * (v6.config.spot_config.lending_protocol_share_bp as u128) / 10000) as u64);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v4, v9));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v5), v4);
        let v10 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0));
        let v11 = get_mut_token_pool(arg1, &v5);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v11.state.current_lending_amount, 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v11.state.current_lending_amount, 0) - v7);
        v11.state.liquidity_amount = v11.state.liquidity_amount + 0x2::balance::value<T0>(&v4) - v7;
        let v12 = 0x1::vector::empty<u64>();
        let v13 = &mut v12;
        0x1::vector::push_back<u64>(v13, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v11.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v13, v10);
        0x1::vector::push_back<u64>(v13, v11.state.reserved_amount);
        0x1::vector::push_back<u64>(v13, v11.state.liquidity_amount);
        0x1::vector::push_back<u64>(v13, v8);
        0x1::vector::push_back<u64>(v13, v9);
        0x1::vector::append<u64>(&mut v3, v12);
        v3
    }

    entry fun add_liquidity_token<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg23);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_token_existed());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.liquidity_tokens, v1);
        assert!(arg5 > 0 && arg5 <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg6 > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg7 > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg8 <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg9 <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg10 <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg11 <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg12 <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg13 <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg14 <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        let v2 = if (arg15 > 0) {
            if (arg15 < arg16) {
                arg16 < arg17
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        let v3 = if (arg18 > 0) {
            if (arg18 < arg19) {
                arg19 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg20 > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        assert!(arg21 > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        let v4 = SpotConfig{
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
        let v5 = MarginConfig{
            basic_borrow_rate_0        : arg15,
            basic_borrow_rate_1        : arg16,
            basic_borrow_rate_2        : arg17,
            utilization_threshold_bp_0 : arg18,
            utilization_threshold_bp_1 : arg19,
            borrow_interval_ts_ms      : arg20,
            max_order_reserve_ratio_bp : arg21,
            u64_padding                : 0x1::vector::empty<u64>(),
        };
        let v6 = Config{
            oracle_id               : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3),
            liquidity_token_decimal : arg4,
            spot_config             : v4,
            margin_config           : v5,
            u64_padding             : 0x1::vector::empty<u64>(),
        };
        let v7 = 0x2::clock::timestamp_ms(arg22);
        let v8 = v7 / arg20 * arg20;
        let v9 = State{
            liquidity_amount                : 0,
            value_in_usd                    : 0,
            reserved_amount                 : 0,
            update_ts_ms                    : v7,
            is_active                       : true,
            last_borrow_rate_ts_ms          : v8,
            cumulative_borrow_rate          : 0,
            previous_last_borrow_rate_ts_ms : v8,
            previous_cumulative_borrow_rate : 0,
            current_lending_amount          : 0x1::vector::empty<u64>(),
            u64_padding                     : 0x1::vector::empty<u64>(),
        };
        let v10 = TokenPool{
            token_type : v1,
            config     : v6,
            state      : v9,
        };
        0x1::vector::push_back<TokenPool>(&mut v0.token_pools, v10);
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v0.id, v1)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v1, 0x2::balance::zero<T0>());
        };
        let v11 = AddLiquidityTokenEvent{
            sender      : 0x2::tx_context::sender(arg23),
            index       : arg2,
            token_type  : v1,
            config      : v6,
            state       : v9,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<AddLiquidityTokenEvent>(v11);
    }

    fun burn_lp_<T0, T1>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::treasury_caps::TreasuryCaps, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let v3 = 0x2::balance::value<T0>(&arg5);
        let (v4, v5, v6, v7) = calculate_burn_lp(arg1, arg2, v0, v1, v2, v3);
        let v8 = get_mut_liquidity_pool(arg1, arg2);
        let v9 = get_mut_token_pool(v8, &v0);
        v9.state.liquidity_amount = v9.state.liquidity_amount - v6 - v7;
        assert!(v9.state.liquidity_amount >= v9.state.reserved_amount, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_not_enough());
        let v10 = get_mut_liquidity_pool(arg1, arg2);
        v10.pool_info.total_share_supply = v10.pool_info.total_share_supply - v3;
        update_tvl(arg0, v10, v0, arg4, arg6);
        0x2::coin::burn<T0>(0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::treasury_caps::get_mut_treasury_cap<T0>(arg3), 0x2::coin::from_balance<T0>(arg5, arg7));
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T1>(arg0, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v10.id, v0), v7));
        let v11 = BurnLpEvent{
            sender                : 0x2::tx_context::sender(arg7),
            index                 : arg2,
            lp_token_type         : v10.lp_token_type,
            burn_lp_amount        : v3,
            burn_amount_usd       : v4,
            burn_fee_usd          : v5,
            liquidity_token_type  : v0,
            withdraw_token_amount : v6,
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<BurnLpEvent>(v11);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v10.id, v0), v6), arg7)
    }

    public(friend) fun calculate_burn_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = get_token_pool(v0, &arg2);
        assert!(v0.pool_info.total_share_supply > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::zero_total_supply());
        let v2 = (((arg5 as u128) * (v0.pool_info.tvl_usd as u128) / (v0.pool_info.total_share_supply as u128)) as u64);
        let v3 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v2, v1.config.liquidity_token_decimal, arg3, arg4);
        let (v4, v5) = calculate_lp_fee(v0, arg2, v3, v2, false);
        (v2, v5, v3 - v4, v4)
    }

    fun calculate_lending_amount_capped(arg0: &TokenPool, arg1: 0x1::option::Option<u64>) : u64 {
        let v0 = arg0.state.liquidity_amount - arg0.state.reserved_amount;
        let v1 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&arg0.state.current_lending_amount, 0) + 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&arg0.state.current_lending_amount, 1);
        let v2 = if (v0 >= v1) {
            v0 - v1
        } else {
            0
        };
        if (0x1::option::is_none<u64>(&arg1)) {
            v2
        } else {
            let v4 = 0x1::option::extract<u64>(&mut arg1);
            if (v2 >= v4) {
                v4
            } else {
                v2
            }
        }
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
            assert!(v2 >= arg3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_not_enough());
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
            if (v1.target_weight_bp == 0) {
                v7
            } else if (arg0.pool_info.tvl_usd == 0) {
                0
            } else {
                let v10 = (v8 as u128) * ((v6 + v4) as u128);
                let v11 = 2 * (v3 as u128);
                let v12 = if (v10 / v11 * v11 == v10) {
                    v10 / v11
                } else {
                    v10 / v11 + 1
                };
                (v12 as u64)
            }
        } else {
            0
        };
        let v13 = if (v9 > v7) {
            v7
        } else {
            v9
        };
        let v14 = v7 + v13;
        ((((arg2 as u128) * (v14 as u128) / 10000) as u64), (((arg3 as u128) * (v14 as u128) / 10000) as u64))
    }

    public(friend) fun calculate_mint_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(arg5, get_token_pool(v0, &arg2).config.liquidity_token_decimal, arg3, arg4);
        let (_, v3) = calculate_lp_fee(v0, arg2, arg5, v1, true);
        assert!(v1 >= v3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::insufficient_amount_for_mint_fee());
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
            assert!(v2 >= arg3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_not_enough());
            v2 - arg3
        };
        let v6 = if (v3 > v5) {
            v3 - v5
        } else {
            v5 - v3
        };
        let v7 = v1.swap_fee_bp;
        let v8 = if (v6 > v4) {
            let v9 = (v1.swap_fee_bp as u128) * ((v6 + v4) as u128);
            let v10 = 2 * (v3 as u128);
            let v11 = if (v9 / v10 * v10 == v9) {
                v9 / v10
            } else {
                v9 / v10 + 1
            };
            (v11 as u64)
        } else {
            0
        };
        let v12 = if (v8 > v7) {
            v7
        } else {
            v8
        };
        let v13 = v7 + v12;
        ((((arg2 as u128) * (v13 as u128) / 10000) as u64), (((arg3 as u128) * (v13 as u128) / 10000) as u64))
    }

    public(friend) fun check_active(arg0: &LiquidityPool) : bool {
        arg0.pool_info.is_active
    }

    public(friend) fun check_token_pool_status<T0>(arg0: &Registry, arg1: u64, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            assert!(get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        } else {
            assert!(!get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
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

    public fun claim<T0, T1>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::treasury_caps::TreasuryCaps, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        normal_safety_check<T1, T0>(arg0, arg1, arg2, arg4, arg5);
        update_borrow_info(arg0, arg1, arg2, arg5);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&mut v0.id, 0x1::string::utf8(b"deactivating_shares"));
        let v2 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, vector<DeactivatingShares<T0>>>(v1, v2), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::user_deactivating_shares_not_existed());
        let v3 = 0x2::table::remove<address, vector<DeactivatingShares<T0>>>(v1, v2);
        let v4 = 0x1::vector::empty<DeactivatingShares<T0>>();
        let v5 = 0x2::balance::zero<T0>();
        while (0x1::vector::length<DeactivatingShares<T0>>(&v3) > 0) {
            let v6 = 0x1::vector::pop_back<DeactivatingShares<T0>>(&mut v3);
            if (0x2::clock::timestamp_ms(arg5) >= v6.unlock_ts_ms) {
                let DeactivatingShares {
                    balance      : v7,
                    redeem_ts_ms : _,
                    unlock_ts_ms : _,
                    u64_padding  : _,
                } = v6;
                0x2::balance::join<T0>(&mut v5, v7);
                continue
            };
            0x1::vector::push_back<DeactivatingShares<T0>>(&mut v4, v6);
        };
        0x1::vector::destroy_empty<DeactivatingShares<T0>>(v3);
        if (0x1::vector::length<DeactivatingShares<T0>>(&v4) > 0) {
            0x2::table::add<address, vector<DeactivatingShares<T0>>>(v1, v2, v4);
        } else {
            0x1::vector::destroy_empty<DeactivatingShares<T0>>(v4);
        };
        if (0x2::balance::value<T0>(&v5) > 0) {
            0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v0.u64_padding, 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 0) - 0x2::balance::value<T0>(&v5));
        };
        burn_lp_<T0, T1>(arg0, arg1, arg2, arg3, arg4, v5, arg5, arg6)
    }

    public fun complete_rebalancing<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: 0x2::balance::Balance<T1>, arg6: RebalanceProcess, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg8);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_token_pool(v0, &v2).config.liquidity_token_decimal;
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = get_token_pool(v0, &v4).config.liquidity_token_decimal;
        let (v6, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg7, 0);
        let (v8, v9) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg7, 0);
        let v10 = 0x1::type_name::with_defining_ids<T0>();
        let v11 = get_mut_token_pool(v0, &v10);
        assert!(v11.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v11.config.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        let v12 = v11.state.liquidity_amount;
        let v13 = 0x1::type_name::with_defining_ids<T1>();
        let v14 = get_mut_token_pool(v0, &v13);
        assert!(v14.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v14.config.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        let v15 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(0x2::balance::value<T1>(&arg5), v14.config.liquidity_token_decimal, v8, v9);
        let RebalanceProcess {
            index           : v16,
            token_type_a    : v17,
            token_decimal_a : v18,
            token_amount_a  : _,
            oracle_price_a  : v20,
            reduced_usd     : v21,
            token_type_b    : v22,
            token_decimal_b : v23,
            oracle_price_b  : v24,
        } = arg6;
        assert!(arg2 == v16, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v17 == 0x1::type_name::with_defining_ids<T0>(), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v18 == v3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v20 == v6, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v22 == 0x1::type_name::with_defining_ids<T1>(), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v23 == v5, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!(v24 == v8, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::rebalance_process_field_mismatched());
        assert!((((v15 as u128) * ((10000 + v1) as u128) / 10000) as u64) >= v21, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::exceed_rebalance_cost_threshold());
        v14.state.liquidity_amount = v14.state.liquidity_amount + 0x2::balance::value<T1>(&arg5);
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::type_name::with_defining_ids<T1>()), arg5);
        update_tvl(arg0, v0, 0x1::type_name::with_defining_ids<T1>(), arg4, arg7);
        let v25 = CompleteRebalancingEvent{
            index                       : arg2,
            from_token                  : 0x1::type_name::with_defining_ids<T0>(),
            to_token                    : 0x1::type_name::with_defining_ids<T1>(),
            from_token_oracle_price     : v6,
            to_token_oracle_price       : v8,
            swapped_back_usd            : v15,
            tvl_usd                     : v0.pool_info.tvl_usd,
            from_token_liquidity_amount : v12,
            to_token_liquidity_amount   : v14.state.liquidity_amount,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CompleteRebalancingEvent>(v25);
    }

    fun deposit_navi<T0>(arg0: &mut LiquidityPool, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg7);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return 0x1::vector::empty<u64>()
        };
        let v2 = get_mut_token_pool(arg0, &v0);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v2.state.current_lending_amount, 1, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v2.state.current_lending_amount, 1) + 0x2::balance::value<T0>(&v1));
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"navi_account_cap")) {
            0x2::dynamic_field::add<vector<u8>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.id, b"navi_account_cap", 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg8));
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v1, arg8), arg4, arg5, 0x2::dynamic_field::borrow<vector<u8>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.id, b"navi_account_cap"));
        let v3 = get_token_pool(arg0, &v0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v3.state.current_lending_amount, 1));
        0x1::vector::push_back<u64>(v5, v3.state.reserved_amount);
        0x1::vector::push_back<u64>(v5, v3.state.liquidity_amount);
        v4
    }

    fun deprecated() {
        abort 0
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
        while (v2 < 0x1::vector::length<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(v1)) {
            let v3 = 0x1::vector::borrow<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(v1, v2);
            let v4 = true;
            let v5 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::get_bid_receipts(v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v5)) {
                if (!0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::check_bid_receipt_expired(arg1, 0x1::vector::borrow<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>(v5, v6))) {
                    v4 = false;
                };
                v6 = v6 + 1;
            };
            if (v4) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(v3));
            };
            v2 = v2 + 1;
        };
        v0
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
        abort 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_token_not_existed()
    }

    public fun get_pool_liquidity(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &Registry, arg2: u64) : (u64, u64, vector<0x1::type_name::TypeName>, vector<u64>, vector<u64>) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let v0 = get_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<TokenPool>(&v0.token_pools)) {
            let v5 = 0x1::vector::borrow<TokenPool>(&v0.token_pools, v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v5.token_type);
            0x1::vector::push_back<u64>(&mut v3, v5.state.liquidity_amount);
            0x1::vector::push_back<u64>(&mut v4, v5.state.value_in_usd);
            v1 = v1 + 1;
        };
        (v0.pool_info.total_share_supply, v0.pool_info.tvl_usd, v2, v3, v4)
    }

    public(friend) fun get_receipt_collateral(arg0: &mut LiquidityPool) : vector<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt> {
        let v0 = 0x1::vector::empty<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>();
        while (0x1::vector::length<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(&arg0.liquidated_unsettled_receipts) > 0) {
            0x1::vector::push_back<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(&mut v0, 0x1::vector::pop_back<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(&mut arg0.liquidated_unsettled_receipts));
        };
        v0
    }

    public(friend) fun get_receipt_collateral_bcs(arg0: &Registry, arg1: u64) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &get_liquidity_pool(arg0, arg1).liquidated_unsettled_receipts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(v1)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(0x1::vector::borrow<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun get_token_pool(arg0: &LiquidityPool, arg1: &0x1::type_name::TypeName) : &TokenPool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0).token_type == *arg1) {
                return 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0)
            };
            v0 = v0 + 1;
        };
        abort 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_token_not_existed()
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

    public(friend) fun get_user_deactivating_shares<T0>(arg0: &Registry, arg1: u64, arg2: address) : vector<vector<u8>> {
        let v0 = get_liquidity_pool(arg0, arg1);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.lp_token_type, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::lp_token_type_mismatched());
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&v0.id, 0x1::string::utf8(b"deactivating_shares"));
        let v2 = 0x1::vector::empty<vector<u8>>();
        if (0x2::table::contains<address, vector<DeactivatingShares<T0>>>(v1, arg2)) {
            let v3 = 0x2::table::borrow<address, vector<DeactivatingShares<T0>>>(v1, arg2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<DeactivatingShares<T0>>(v3)) {
                0x1::vector::push_back<vector<u8>>(&mut v2, 0x2::bcs::to_bytes<DeactivatingShares<T0>>(0x1::vector::borrow<DeactivatingShares<T0>>(v3, v4)));
                v4 = v4 + 1;
            };
        };
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                      : 0x2::object::new(arg0),
            num_pool                : 0,
            liquidity_pool_registry : 0x2::object::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    entry fun manager_deposit_navi<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg10);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        let v3 = calculate_lending_amount_capped(v2, arg9);
        if (v3 > 0) {
            let v4 = deposit_navi<T0>(v0, arg3, arg4, arg5, arg6, arg7, arg8, v3, arg10);
            let v5 = DepositLendingEvent{
                index                     : arg2,
                lending_index             : 1,
                c_token_type              : 0x1::type_name::with_defining_ids<T0>(),
                deposit_amount            : v3,
                minted_market_coin_amount : 0,
                latest_lending_amount     : *0x1::vector::borrow<u64>(&v4, 0),
                latest_market_coin_amount : 0,
                latest_reserved_amount    : *0x1::vector::borrow<u64>(&v4, 1),
                latest_liquidity_amount   : *0x1::vector::borrow<u64>(&v4, 2),
                u64_padding               : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<DepositLendingEvent>(v5);
        };
    }

    entry fun manager_deposit_scallop<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        let v3 = calculate_lending_amount_capped(v2, arg6);
        if (v3 > 0) {
            let v4 = deposit_scallop_basic<T0>(v0, arg3, arg4, arg5, v3, arg7);
            let v5 = DepositLendingEvent{
                index                     : arg2,
                lending_index             : 0,
                c_token_type              : 0x1::type_name::with_defining_ids<T0>(),
                deposit_amount            : *0x1::vector::borrow<u64>(&v4, 0),
                minted_market_coin_amount : *0x1::vector::borrow<u64>(&v4, 1),
                latest_lending_amount     : *0x1::vector::borrow<u64>(&v4, 2),
                latest_market_coin_amount : *0x1::vector::borrow<u64>(&v4, 3),
                latest_reserved_amount    : *0x1::vector::borrow<u64>(&v4, 4),
                latest_liquidity_amount   : *0x1::vector::borrow<u64>(&v4, 5),
                u64_padding               : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<DepositLendingEvent>(v5);
        };
    }

    entry fun manager_emergency_deposit<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = 0x2::balance::value<T0>(&v1);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg4);
        let v3 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::with_defining_ids<T1>() == v3.lp_token_type, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::lp_token_type_mismatched());
        assert!(v3.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(get_token_pool(v3, &v0).state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_mut_liquidity_pool(arg1, arg2).id, v0), v1);
        let v4 = ManagerDepositReceipt{
            id          : 0x2::object::new(arg4),
            index       : arg2,
            token_type  : v0,
            amount      : v2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::public_transfer<ManagerDepositReceipt>(v4, 0x2::tx_context::sender(arg4));
        let v5 = ManagerEmergencyDepositEvent{
            sender               : 0x2::tx_context::sender(arg4),
            index                : arg2,
            liquidity_token_type : v0,
            amount               : v2,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerEmergencyDepositEvent>(v5);
    }

    entry fun manager_emergency_withdraw<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: ManagerDepositReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let ManagerDepositReceipt {
            id          : v1,
            index       : v2,
            token_type  : v3,
            amount      : v4,
            u64_padding : _,
        } = arg3;
        0x2::object::delete(v1);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg4);
        assert!(v2 == arg2, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_index_mismatched());
        assert!(v0 == v3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_token_type());
        let v6 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::with_defining_ids<T1>() == v6.lp_token_type, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::lp_token_type_mismatched());
        assert!(v6.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(get_token_pool(v6, &v0).state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        let v7 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_mut_liquidity_pool(arg1, arg2).id, v0), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), 0x2::tx_context::sender(arg4));
        let v8 = ManagerEmergencyWithdrawEvent{
            sender               : 0x2::tx_context::sender(arg4),
            index                : arg2,
            liquidity_token_type : v0,
            amount               : 0x2::balance::value<T0>(&v7),
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerEmergencyWithdrawEvent>(v8);
    }

    public fun manager_remove_all_liquidity<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_mut_liquidity_pool(arg1, arg2).id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun manager_remove_liquidity_token<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        check_token_pool_status<T0>(arg1, arg2, false);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_liquidity_pool(arg1, arg2);
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::with_defining_ids<T0>()));
        let (_, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v1.liquidity_tokens, &v0);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut v1.liquidity_tokens, v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<TokenPool>(&v1.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&v1.token_pools, v4).token_type == v0) {
                break
            };
            v4 = v4 + 1;
        };
        let TokenPool {
            token_type : _,
            config     : _,
            state      : _,
        } = 0x1::vector::remove<TokenPool>(&mut v1.token_pools, v4);
        let v8 = ManagerRemoveLiquidityTokenEvent{
            index           : arg2,
            liquidity_token : v0,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ManagerRemoveLiquidityTokenEvent>(v8);
    }

    entry fun manager_reward_navi<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: vector<0x1::ascii::String>, arg6: vector<address>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg9);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = reward_navi<T0>(arg0, v0, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = WithdrawLendingEvent{
            index                       : arg2,
            lending_index               : 1,
            c_token_type                : 0x1::type_name::with_defining_ids<T0>(),
            r_token_type                : 0x1::type_name::with_defining_ids<T0>(),
            withdraw_amount             : 0,
            withdrawn_collateral_amount : 0,
            latest_lending_amount       : 0,
            latest_market_coin_amount   : 0,
            latest_reserved_amount      : 0,
            latest_liquidity_amount     : 0,
            lending_interest            : 0,
            protocol_share              : 0,
            lending_reward              : *0x1::vector::borrow<u64>(&v1, 0),
            reward_protocol_share       : *0x1::vector::borrow<u64>(&v1, 1),
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<WithdrawLendingEvent>(v2);
    }

    entry fun manager_withdraw_navi<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg14);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg9, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg8, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x2::dynamic_field::borrow_mut<vector<u8>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut v0.id, b"navi_account_cap"))) as u64));
        if (v3 > 0) {
            let v4 = withdraw_navi<T0>(arg0, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
            let v5 = WithdrawLendingEvent{
                index                       : arg2,
                lending_index               : 1,
                c_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                r_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                withdraw_amount             : 0,
                withdrawn_collateral_amount : v3,
                latest_lending_amount       : *0x1::vector::borrow<u64>(&v4, 0),
                latest_market_coin_amount   : 0,
                latest_reserved_amount      : *0x1::vector::borrow<u64>(&v4, 1),
                latest_liquidity_amount     : *0x1::vector::borrow<u64>(&v4, 2),
                lending_interest            : *0x1::vector::borrow<u64>(&v4, 3),
                protocol_share              : *0x1::vector::borrow<u64>(&v4, 4),
                lending_reward              : 0,
                reward_protocol_share       : 0,
                u64_padding                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<WithdrawLendingEvent>(v5);
        };
    }

    entry fun manager_withdraw_scallop<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        let v3 = if (0x1::option::is_none<u64>(&arg6)) {
            0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v0.id, 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>()))
        } else {
            0x1::option::extract<u64>(&mut arg6)
        };
        if (v3 > 0) {
            let v4 = withdraw_scallop_basic<T0>(arg0, v0, arg3, arg4, arg5, v3, arg7);
            let v5 = WithdrawLendingEvent{
                index                       : arg2,
                lending_index               : 0,
                c_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                r_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                withdraw_amount             : *0x1::vector::borrow<u64>(&v4, 0),
                withdrawn_collateral_amount : *0x1::vector::borrow<u64>(&v4, 1),
                latest_lending_amount       : *0x1::vector::borrow<u64>(&v4, 2),
                latest_market_coin_amount   : *0x1::vector::borrow<u64>(&v4, 3),
                latest_reserved_amount      : *0x1::vector::borrow<u64>(&v4, 4),
                latest_liquidity_amount     : *0x1::vector::borrow<u64>(&v4, 5),
                lending_interest            : *0x1::vector::borrow<u64>(&v4, 6),
                protocol_share              : *0x1::vector::borrow<u64>(&v4, 7),
                lending_reward              : 0,
                reward_protocol_share       : 0,
                u64_padding                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<WithdrawLendingEvent>(v5);
        };
    }

    public fun mint_lp<T0, T1>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::treasury_caps::TreasuryCaps, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::into_balance<T0>(arg5);
        let v2 = 0x2::balance::value<T0>(&v1);
        normal_safety_check<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v3 = get_token_pool(get_liquidity_pool(arg1, arg4), &v0);
        assert!(v2 >= v3.config.spot_config.min_deposit, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::deposit_amount_insufficient());
        assert!(v3.state.liquidity_amount + v2 <= v3.config.spot_config.max_capacity, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::reach_max_capacity());
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        update_borrow_info(arg0, arg1, arg4, arg6);
        let (v6, v7, v8) = calculate_mint_lp(arg1, arg4, v0, v4, v5, v2);
        let v9 = get_mut_liquidity_pool(arg1, arg4);
        v9.pool_info.total_share_supply = v9.pool_info.total_share_supply + v8;
        let v10 = 0x2::balance::split<T0>(&mut v1, (((v2 as u128) * (v7 as u128) / (v6 as u128)) as u64));
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T0>(arg0, v10);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9.id, v0), v1);
        let v11 = get_mut_token_pool(v9, &v0);
        v11.state.liquidity_amount = v11.state.liquidity_amount + v2 - 0x2::balance::value<T0>(&v10);
        update_tvl(arg0, v9, v0, arg3, arg6);
        let v12 = MintLpEvent{
            sender               : 0x2::tx_context::sender(arg7),
            index                : arg4,
            liquidity_token_type : v0,
            deposit_amount       : v2,
            deposit_amount_usd   : v6,
            mint_fee_usd         : v7,
            lp_token_type        : v9.lp_token_type,
            minted_lp_amount     : v8,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<MintLpEvent>(v12);
        0x2::coin::mint<T1>(0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::treasury_caps::get_mut_treasury_cap<T1>(arg2), v8, arg7)
    }

    entry fun new_liquidity_pool<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg4);
        let v0 = LiquidityPoolInfo{
            lp_token_decimal   : arg2,
            total_share_supply : 0,
            tvl_usd            : 0,
            is_active          : true,
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0);
        0x1::vector::push_back<u64>(v2, arg3);
        let v3 = LiquidityPool{
            id                            : 0x2::object::new(arg4),
            index                         : arg1.num_pool,
            lp_token_type                 : 0x1::type_name::with_defining_ids<T0>(),
            liquidity_tokens              : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_pools                   : 0x1::vector::empty<TokenPool>(),
            pool_info                     : v0,
            liquidated_unsettled_receipts : 0x1::vector::empty<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(),
            u64_padding                   : v1,
            bcs_padding                   : 0x1::vector::empty<u8>(),
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&mut v3.id, 0x1::string::utf8(b"deactivating_shares"), 0x2::table::new<address, vector<DeactivatingShares<T0>>>(arg4));
        0x2::dynamic_object_field::add<u64, LiquidityPool>(&mut arg1.liquidity_pool_registry, arg1.num_pool, v3);
        arg1.num_pool = arg1.num_pool + 1;
        let v4 = NewLiquidityPoolEvent{
            sender           : 0x2::tx_context::sender(arg4),
            index            : arg1.num_pool - 1,
            lp_token_type    : 0x1::type_name::with_defining_ids<T0>(),
            lp_token_decimal : arg2,
            u64_padding      : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewLiquidityPoolEvent>(v4);
    }

    fun normal_safety_check<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let v0 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::with_defining_ids<T1>() == v0.lp_token_type, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::lp_token_type_mismatched());
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(check_tvl_updated(v0, arg4), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::tvl_not_yet_updated());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v2.config.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
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
        assert!(arg0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        update_reserve_amount<T0>(arg0, arg1, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg3);
    }

    public(friend) fun put_collateral<T0>(arg0: &mut LiquidityPool, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = get_mut_token_pool(arg0, &v0);
        let v2 = v1.config;
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg1);
        v1.state.value_in_usd = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(v1.state.liquidity_amount, v2.liquidity_token_decimal, arg2, arg3);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v3 = v3 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v4).state.value_in_usd;
            v4 = v4 + 1;
        };
        arg0.pool_info.tvl_usd = v3;
    }

    public(friend) fun put_receipt_collaterals(arg0: &mut LiquidityPool, arg1: vector<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>) {
        0x1::vector::append<0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::escrow::UnsettledBidReceipt>(&mut arg0.liquidated_unsettled_receipts, arg1);
    }

    public fun rebalance<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (RebalanceProcess, 0x2::balance::Balance<T0>) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_token_pool(v0, &v1).config.liquidity_token_decimal;
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = get_token_pool(v0, &v3).config.liquidity_token_decimal;
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        let (v7, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let v9 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::with_defining_ids<T0>()), arg5);
        let v10 = 0x1::type_name::with_defining_ids<T0>();
        let v11 = get_mut_token_pool(v0, &v10);
        assert!(v11.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v11.config.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        v11.state.liquidity_amount = v11.state.liquidity_amount - 0x2::balance::value<T0>(&v9);
        assert!(v11.state.liquidity_amount >= v11.state.reserved_amount, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_not_enough());
        let v12 = v11.state.liquidity_amount;
        let v13 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(arg5, v2, v5, v6);
        let v14 = 0x1::type_name::with_defining_ids<T1>();
        let v15 = get_mut_token_pool(v0, &v14);
        assert!(v15.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v15.config.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        let v16 = RebalanceProcess{
            index           : arg2,
            token_type_a    : 0x1::type_name::with_defining_ids<T0>(),
            token_decimal_a : v2,
            token_amount_a  : arg5,
            oracle_price_a  : v5,
            reduced_usd     : v13,
            token_type_b    : 0x1::type_name::with_defining_ids<T1>(),
            token_decimal_b : v4,
            oracle_price_b  : v7,
        };
        update_tvl(arg0, v0, 0x1::type_name::with_defining_ids<T0>(), arg3, arg6);
        let v17 = RebalanceEvent{
            index                       : arg2,
            from_token                  : 0x1::type_name::with_defining_ids<T0>(),
            to_token                    : 0x1::type_name::with_defining_ids<T1>(),
            rebalance_amount            : arg5,
            from_token_oracle_price     : v5,
            to_token_oracle_price       : v7,
            reduced_usd                 : v13,
            tvl_usd                     : v0.pool_info.tvl_usd,
            from_token_liquidity_amount : v12,
            to_token_liquidity_amount   : v15.state.liquidity_amount,
            u64_padding                 : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RebalanceEvent>(v17);
        (v16, v9)
    }

    public fun redeem<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        update_borrow_info(arg0, arg1, arg2, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(check_tvl_updated(v0, arg4), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::tvl_not_yet_updated());
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.lp_token_type, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::lp_token_type_mismatched());
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::balance::value<T0>(&arg3);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 1);
        let v5 = DeactivatingShares<T0>{
            balance      : arg3,
            redeem_ts_ms : v3,
            unlock_ts_ms : v4,
            u64_padding  : 0x1::vector::empty<u64>(),
        };
        let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&mut v0.id, 0x1::string::utf8(b"deactivating_shares"));
        if (0x2::table::contains<address, vector<DeactivatingShares<T0>>>(v6, v1)) {
            0x1::vector::push_back<DeactivatingShares<T0>>(0x2::table::borrow_mut<address, vector<DeactivatingShares<T0>>>(v6, v1), v5);
        } else {
            let v7 = 0x1::vector::empty<DeactivatingShares<T0>>();
            0x1::vector::push_back<DeactivatingShares<T0>>(&mut v7, v5);
            0x2::table::add<address, vector<DeactivatingShares<T0>>>(v6, v1, v7);
        };
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v0.u64_padding, 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 0) + v2);
        let v8 = RedeemEvent{
            sender          : v1,
            index           : arg2,
            share           : v2,
            share_price     : (((v0.pool_info.tvl_usd as u128) * (0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::multiplier(0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_usd_decimal()) as u128) / (v0.pool_info.total_share_supply as u128)) as u64),
            timestamp_ts_ms : v3,
            unlock_ts_ms    : v4,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RedeemEvent>(v8);
    }

    public(friend) fun request_collateral<T0>(arg0: &mut LiquidityPool, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v2 = get_mut_token_pool(arg0, &v0);
        let v3 = v2.config;
        v2.state.liquidity_amount = v2.state.liquidity_amount - arg1;
        v2.state.value_in_usd = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(v2.state.liquidity_amount, v3.liquidity_token_decimal, arg2, arg3);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v4 = v4 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v5).state.value_in_usd;
            v5 = v5 + 1;
        };
        arg0.pool_info.tvl_usd = v4;
        v1
    }

    entry fun resume_pool(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(!v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_already_active());
        v0.pool_info.is_active = true;
        let v1 = ResumePoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumePoolEvent>(v1);
    }

    entry fun resume_token_pool<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(!v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_already_active());
        v2.state.is_active = true;
        let v3 = ResumeTokenPoolEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            liquidity_token : 0x1::type_name::with_defining_ids<T0>(),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ResumeTokenPoolEvent>(v3);
    }

    fun reward_navi<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut LiquidityPool, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg7, arg6, arg2, arg3, arg4, arg5, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg1.id, b"navi_account_cap"));
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let (v2, v3) = if (0x1::vector::contains<0x1::type_name::TypeName>(&arg1.liquidity_tokens, &v1)) {
            let v4 = 0x2::balance::value<T0>(&v0);
            let v5 = (((v4 as u128) * (get_token_pool(arg1, &v1).config.spot_config.lending_protocol_share_bp as u128) / 10000) as u64);
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v1), 0x2::balance::split<T0>(&mut v0, v4 - v5));
            let v6 = get_mut_token_pool(arg1, &v1);
            v6.state.liquidity_amount = v6.state.liquidity_amount + v4 - v5;
            (v4, v5)
        } else {
            (0, 0x2::balance::value<T0>(&v0))
        };
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T0>(arg0, v0);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = &mut v7;
        0x1::vector::push_back<u64>(v8, v2);
        0x1::vector::push_back<u64>(v8, v3);
        v7
    }

    public(friend) fun safety_check(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: address) {
        assert!(check_active(arg0), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(oracle_matched(arg0, arg1, arg2), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
    }

    entry fun suspend_pool(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        v0.pool_info.is_active = false;
        let v1 = SuspendPoolEvent{
            sender      : 0x2::tx_context::sender(arg3),
            index       : arg2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendPoolEvent>(v1);
    }

    entry fun suspend_token_pool<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        v2.state.is_active = false;
        let v3 = SuspendTokenPoolEvent{
            sender          : 0x2::tx_context::sender(arg3),
            index           : arg2,
            liquidity_token : 0x1::type_name::with_defining_ids<T0>(),
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SuspendTokenPoolEvent>(v3);
    }

    public(friend) fun token_pool_is_active(arg0: &TokenPool) : bool {
        arg0.state.is_active
    }

    public fun update_borrow_info(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
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

    public fun update_liquidity_value<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(get_token_pool(v0, &v1).state.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
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

    entry fun update_margin_config<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg10);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_token_not_existed());
        let v2 = get_mut_token_pool(v0, &v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            v2.config.margin_config.basic_borrow_rate_0 = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v2.config.margin_config.basic_borrow_rate_1 = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v2.config.margin_config.basic_borrow_rate_2 = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v2.config.margin_config.utilization_threshold_bp_0 = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v2.config.margin_config.utilization_threshold_bp_1 = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            assert!(*0x1::option::borrow<u64>(&arg8) > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.margin_config.borrow_interval_ts_ms = *0x1::option::borrow<u64>(&arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.margin_config.max_order_reserve_ratio_bp = *0x1::option::borrow<u64>(&arg9);
        };
        let v3 = if (v2.config.margin_config.basic_borrow_rate_0 > 0) {
            if (v2.config.margin_config.basic_borrow_rate_0 < v2.config.margin_config.basic_borrow_rate_1) {
                v2.config.margin_config.basic_borrow_rate_1 < v2.config.margin_config.basic_borrow_rate_2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        let v4 = if (v2.config.margin_config.utilization_threshold_bp_0 > 0) {
            if (v2.config.margin_config.utilization_threshold_bp_0 < v2.config.margin_config.utilization_threshold_bp_1) {
                v2.config.margin_config.utilization_threshold_bp_1 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        let v5 = UpdateMarginConfigEvent{
            sender                 : 0x2::tx_context::sender(arg10),
            index                  : arg2,
            liquidity_token_type   : v1,
            previous_margin_config : v2.config.margin_config,
            new_margin_config      : v2.config.margin_config,
            u64_padding            : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateMarginConfigEvent>(v5);
    }

    entry fun update_rebalance_cost_threshold_bp(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        assert!(arg3 >= 0 && arg3 < 100, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v0.u64_padding, 2, arg3);
        let v1 = UpdateRebalanceCostThresholdBpEvent{
            sender                               : 0x2::tx_context::sender(arg4),
            index                                : arg2,
            previous_rebalance_cost_threshold_bp : 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 2),
            new_rebalance_cost_threshold_bp      : arg3,
            u64_padding                          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateRebalanceCostThresholdBpEvent>(v1);
    }

    public(friend) fun update_reserve_amount<T0>(arg0: &mut LiquidityPool, arg1: bool, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        if (arg1) {
            v1.state.reserved_amount = v1.state.reserved_amount + arg2;
        } else {
            assert!(v1.state.reserved_amount >= arg2, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::reserve_bookkeeping_error());
            v1.state.reserved_amount = v1.state.reserved_amount - arg2;
        };
    }

    entry fun update_spot_config<T0>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg13);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::liquidity_token_not_existed());
        let v2 = get_mut_token_pool(v0, &v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) > 0 && *0x1::option::borrow<u64>(&arg3) <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.target_weight_bp = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg4) > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.min_deposit = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(*0x1::option::borrow<u64>(&arg5) > 0, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.max_capacity = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.basic_mint_fee_bp = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(*0x1::option::borrow<u64>(&arg7) <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.additional_mint_fee_bp = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            assert!(*0x1::option::borrow<u64>(&arg8) <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.basic_burn_fee_bp = *0x1::option::borrow<u64>(&arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.additional_burn_fee_bp = *0x1::option::borrow<u64>(&arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            assert!(*0x1::option::borrow<u64>(&arg10) <= 30, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.swap_fee_bp = *0x1::option::borrow<u64>(&arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            assert!(*0x1::option::borrow<u64>(&arg11) <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.swap_fee_protocol_share_bp = *0x1::option::borrow<u64>(&arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            assert!(*0x1::option::borrow<u64>(&arg12) <= 10000, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::invalid_config_range());
            v2.config.spot_config.lending_protocol_share_bp = *0x1::option::borrow<u64>(&arg12);
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

    fun update_tvl(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut LiquidityPool, arg2: 0x1::type_name::TypeName, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg4, 0);
        let v3 = get_mut_token_pool(arg1, &arg2);
        let v4 = v3.config;
        assert!(v4.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3), 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        v3.state.value_in_usd = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(v3.state.liquidity_amount, v4.liquidity_token_decimal, v1, v2);
        v3.state.update_ts_ms = 0x2::clock::timestamp_ms(arg4);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v3.state.value_in_usd);
        arg1.pool_info.tvl_usd = arg1.pool_info.tvl_usd + v3.state.value_in_usd - v3.state.value_in_usd;
        0x1::vector::push_back<u64>(&mut v0, arg1.pool_info.tvl_usd);
        v0
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v0.u64_padding, 1, arg3);
        let v1 = UpdateUnlockCountdownTsMsEvent{
            sender                          : 0x2::tx_context::sender(arg4),
            index                           : arg2,
            previous_unlock_countdown_ts_ms : 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v0.u64_padding, 1),
            new_unlock_countdown_ts_ms      : arg3,
            u64_padding                     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UpdateUnlockCountdownTsMsEvent>(v1);
    }

    public(friend) fun view_swap_result<T0, T1>(arg0: &0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: u64, arg6: &0x2::clock::Clock) : vector<u64> {
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::version_check(arg0);
        let v0 = get_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::pool_inactive());
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg3, arg6, 0);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price_with_interval_ms(arg4, arg6, 0);
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        let v6 = 0x1::type_name::with_defining_ids<T1>();
        let v7 = get_token_pool(v0, &v5).config;
        let v8 = get_token_pool(v0, &v6).config;
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg3) == v7.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        assert!(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4) == v8.oracle_id, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::oracle_mismatched());
        let v9 = get_token_pool(v0, &v5).state;
        let v10 = get_token_pool(v0, &v6).state;
        assert!(v9.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        assert!(v10.is_active, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::error::token_pool_inactive());
        let v11 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::amount_to_usd(arg5, v7.liquidity_token_decimal, v1, v2);
        let (v12, v13) = calculate_swap_fee(v0, v5, arg5, v11, true);
        let (_, v15) = calculate_swap_fee(v0, v6, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v11, v8.liquidity_token_decimal, v3, v4), v11, false);
        let (v16, v17) = if (v13 > v15) {
            (v12, v13)
        } else {
            (0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v15, v7.liquidity_token_decimal, v1, v2), v15)
        };
        let v18 = 0x1::vector::empty<u64>();
        let v19 = &mut v18;
        0x1::vector::push_back<u64>(v19, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::usd_to_amount(v11 - v17, v8.liquidity_token_decimal, v3, v4));
        0x1::vector::push_back<u64>(v19, v16);
        0x1::vector::push_back<u64>(v19, v17);
        v18
    }

    fun withdraw_navi<T0>(arg0: &mut 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::Version, arg1: &mut LiquidityPool, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg1.id, b"navi_account_cap");
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg12, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg12, arg3, arg7, arg8, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg8, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v0)) as u64)) + 1, arg10, arg11, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_token_pool(arg1, &v2);
        let v4 = 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v3.state.current_lending_amount, 1) - 0;
        let v5 = if (0x2::balance::value<T0>(&v1) >= v4) {
            0x2::balance::value<T0>(&v1) - v4
        } else {
            0
        };
        let v6 = (((v5 as u128) * (v3.config.spot_config.lending_protocol_share_bp as u128) / 10000) as u64);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v1, v6));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v2), v1);
        let v7 = get_mut_token_pool(arg1, &v2);
        0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::set_u64_vector_value(&mut v7.state.current_lending_amount, 1, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v7.state.current_lending_amount, 1) - v4);
        v7.state.liquidity_amount = v7.state.liquidity_amount + 0x2::balance::value<T0>(&v1) - v4;
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::math::get_u64_vector_value(&v7.state.current_lending_amount, 1));
        0x1::vector::push_back<u64>(v9, v7.state.reserved_amount);
        0x1::vector::push_back<u64>(v9, v7.state.liquidity_amount);
        0x1::vector::push_back<u64>(v9, v5);
        0x1::vector::push_back<u64>(v9, v6);
        v8
    }

    // decompiled from Move bytecode v6
}

