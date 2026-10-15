module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lp_pool {
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

    struct SocializationKey has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct SocializeLossEvent has copy, drop {
        index: u64,
        liquidity_token_type: 0x1::type_name::TypeName,
        loss: u64,
        allocated: u64,
        remainder: u64,
        reserved_amount: u64,
        socialization_index: u64,
    }

    struct LendingSafetyBufferKey has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct LendingLossEvent has copy, drop {
        c_token_type: 0x1::type_name::TypeName,
        principal_amount: u64,
        returned_amount: u64,
        loss: u64,
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

    public fun swap<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        update_borrow_info(arg0, arg1, arg2, arg6);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let (v1, v2) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg6);
        let (v3, v4) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg6);
        let v5 = 0x2::coin::value<T0>(&arg4);
        let v6 = 0x1::type_name::with_defining_ids<T0>();
        let v7 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v6 != v7, 15);
        let v8 = get_mut_token_pool(v0, &v6);
        let v9 = v8.config;
        let v10 = get_mut_token_pool(v0, &v7);
        let v11 = v10.config;
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v9.oracle_id, 7);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v11.oracle_id, 7);
        let v12 = get_mut_token_pool(v0, &v6);
        let v13 = v12.state;
        let v14 = get_mut_token_pool(v0, &v7);
        let v15 = v14.state;
        assert!(v13.is_active, 2);
        assert!(v15.is_active, 2);
        let v16 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v5, v9.liquidity_token_decimal, v1, v2);
        let (v17, v18) = calculate_swap_fee(v0, v6, v5, v16, true);
        let (_, v20) = calculate_swap_fee(v0, v7, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v16, v11.liquidity_token_decimal, v3, v4), v16, false);
        let (v21, v22) = if (v18 > v20) {
            (v17, v18)
        } else {
            (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v20, v9.liquidity_token_decimal, v1, v2), v20)
        };
        let v23 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v16 - v22, v11.liquidity_token_decimal, v3, v4);
        assert!(v23 >= arg5, 13);
        let v24 = get_mut_token_pool(v0, &v6);
        let v25 = 0x2::coin::into_balance<T0>(arg4);
        let v26 = 0x2::balance::value<T0>(&v25);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v25, (((v21 as u128) * (v24.config.spot_config.swap_fee_protocol_share_bp as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64)));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v6), v25);
        let v27 = get_mut_token_pool(v0, &v6);
        assert!(v27.state.liquidity_amount + v26 <= v27.config.spot_config.max_capacity, 12);
        v27.state.liquidity_amount = v27.state.liquidity_amount + v26;
        update_tvl(arg0, v0, v6, arg3, arg6);
        let v28 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.id, v7), v23);
        let v29 = get_mut_token_pool(v0, &v7);
        v29.state.liquidity_amount = v29.state.liquidity_amount - 0x2::balance::value<T1>(&v28);
        assert!(v29.state.liquidity_amount >= v29.state.reserved_amount, 11);
        assert_idle_covers_reserve(v29);
        update_tvl(arg0, v0, v7, arg3, arg6);
        let v30 = SwapEvent{
            sender                  : 0x2::tx_context::sender(arg7),
            index                   : arg2,
            from_token_type         : v6,
            from_amount             : v5,
            to_token_type           : v7,
            min_to_amount           : arg5,
            actual_to_amount        : v23,
            fee_amount              : v21,
            fee_amount_usd          : v22,
            oracle_price_from_token : v1,
            oracle_price_to_token   : v3,
            u64_padding             : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SwapEvent>(v30);
        0x2::coin::from_balance<T1>(v28, arg7)
    }

    fun deposit_scallop_basic<T0>(arg0: &mut LiquidityPool, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg4);
        let v2 = get_mut_token_pool(arg0, &v0);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v2.state.current_lending_amount, 0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v2.state.current_lending_amount, 0) + 0x2::balance::value<T0>(&v1));
        let (v3, v4) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lending::deposit_scallop_basic<T0>(v1, arg1, arg2, arg3, arg5);
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
        0x1::vector::push_back<u64>(v9, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v7.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v6)));
        0x1::vector::push_back<u64>(v9, v7.state.reserved_amount);
        0x1::vector::push_back<u64>(v9, v7.state.liquidity_amount);
        0x1::vector::append<u64>(&mut v5, v8);
        v5
    }

    fun withdraw_scallop_basic<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut LiquidityPool, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        let (v1, v2) = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::lending::withdraw_scallop_basic<T0>(0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg1.id, v0), arg5), arg6), arg2, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        let v6 = get_token_pool(arg1, &v5);
        let v7 = (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v6.state.current_lending_amount, 0) as u128) * (arg5 as u128) / (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0)) as u128)) as u64);
        let v8 = if (0x2::balance::value<T0>(&v4) >= v7) {
            0x2::balance::value<T0>(&v4) - v7
        } else {
            0
        };
        if (0x2::balance::value<T0>(&v4) < v7) {
            let v9 = LendingLossEvent{
                c_token_type     : v5,
                principal_amount : v7,
                returned_amount  : 0x2::balance::value<T0>(&v4),
                loss             : v7 - 0x2::balance::value<T0>(&v4),
            };
            0x2::event::emit<LendingLossEvent>(v9);
        };
        let v10 = (((v8 as u128) * (v6.config.spot_config.lending_protocol_share_bp as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v4, v10));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v5), v4);
        let v11 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg1.id, v0));
        let v12 = get_mut_token_pool(arg1, &v5);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v12.state.current_lending_amount, 0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v12.state.current_lending_amount, 0) - v7);
        v12.state.liquidity_amount = v12.state.liquidity_amount + 0x2::balance::value<T0>(&v4) - v7;
        v12.state.update_ts_ms = 0;
        let v13 = 0x1::vector::empty<u64>();
        let v14 = &mut v13;
        0x1::vector::push_back<u64>(v14, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v12.state.current_lending_amount, 0));
        0x1::vector::push_back<u64>(v14, v11);
        0x1::vector::push_back<u64>(v14, v12.state.reserved_amount);
        0x1::vector::push_back<u64>(v14, v12.state.liquidity_amount);
        0x1::vector::push_back<u64>(v14, v8);
        0x1::vector::push_back<u64>(v14, v10);
        0x1::vector::append<u64>(&mut v3, v13);
        v3
    }

    fun accrue_borrow_(arg0: &mut LiquidityPool, arg1: u64) {
        let v0 = arg0.index;
        let v1 = arg0.liquidity_tokens;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            let v3 = get_mut_token_pool(arg0, &v2);
            let v4 = v3.config;
            let v5 = arg1 / v4.margin_config.borrow_interval_ts_ms * v4.margin_config.borrow_interval_ts_ms;
            let v6 = v3.state.last_borrow_rate_ts_ms;
            let v7 = v3.state.cumulative_borrow_rate;
            if (v5 >= v3.state.last_borrow_rate_ts_ms && v5 - v3.state.last_borrow_rate_ts_ms >= v4.margin_config.borrow_interval_ts_ms) {
                let v8 = (v5 - v3.state.last_borrow_rate_ts_ms) / v4.margin_config.borrow_interval_ts_ms;
                let v9 = if (v3.state.liquidity_amount == 0) {
                    0
                } else {
                    (((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128) * (v3.state.reserved_amount as u128) / (v3.state.liquidity_amount as u128)) as u64)
                };
                let v10 = if (v9 < v4.margin_config.utilization_threshold_bp_0) {
                    (((v4.margin_config.basic_borrow_rate_0 as u128) * (v9 as u128) / (v4.margin_config.utilization_threshold_bp_0 as u128)) as u64)
                } else if (v9 < v4.margin_config.utilization_threshold_bp_1) {
                    v4.margin_config.basic_borrow_rate_0 + (((v4.margin_config.basic_borrow_rate_1 as u128) * ((v9 - v4.margin_config.utilization_threshold_bp_0) as u128) / ((v4.margin_config.utilization_threshold_bp_1 - v4.margin_config.utilization_threshold_bp_0) as u128)) as u64)
                } else {
                    v4.margin_config.basic_borrow_rate_0 + v4.margin_config.basic_borrow_rate_1 + (((v4.margin_config.basic_borrow_rate_2 as u128) * ((v9 - v4.margin_config.utilization_threshold_bp_1) as u128) / ((0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() - v4.margin_config.utilization_threshold_bp_1) as u128)) as u64)
                };
                v3.state.previous_last_borrow_rate_ts_ms = v6;
                v3.state.previous_cumulative_borrow_rate = v7;
                let v11 = 3600000 / v4.margin_config.borrow_interval_ts_ms;
                let v12 = if (v11 == 0) {
                    1
                } else {
                    v11
                };
                let v13 = if (v8 > v12) {
                    v12
                } else {
                    v8
                };
                v3.state.cumulative_borrow_rate = v3.state.cumulative_borrow_rate + v10 * v13;
                v3.state.last_borrow_rate_ts_ms = v5;
                let v14 = UpdateBorrowInfoEvent{
                    index                           : v0,
                    liquidity_token_type            : v2,
                    previous_borrow_ts_ms           : v6,
                    previous_cumulative_borrow_rate : v7,
                    borrow_interval_ts_ms           : v4.margin_config.borrow_interval_ts_ms,
                    last_borrow_rate_ts_ms          : v3.state.last_borrow_rate_ts_ms,
                    last_cumulative_borrow_rate     : v3.state.cumulative_borrow_rate,
                    u64_padding                     : 0x1::vector::empty<u64>(),
                };
                0x2::event::emit<UpdateBorrowInfoEvent>(v14);
                continue
            };
        };
    }

    entry fun add_liquidity_token<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg23);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 18);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.liquidity_tokens, v1);
        assert!(arg5 > 0 && arg5 <= 10000, 19);
        assert!(arg6 > 0, 19);
        assert!(arg7 > 0, 19);
        assert!(arg8 <= 30, 19);
        assert!(arg9 <= 30, 19);
        assert!(arg10 <= 30, 19);
        assert!(arg11 <= 30, 19);
        assert!(arg12 <= 30, 19);
        assert!(arg13 <= 10000, 19);
        assert!(arg14 <= 10000, 19);
        let v2 = if (arg15 > 0) {
            if (arg15 < arg16) {
                arg16 < arg17
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 19);
        let v3 = if (arg18 > 0) {
            if (arg18 < arg19) {
                arg19 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 19);
        assert!(arg20 > 0, 19);
        assert!(arg21 > 0, 19);
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
            oracle_id               : 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3),
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
        let v11 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v11, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 3, arg2, v11, 0x1::vector::empty<0x2::object::ID>(), vector[], arg23);
    }

    fun assert_idle_covers_reserve(arg0: &TokenPool) {
        assert!(idle_after_lending(arg0, 0) >= (arg0.state.reserved_amount as u128), 11);
    }

    public(friend) fun assert_idle_covers_reserve_of(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) {
        assert_idle_covers_reserve(get_token_pool(arg0, &arg1));
    }

    fun burn_lp_<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps::TreasuryCaps, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg4, arg6);
        let v3 = 0x2::balance::value<T0>(&arg5);
        let v4 = get_mut_liquidity_pool(arg1, arg2);
        update_tvl(arg0, v4, v0, arg4, arg6);
        let (v5, v6, v7, v8) = calculate_burn_lp(arg1, arg2, v0, v1, v2, v3);
        let v9 = get_mut_liquidity_pool(arg1, arg2);
        let v10 = get_mut_token_pool(v9, &v0);
        v10.state.liquidity_amount = v10.state.liquidity_amount - v7 - v8;
        assert!(v10.state.liquidity_amount >= v10.state.reserved_amount, 11);
        assert_idle_covers_reserve(v10);
        let v11 = get_mut_liquidity_pool(arg1, arg2);
        v11.pool_info.total_share_supply = v11.pool_info.total_share_supply - v3;
        update_tvl(arg0, v11, v0, arg4, arg6);
        0x2::coin::burn<T0>(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps::get_mut_treasury_cap<T0>(arg3), 0x2::coin::from_balance<T0>(arg5, arg7));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_fee<T1>(arg0, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v11.id, v0), v8));
        let v12 = BurnLpEvent{
            sender                : 0x2::tx_context::sender(arg7),
            index                 : arg2,
            lp_token_type         : v11.lp_token_type,
            burn_lp_amount        : v3,
            burn_amount_usd       : v5,
            burn_fee_usd          : v6,
            liquidity_token_type  : v0,
            withdraw_token_amount : v7,
            u64_padding           : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<BurnLpEvent>(v12);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v11.id, v0), v7), arg7)
    }

    public(friend) fun calculate_burn_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = get_token_pool(v0, &arg2);
        assert!(v0.pool_info.total_share_supply > 0, 9);
        let v2 = (((arg5 as u128) * (v0.pool_info.tvl_usd as u128) / (v0.pool_info.total_share_supply as u128)) as u64);
        let v3 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::usd_to_amount(v2, v1.config.liquidity_token_decimal, arg3, arg4);
        let (v4, v5) = calculate_lp_fee(v0, arg2, v3, v2, false);
        (v2, v5, v3 - v4, v4)
    }

    public(friend) fun calculate_fee_(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = get_token_pool(arg0, &arg1);
        let v1 = v0.config.spot_config;
        let v2 = v0.state.value_in_usd;
        let v3 = if (arg0.pool_info.tvl_usd > 0) {
            (((arg0.pool_info.tvl_usd as u128) * (v1.target_weight_bp as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64)
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
            assert!(v2 >= arg3, 11);
            v2 - arg3
        };
        let v6 = if (v3 > v5) {
            v3 - v5
        } else {
            v5 - v3
        };
        let v7 = 1000000000;
        let v8 = if (v6 > v4) {
            if (v1.target_weight_bp == 0) {
                (arg5 as u256) * (v7 as u256)
            } else if (arg0.pool_info.tvl_usd == 0) {
                0
            } else if (v3 == 0) {
                (arg5 as u256) * (v7 as u256)
            } else {
                let v9 = (arg6 as u256) * ((v6 + v4) as u256) * (v7 as u256);
                let v10 = 2 * (v3 as u256);
                if (v9 / v10 * v10 == v9) {
                    v9 / v10
                } else {
                    v9 / v10 + 1
                }
            }
        } else {
            0
        };
        let v11 = if (v8 > (arg5 as u256) * (v7 as u256)) {
            (arg5 as u256) * (v7 as u256)
        } else {
            v8
        };
        let v12 = (arg5 as u256) * (v7 as u256) + v11;
        let v13 = (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u256) * (v7 as u256);
        (((((arg2 as u256) * v12 + v13 - 1) / v13) as u64), ((((arg3 as u256) * v12 + v13 - 1) / v13) as u64))
    }

    fun calculate_lending_amount_capped(arg0: &TokenPool, arg1: u64, arg2: 0x1::option::Option<u64>) : u64 {
        let v0 = idle_after_lending(arg0, 0);
        let v1 = minimum_idle(arg0, arg1);
        let v2 = if (v0 > v1) {
            ((v0 - v1) as u64)
        } else {
            0
        };
        if (0x1::option::is_none<u64>(&arg2)) {
            v2
        } else {
            let v4 = 0x1::option::extract<u64>(&mut arg2);
            if (v2 >= v4) {
                v4
            } else {
                v2
            }
        }
    }

    public(friend) fun calculate_lp_fee(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = get_token_pool(arg0, &arg1).config.spot_config;
        let (v1, v2) = if (arg4) {
            (v0.basic_mint_fee_bp, v0.additional_mint_fee_bp)
        } else {
            (v0.basic_burn_fee_bp, v0.additional_burn_fee_bp)
        };
        calculate_fee_(arg0, arg1, arg2, arg3, arg4, v1, v2)
    }

    public(friend) fun calculate_mint_lp(arg0: &Registry, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        let v0 = get_liquidity_pool(arg0, arg1);
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg5, get_token_pool(v0, &arg2).config.liquidity_token_decimal, arg3, arg4);
        let (_, v3) = calculate_lp_fee(v0, arg2, arg5, v1, true);
        assert!(v1 >= v3, 8);
        let v4 = if (v0.pool_info.total_share_supply == 0) {
            v1 - v3
        } else {
            assert!(v0.pool_info.tvl_usd > 0, 2500);
            ((((v1 - v3) as u128) * (v0.pool_info.total_share_supply as u128) / (v0.pool_info.tvl_usd as u128)) as u64)
        };
        assert!(v4 > 0, 2501);
        (v1, v3, v4)
    }

    fun calculate_swap_fee(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = get_token_pool(arg0, &arg1).config.spot_config;
        calculate_fee_(arg0, arg1, arg2, arg3, arg4, v0.swap_fee_bp, v0.swap_fee_bp)
    }

    public(friend) fun check_active(arg0: &LiquidityPool) : bool {
        arg0.pool_info.is_active
    }

    public(friend) fun check_token_pool_status<T0>(arg0: &Registry, arg1: u64, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            assert!(get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 2);
        } else {
            assert!(!get_token_pool(get_liquidity_pool(arg0, arg1), &v0).state.is_active, 2);
        };
    }

    public(friend) fun check_trading_order_size_valid(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        let v0 = get_token_pool(arg0, &arg1);
        (((v0.state.liquidity_amount as u128) * (v0.config.margin_config.max_order_reserve_ratio_bp as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64) >= arg2
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

    public fun claim<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps::TreasuryCaps, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        normal_safety_check<T1, T0>(arg0, arg1, arg2, arg4, arg5);
        update_borrow_info(arg0, arg1, arg2, arg5);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&mut v0.id, 0x1::string::utf8(b"deactivating_shares"));
        let v2 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, vector<DeactivatingShares<T0>>>(v1, v2), 17);
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
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v0.u64_padding, 0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 0) - 0x2::balance::value<T0>(&v5));
        };
        burn_lp_<T0, T1>(arg0, arg1, arg2, arg3, arg4, v5, arg5, arg6)
    }

    public fun complete_rebalancing<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: 0x2::balance::Balance<T1>, arg5: RebalanceProcess, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 2);
        assert!(v0.pool_info.is_active, 0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_token_pool(v0, &v2).config.liquidity_token_decimal;
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = get_token_pool(v0, &v4).config.liquidity_token_decimal;
        let (v6, _) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg6);
        let (v8, v9) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg6);
        let v10 = 0x1::type_name::with_defining_ids<T0>();
        let v11 = get_mut_token_pool(v0, &v10);
        assert!(v11.state.is_active, 2);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v11.config.oracle_id, 7);
        let v12 = v11.state.liquidity_amount;
        let v13 = 0x1::type_name::with_defining_ids<T1>();
        let v14 = get_mut_token_pool(v0, &v13);
        assert!(v14.state.is_active, 2);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v14.config.oracle_id, 7);
        let v15 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(0x2::balance::value<T1>(&arg4), v14.config.liquidity_token_decimal, v8, v9);
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
        } = arg5;
        assert!(arg2 == v16, 101);
        assert!(v17 == 0x1::type_name::with_defining_ids<T0>(), 101);
        assert!(v18 == v3, 101);
        assert!(v20 == v6, 101);
        assert!(v22 == 0x1::type_name::with_defining_ids<T1>(), 101);
        assert!(v23 == v5, 101);
        assert!(v24 == v8, 101);
        let v25 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale();
        assert!((((v15 as u128) * ((v25 + v1) as u128) / (v25 as u128)) as u64) >= v21, 102);
        v14.state.liquidity_amount = v14.state.liquidity_amount + 0x2::balance::value<T1>(&arg4);
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::type_name::with_defining_ids<T1>()), arg4);
        update_tvl(arg0, v0, 0x1::type_name::with_defining_ids<T1>(), arg3, arg6);
        let v26 = CompleteRebalancingEvent{
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
        0x2::event::emit<CompleteRebalancingEvent>(v26);
    }

    public(friend) fun get_borrow_rate_decimal() : u64 {
        9
    }

    public(friend) fun get_cumulative_borrow_rate(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        get_token_pool(arg0, &arg1).state.cumulative_borrow_rate
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
        abort 5
    }

    public(friend) fun get_socialization_index_scale() : u64 {
        1000000000000
    }

    public(friend) fun get_token_pool(arg0: &LiquidityPool, arg1: &0x1::type_name::TypeName) : &TokenPool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0).token_type == *arg1) {
                return 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v0)
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public(friend) fun get_token_pool_idle_amount(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        (idle_after_lending(get_token_pool(arg0, &arg1), 0) as u64)
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

    fun idle_after_lending(arg0: &TokenPool, arg1: u64) : u128 {
        let v0 = (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&arg0.state.current_lending_amount, 0) as u128) + (arg1 as u128);
        let v1 = (arg0.state.liquidity_amount as u128);
        if (v1 > v0) {
            v1 - v0
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                      : 0x2::object::new(arg0),
            num_pool                : 0,
            liquidity_pool_registry : 0x2::object::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun lending_safety_buffer_bp(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = LendingSafetyBufferKey{token_type: arg1};
        assert!(0x2::dynamic_field::exists_<LendingSafetyBufferKey>(&arg0.id, v0), 2000);
        *0x2::dynamic_field::borrow<LendingSafetyBufferKey, u64>(&arg0.id, v0)
    }

    entry fun manager_deposit_scallop<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = lending_safety_buffer_bp(v0, 0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = get_mut_token_pool(v0, &v2);
        assert!(v3.state.is_active, 2);
        let v4 = calculate_lending_amount_capped(v3, v1, arg6);
        assert!(v4 == 0 || idle_after_lending(v3, v4) >= minimum_idle(v3, v1), 2002);
        if (v4 > 0) {
            let v5 = deposit_scallop_basic<T0>(v0, arg3, arg4, arg5, v4, arg7);
            let v6 = DepositLendingEvent{
                index                     : arg2,
                lending_index             : 0,
                c_token_type              : 0x1::type_name::with_defining_ids<T0>(),
                deposit_amount            : *0x1::vector::borrow<u64>(&v5, 0),
                minted_market_coin_amount : *0x1::vector::borrow<u64>(&v5, 1),
                latest_lending_amount     : *0x1::vector::borrow<u64>(&v5, 2),
                latest_market_coin_amount : *0x1::vector::borrow<u64>(&v5, 3),
                latest_reserved_amount    : *0x1::vector::borrow<u64>(&v5, 4),
                latest_liquidity_amount   : *0x1::vector::borrow<u64>(&v5, 5),
                u64_padding               : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<DepositLendingEvent>(v6);
        };
    }

    entry fun manager_emergency_deposit<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = 0x2::balance::value<T0>(&v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v3 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::with_defining_ids<T1>() == v3.lp_token_type, 4);
        assert!(v3.pool_info.is_active, 0);
        assert!(get_token_pool(v3, &v0).state.is_active, 2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_mut_liquidity_pool(arg1, arg2).id, v0), v1);
        let v4 = ManagerDepositReceipt{
            id          : 0x2::object::new(arg4),
            index       : arg2,
            token_type  : v0,
            amount      : v2,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::public_transfer<ManagerDepositReceipt>(v4, 0x2::tx_context::sender(arg4));
        let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, v0);
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 12, arg2, v5, 0x1::vector::empty<0x2::object::ID>(), v6, arg4);
    }

    entry fun manager_emergency_withdraw<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: ManagerDepositReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let ManagerDepositReceipt {
            id          : v1,
            index       : v2,
            token_type  : v3,
            amount      : v4,
            u64_padding : _,
        } = arg3;
        0x2::object::delete(v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        assert!(v2 == arg2, 20);
        assert!(v0 == v3, 15);
        let v6 = get_liquidity_pool(arg1, arg2);
        assert!(v6.pool_info.is_active, 0);
        assert!(get_token_pool(v6, &v0).state.is_active, 2);
        let v7 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_mut_liquidity_pool(arg1, arg2).id, v0), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), 0x2::tx_context::sender(arg4));
        let v8 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v8, v0);
        let v9 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v9, 0x2::balance::value<T0>(&v7));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 13, arg2, v8, 0x1::vector::empty<0x2::object::ID>(), v9, arg4);
    }

    public fun manager_remove_all_liquidity<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!v0.pool_info.is_active, 1);
        assert!(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&get_token_pool(v0, &v1).state.current_lending_amount, 0) == 0, 2003);
        assert!(open_positions(v0, v1) == 0, 2601);
        assert!(v0.pool_info.total_share_supply == 0 && 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 0) == 0, 2701);
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.reserved_amount == 0, 2004);
        v2.state.value_in_usd = 0;
        v2.state.liquidity_amount = 0;
        v0.pool_info.tvl_usd = v0.pool_info.tvl_usd - v2.state.value_in_usd;
        let v3 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v1);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, v1, 0x2::balance::zero<T0>());
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v1);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, 0x2::balance::value<T0>(&v3));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 14, arg2, v4, 0x1::vector::empty<0x2::object::ID>(), v5, arg3);
        v3
    }

    entry fun manager_remove_liquidity_token<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        check_token_pool_status<T0>(arg1, arg2, false);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_liquidity_pool(arg1, arg2);
        assert!(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&get_token_pool(v1, &v0).state.current_lending_amount, 0) == 0, 2003);
        assert!(open_positions(v1, v0) == 0, 2601);
        let v2 = &get_token_pool(v1, &v0).state;
        assert!(v2.reserved_amount == 0 && v2.liquidity_amount == 0, 2004);
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::with_defining_ids<T0>()));
        let v3 = LendingSafetyBufferKey{token_type: v0};
        if (0x2::dynamic_field::exists_<LendingSafetyBufferKey>(&v1.id, v3)) {
            0x2::dynamic_field::remove<LendingSafetyBufferKey, u64>(&mut v1.id, v3);
        };
        let v4 = SocializationKey{token_type: v0};
        if (0x2::dynamic_field::exists_<SocializationKey>(&v1.id, v4)) {
            0x2::dynamic_field::remove<SocializationKey, u64>(&mut v1.id, v4);
        };
        let (_, v6) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v1.liquidity_tokens, &v0);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut v1.liquidity_tokens, v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<TokenPool>(&v1.token_pools)) {
            if (0x1::vector::borrow<TokenPool>(&v1.token_pools, v7).token_type == v0) {
                break
            };
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::remove<TokenPool>(&mut v1.token_pools, v7);
        v1.pool_info.tvl_usd = v1.pool_info.tvl_usd - v8.state.value_in_usd;
        let TokenPool {
            token_type : _,
            config     : _,
            state      : _,
        } = v8;
        let v12 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v12, v0);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 11, arg2, v12, 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    entry fun manager_withdraw_scallop<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg7);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        get_token_pool(v0, &v1);
        let v2 = 0x1::type_name::with_defining_ids<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>();
        let v3 = if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v0.id, v2)) {
            0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v0.id, v2))
        } else {
            0
        };
        let v4 = if (0x1::option::is_none<u64>(&arg6)) {
            v3
        } else {
            0x1::u64::min(0x1::option::extract<u64>(&mut arg6), v3)
        };
        if (v4 > 0) {
            let v5 = withdraw_scallop_basic<T0>(arg0, v0, arg3, arg4, arg5, v4, arg7);
            let v6 = WithdrawLendingEvent{
                index                       : arg2,
                lending_index               : 0,
                c_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                r_token_type                : 0x1::type_name::with_defining_ids<T0>(),
                withdraw_amount             : *0x1::vector::borrow<u64>(&v5, 0),
                withdrawn_collateral_amount : *0x1::vector::borrow<u64>(&v5, 1),
                latest_lending_amount       : *0x1::vector::borrow<u64>(&v5, 2),
                latest_market_coin_amount   : *0x1::vector::borrow<u64>(&v5, 3),
                latest_reserved_amount      : *0x1::vector::borrow<u64>(&v5, 4),
                latest_liquidity_amount     : *0x1::vector::borrow<u64>(&v5, 5),
                lending_interest            : *0x1::vector::borrow<u64>(&v5, 6),
                protocol_share              : *0x1::vector::borrow<u64>(&v5, 7),
                lending_reward              : 0,
                reward_protocol_share       : 0,
                u64_padding                 : 0x1::vector::empty<u64>(),
            };
            0x2::event::emit<WithdrawLendingEvent>(v6);
        };
    }

    fun minimum_idle(arg0: &TokenPool, arg1: u64) : u128 {
        (arg0.state.reserved_amount as u128) + (arg0.state.liquidity_amount as u128) * (arg1 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)
    }

    public fun mint_lp<T0, T1>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps::TreasuryCaps, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::into_balance<T0>(arg5);
        let v2 = 0x2::balance::value<T0>(&v1);
        normal_safety_check<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        assert!(v2 >= get_token_pool(get_liquidity_pool(arg1, arg4), &v0).config.spot_config.min_deposit, 6);
        let (v3, v4) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg6);
        update_borrow_info(arg0, arg1, arg4, arg6);
        let v5 = get_mut_liquidity_pool(arg1, arg4);
        update_tvl(arg0, v5, v0, arg3, arg6);
        let (v6, v7, v8) = calculate_mint_lp(arg1, arg4, v0, v3, v4, v2);
        let v9 = get_mut_liquidity_pool(arg1, arg4);
        v9.pool_info.total_share_supply = v9.pool_info.total_share_supply + v8;
        let v10 = 0x2::balance::split<T0>(&mut v1, (((v2 as u128) * (v7 as u128) / (v6 as u128)) as u64));
        let v11 = 0x2::balance::value<T0>(&v10);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::charge_fee<T0>(arg0, v10);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9.id, v0), v1);
        let v12 = get_mut_token_pool(v9, &v0);
        assert!(v12.state.liquidity_amount + v2 - v11 <= v12.config.spot_config.max_capacity, 12);
        v12.state.liquidity_amount = v12.state.liquidity_amount + v2 - v11;
        update_tvl(arg0, v9, v0, arg3, arg6);
        let v13 = MintLpEvent{
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
        0x2::event::emit<MintLpEvent>(v13);
        0x2::coin::mint<T1>(0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps::get_mut_treasury_cap<T1>(arg2), v8, arg7)
    }

    entry fun new_liquidity_pool<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = 0;
        while (v0 < arg1.num_pool) {
            assert!(get_liquidity_pool(arg1, v0).lp_token_type != 0x1::type_name::with_defining_ids<T0>(), 2600);
            v0 = v0 + 1;
        };
        let v1 = LiquidityPoolInfo{
            lp_token_decimal   : arg2,
            total_share_supply : 0,
            tvl_usd            : 0,
            is_active          : true,
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, arg3);
        let v4 = LiquidityPool{
            id               : 0x2::object::new(arg4),
            index            : arg1.num_pool,
            lp_token_type    : 0x1::type_name::with_defining_ids<T0>(),
            liquidity_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_pools      : 0x1::vector::empty<TokenPool>(),
            pool_info        : v1,
            u64_padding      : v2,
            bcs_padding      : 0x1::vector::empty<u8>(),
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, vector<DeactivatingShares<T0>>>>(&mut v4.id, 0x1::string::utf8(b"deactivating_shares"), 0x2::table::new<address, vector<DeactivatingShares<T0>>>(arg4));
        0x2::dynamic_object_field::add<u64, LiquidityPool>(&mut arg1.liquidity_pool_registry, arg1.num_pool, v4);
        arg1.num_pool = arg1.num_pool + 1;
        let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, 0x1::type_name::with_defining_ids<T0>());
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 0, arg1.num_pool - 1, v5, 0x1::vector::empty<0x2::object::ID>(), v6, arg4);
    }

    fun normal_safety_check<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = get_liquidity_pool(arg1, arg2);
        assert!(0x1::type_name::with_defining_ids<T1>() == v0.lp_token_type, 4);
        assert!(v0.pool_info.is_active, 0);
        assert!(check_tvl_updated(v0, arg4), 10);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_token_pool(v0, &v1);
        assert!(v2.state.is_active, 2);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v2.config.oracle_id, 7);
    }

    public(friend) fun note_position_closed<T0>(arg0: &mut LiquidityPool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut get_mut_token_pool(arg0, &v0).state;
        let v2 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v1.u64_padding, 0);
        if (v2 > 0) {
            0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v1.u64_padding, 0, v2 - 1);
        };
    }

    public(friend) fun note_position_opened<T0>(arg0: &mut LiquidityPool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut get_mut_token_pool(arg0, &v0).state;
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v1.u64_padding, 0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v1.u64_padding, 0) + 1);
    }

    public fun open_positions(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&get_token_pool(arg0, &arg1).state.u64_padding, 0)
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

    public(friend) fun order_filled<T0>(arg0: &mut LiquidityPool, arg1: bool, arg2: bool, arg3: u64, arg4: 0x2::balance::Balance<T0>) {
        if (arg1) {
            assert!(arg0.pool_info.is_active, 0);
        };
        update_reserve_amount<T0>(arg0, arg2, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg4);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg4);
    }

    public(friend) fun put_collateral<T0>(arg0: &mut LiquidityPool, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = get_mut_token_pool(arg0, &v0);
        let v2 = v1.config;
        v1.state.liquidity_amount = v1.state.liquidity_amount + 0x2::balance::value<T0>(&arg1);
        v1.state.value_in_usd = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v1.state.liquidity_amount, v2.liquidity_token_decimal, arg2, arg3);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v3 = v3 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v4).state.value_in_usd;
            v4 = v4 + 1;
        };
        arg0.pool_info.tvl_usd = v3;
    }

    public fun rebalance<T0, T1>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (RebalanceProcess, 0x2::balance::Balance<T0>) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg6);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_token_pool(v0, &v1).config.liquidity_token_decimal;
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = get_token_pool(v0, &v3).config.liquidity_token_decimal;
        let (v5, v6) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg3, arg5);
        let (v7, _) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T1>(arg3, arg5);
        let v9 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::with_defining_ids<T0>()), arg4);
        let v10 = 0x1::type_name::with_defining_ids<T0>();
        let v11 = get_mut_token_pool(v0, &v10);
        assert!(v11.state.is_active, 2);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v11.config.oracle_id, 7);
        v11.state.liquidity_amount = v11.state.liquidity_amount - 0x2::balance::value<T0>(&v9);
        assert!(v11.state.liquidity_amount >= v11.state.reserved_amount, 11);
        assert_idle_covers_reserve(v11);
        let v12 = v11.state.liquidity_amount;
        let v13 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(arg4, v2, v5, v6);
        let v14 = 0x1::type_name::with_defining_ids<T1>();
        let v15 = get_mut_token_pool(v0, &v14);
        assert!(v15.state.is_active, 2);
        assert!(0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3) == v15.config.oracle_id, 7);
        let v16 = RebalanceProcess{
            index           : arg2,
            token_type_a    : 0x1::type_name::with_defining_ids<T0>(),
            token_decimal_a : v2,
            token_amount_a  : arg4,
            oracle_price_a  : v5,
            reduced_usd     : v13,
            token_type_b    : 0x1::type_name::with_defining_ids<T1>(),
            token_decimal_b : v4,
            oracle_price_b  : v7,
        };
        update_tvl(arg0, v0, 0x1::type_name::with_defining_ids<T0>(), arg3, arg5);
        let v17 = RebalanceEvent{
            index                       : arg2,
            from_token                  : 0x1::type_name::with_defining_ids<T0>(),
            to_token                    : 0x1::type_name::with_defining_ids<T1>(),
            rebalance_amount            : arg4,
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

    public fun redeem<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        update_borrow_info(arg0, arg1, arg2, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        assert!(check_tvl_updated(v0, arg4), 10);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.lp_token_type, 4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::balance::value<T0>(&arg3);
        assert!(v2 > 0, 2702);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 1);
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
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v0.u64_padding, 0, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 0) + v2);
        let v8 = RedeemEvent{
            sender          : v1,
            index           : arg2,
            share           : v2,
            share_price     : (((v0.pool_info.tvl_usd as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_usd_decimal()) as u128) / (v0.pool_info.total_share_supply as u128)) as u64),
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
        v2.state.value_in_usd = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v2.state.liquidity_amount, v3.liquidity_token_decimal, arg2, arg3);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<TokenPool>(&arg0.token_pools)) {
            v4 = v4 + 0x1::vector::borrow<TokenPool>(&arg0.token_pools, v5).state.value_in_usd;
            v5 = v5 + 1;
        };
        arg0.pool_info.tvl_usd = v4;
        v1
    }

    entry fun resume_pool(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(!v0.pool_info.is_active, 1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v0.liquidity_tokens;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            let v4 = get_mut_token_pool(v0, &v3);
            if (v1 > v4.state.last_borrow_rate_ts_ms) {
                v4.state.last_borrow_rate_ts_ms = v1;
                continue
            };
        };
        v0.pool_info.is_active = true;
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 7, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), vector[], arg4);
    }

    entry fun resume_token_pool<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(!v2.state.is_active, 2);
        v2.state.is_active = true;
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_defining_ids<T0>());
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 9, arg2, v3, 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    public(friend) fun safety_check(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName, arg2: address) {
        assert!(check_active(arg0), 0);
        assert!(oracle_matched(arg0, arg1, arg2), 7);
    }

    entry fun set_lending_safety_buffer<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        assert!(arg3 <= 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 2001);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        get_token_pool(v0, &v1);
        let v2 = LendingSafetyBufferKey{token_type: v1};
        let v3 = vector[];
        if (0x2::dynamic_field::exists_<LendingSafetyBufferKey>(&v0.id, v2)) {
            0x1::vector::push_back<u64>(&mut v3, 0x2::dynamic_field::remove<LendingSafetyBufferKey, u64>(&mut v0.id, v2));
        };
        0x2::dynamic_field::add<LendingSafetyBufferKey, u64>(&mut v0.id, v2, arg3);
        0x1::vector::push_back<u64>(&mut v3, arg3);
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 10, arg2, v4, 0x1::vector::empty<0x2::object::ID>(), v3, arg4);
    }

    public(friend) fun socialization_index(arg0: &LiquidityPool, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = SocializationKey{token_type: arg1};
        if (0x2::dynamic_field::exists_<SocializationKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<SocializationKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public(friend) fun socialize_loss<T0>(arg0: &mut LiquidityPool, arg1: u64) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_token_pool(arg0, &v0).state.reserved_amount;
        if (arg1 == 0 || v1 == 0) {
            return 0
        };
        let v2 = (1000000000000 as u128);
        let v3 = (0x1::u64::min(arg1, v1) as u128) * v2 / (v1 as u128);
        let v4 = ((v3 * (v1 as u128) / v2) as u64);
        if (v4 == 0) {
            return 0
        };
        let v5 = SocializationKey{token_type: v0};
        if (!0x2::dynamic_field::exists_<SocializationKey>(&arg0.id, v5)) {
            0x2::dynamic_field::add<SocializationKey, u64>(&mut arg0.id, v5, 0);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<SocializationKey, u64>(&mut arg0.id, v5);
        let v7 = (v3 as u64);
        let v8 = if (*v6 > 18446744073709551615 - v7) {
            18446744073709551615
        } else {
            *v6 + v7
        };
        *v6 = v8;
        let v9 = SocializeLossEvent{
            index                : arg0.index,
            liquidity_token_type : v0,
            loss                 : arg1,
            allocated            : v4,
            remainder            : arg1 - v4,
            reserved_amount      : v1,
            socialization_index  : *v6,
        };
        0x2::event::emit<SocializeLossEvent>(v9);
        v4
    }

    entry fun suspend_pool(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        accrue_borrow_(v0, 0x2::clock::timestamp_ms(arg3));
        v0.pool_info.is_active = false;
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 6, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), vector[], arg4);
    }

    entry fun suspend_token_pool<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = get_mut_token_pool(v0, &v1);
        assert!(v2.state.is_active, 2);
        v2.state.is_active = false;
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_defining_ids<T0>());
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 8, arg2, v3, 0x1::vector::empty<0x2::object::ID>(), vector[], arg3);
    }

    public(friend) fun token_pool_is_active(arg0: &TokenPool) : bool {
        arg0.state.is_active
    }

    public fun update_borrow_info(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        if (!v0.pool_info.is_active) {
            return
        };
        accrue_borrow_(v0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun update_liquidity_value<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        get_token_pool(v0, &v1);
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

    entry fun update_margin_config<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg10);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 5);
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
            assert!(*0x1::option::borrow<u64>(&arg8) > 0, 19);
            v2.config.margin_config.borrow_interval_ts_ms = *0x1::option::borrow<u64>(&arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) > 0, 19);
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
        assert!(v3, 19);
        let v4 = if (v2.config.margin_config.utilization_threshold_bp_0 > 0) {
            if (v2.config.margin_config.utilization_threshold_bp_0 < v2.config.margin_config.utilization_threshold_bp_1) {
                v2.config.margin_config.utilization_threshold_bp_1 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 19);
        let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 5, arg2, v5, 0x1::vector::empty<0x2::object::ID>(), vector[], arg10);
    }

    entry fun update_rebalance_cost_threshold_bp(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        assert!(arg3 >= 0 && arg3 < 100, 19);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v0.u64_padding, 2, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 2));
        0x1::vector::push_back<u64>(v2, arg3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 2, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), v1, arg4);
    }

    public(friend) fun update_reserve_amount<T0>(arg0: &mut LiquidityPool, arg1: bool, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = get_mut_token_pool(arg0, &v0);
        if (arg1) {
            v1.state.reserved_amount = v1.state.reserved_amount + arg2;
        } else {
            assert!(v1.state.reserved_amount >= arg2, 21);
            v1.state.reserved_amount = v1.state.reserved_amount - arg2;
        };
    }

    entry fun update_spot_config<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg13);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0.liquidity_tokens, &v1), 5);
        let v2 = get_mut_token_pool(v0, &v1);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) > 0 && *0x1::option::borrow<u64>(&arg3) <= 10000, 19);
            v2.config.spot_config.target_weight_bp = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg4) > 0, 19);
            v2.config.spot_config.min_deposit = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(*0x1::option::borrow<u64>(&arg5) > 0, 19);
            v2.config.spot_config.max_capacity = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) <= 30, 19);
            v2.config.spot_config.basic_mint_fee_bp = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(*0x1::option::borrow<u64>(&arg7) <= 30, 19);
            v2.config.spot_config.additional_mint_fee_bp = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            assert!(*0x1::option::borrow<u64>(&arg8) <= 30, 19);
            v2.config.spot_config.basic_burn_fee_bp = *0x1::option::borrow<u64>(&arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) <= 30, 19);
            v2.config.spot_config.additional_burn_fee_bp = *0x1::option::borrow<u64>(&arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            assert!(*0x1::option::borrow<u64>(&arg10) <= 30, 19);
            v2.config.spot_config.swap_fee_bp = *0x1::option::borrow<u64>(&arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            assert!(*0x1::option::borrow<u64>(&arg11) <= 10000, 19);
            v2.config.spot_config.swap_fee_protocol_share_bp = *0x1::option::borrow<u64>(&arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            assert!(*0x1::option::borrow<u64>(&arg12) <= 10000, 19);
            v2.config.spot_config.lending_protocol_share_bp = *0x1::option::borrow<u64>(&arg12);
        };
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 4, arg2, v3, 0x1::vector::empty<0x2::object::ID>(), vector[], arg13);
    }

    fun update_tvl(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut LiquidityPool, arg2: 0x1::type_name::TypeName, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let (v1, v2) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price_by_type(arg3, arg2, arg4);
        let v3 = get_mut_token_pool(arg1, &arg2);
        let v4 = v3.config;
        assert!(v4.oracle_id == 0x2::object::id_address<0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle>(arg3), 7);
        v3.state.value_in_usd = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::amount_to_usd(v3.state.liquidity_amount, v4.liquidity_token_decimal, v1, v2);
        v3.state.update_ts_ms = 0x2::clock::timestamp_ms(arg4);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v3.state.value_in_usd);
        arg1.pool_info.tvl_usd = arg1.pool_info.tvl_usd + v3.state.value_in_usd - v3.state.value_in_usd;
        0x1::vector::push_back<u64>(&mut v0, arg1.pool_info.tvl_usd);
        v0
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg4);
        let v0 = get_mut_liquidity_pool(arg1, arg2);
        assert!(v0.pool_info.is_active, 0);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::set_u64_vector_value(&mut v0.u64_padding, 1, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_u64_vector_value(&v0.u64_padding, 1));
        0x1::vector::push_back<u64>(v2, arg3);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(0, 1, arg2, 0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x2::object::ID>(), v1, arg4);
    }

    // decompiled from Move bytecode v7
}

