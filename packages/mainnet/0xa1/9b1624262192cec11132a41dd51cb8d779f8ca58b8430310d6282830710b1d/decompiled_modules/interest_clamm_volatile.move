module 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_clamm_volatile {
    struct CoinState has copy, drop, store {
        index: u64,
        price: u256,
        price_oracle: u256,
        last_price: u256,
        decimals_scalar: u256,
        type_name: 0x1::type_name::TypeName,
    }

    struct AGamma has copy, store {
        a: u256,
        gamma: u256,
        future_a: u256,
        future_gamma: u256,
        initial_time: u64,
        future_time: u64,
    }

    struct RebalancingParams has copy, store {
        extra_profit: u256,
        adjustment_step: u256,
        ma_half_time: u256,
    }

    struct Fees has copy, store {
        mid_fee: u256,
        out_fee: u256,
        gamma_fee: u256,
        admin_fee: u256,
    }

    struct StateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        d: u256,
        lp_coin_supply: 0x2::balance::Supply<T0>,
        n_coins: u256,
        balances: vector<u256>,
        a_gamma: AGamma,
        xcp_profit: u256,
        xcp_profit_a: u256,
        virtual_price: u256,
        rebalancing_params: RebalancingParams,
        fees: Fees,
        last_prices_timestamp: u64,
        min_a: u256,
        max_a: u256,
        not_adjusted: bool,
        version: u256,
        coin_states: 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinState>,
        coin_balances: 0x2::bag::Bag,
        admin_balance: 0x2::balance::Balance<T0>,
    }

    struct BalancesRequest {
        coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        state_id: address,
        version: u256,
    }

    public fun swap<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_swap_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_swap_hooks());
        swap_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun a<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (v1, _) = get_a_gamma<T0>(load<T0>(v0), arg1);
        v1
    }

    fun add_liquidity<T0>(arg0: &mut StateV1<T0>, arg1: &0x2::clock::Clock, arg2: vector<CoinState>, arg3: vector<u256>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = add_liquidity_impl<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 >= arg4, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::slippage());
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_coin_supply, v0), arg5)
    }

    public fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_add_liquidity_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_add_liquidity_hooks());
        add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun add_liquidity_2_pool_impl<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T0>(&arg2) != 0 || 0x2::coin::value<T1>(&arg3) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_supply_one_coin());
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert!(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::are_coins_ordered<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, v0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::coins_must_be_in_order());
        let (v2, v3) = state_and_coin_states_mut<T2>(arg0);
        let v4 = v2.balances;
        deposit_coin<T0, T2>(v2, arg2);
        deposit_coin<T1, T2>(v2, arg3);
        add_liquidity<T2>(v2, arg1, v3, v4, arg4, arg5)
    }

    public fun add_liquidity_2_pool_with_hooks<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T2>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_add_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg2);
        (v0, add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5, arg6))
    }

    public fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_add_liquidity_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_add_liquidity_hooks());
        add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0x2::coin::value<T0>(&arg2) != 0 || 0x2::coin::value<T1>(&arg3) != 0 || 0x2::coin::value<T2>(&arg4) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_supply_one_coin());
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert!(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::are_coins_ordered<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, v0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::coins_must_be_in_order());
        let (v2, v3) = state_and_coin_states_mut<T3>(arg0);
        let v4 = v2.balances;
        deposit_coin<T0, T3>(v2, arg2);
        deposit_coin<T1, T3>(v2, arg3);
        deposit_coin<T2, T3>(v2, arg4);
        add_liquidity<T3>(v2, arg1, v3, v4, arg5, arg6)
    }

    public fun add_liquidity_3_pool_with_hooks<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T3>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_add_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg2);
        (v0, add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, arg6, arg7))
    }

    fun add_liquidity_impl<T0>(arg0: &mut StateV1<T0>, arg1: &0x2::clock::Clock, arg2: vector<CoinState>, arg3: vector<u256>) : u64 {
        let v0 = vector[];
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::empty_vector(arg0.n_coins);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 15;
        let v4 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins);
        let v5 = arg0.balances;
        let v6 = arg0.balances;
        let (v7, v8) = get_a_gamma<T0>(arg0, arg1);
        let v9 = 0;
        while (v4 > v9) {
            let v10 = 0x1::vector::borrow_mut<u256>(&mut arg3, v9);
            let v11 = 0x1::vector::borrow_mut<u256>(&mut v5, v9);
            0x1::vector::push_back<u256>(&mut v0, *v11 - *v10);
            if (*v11 - *v10 != 0) {
                let v12 = if (v3 == 15) {
                    v9
                } else {
                    15 - 1
                };
                v3 = v12;
            };
            v9 = v9 + 1;
        };
        let v13 = 1;
        while (v4 > v13) {
            let v14 = 0x1::vector::borrow_mut<u256>(&mut arg3, v13);
            let v15 = 0x1::vector::borrow_mut<u256>(&mut v5, v13);
            let v16 = 0x1::vector::borrow<CoinState>(&arg2, v13);
            *v14 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*v14, v16.price);
            *v15 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*v15, v16.price);
            v13 = v13 + 1;
        };
        let v17 = 0;
        while (v4 > v17) {
            let v18 = *0x1::vector::borrow_mut<u256>(&mut v5, v17) - *0x1::vector::borrow_mut<u256>(&mut arg3, v17);
            if (v18 != 0) {
                *0x1::vector::borrow_mut<u256>(&mut v1, v17) = v18;
            };
            v17 = v17 + 1;
        };
        assert!(v3 != 15, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_supply_one_coin());
        let v19 = if (arg0.a_gamma.future_time != 0) {
            if (v2 >= arg0.a_gamma.future_time) {
                arg0.a_gamma.future_time = 1;
            };
            0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v7, v8, arg3)
        } else {
            arg0.d
        };
        let v20 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v7, v8, v5);
        let v21 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&arg0.lp_coin_supply)) * 1000000000;
        let v22 = if (v19 != 0) {
            v21 * v20 / v19 - v21
        } else {
            xcp_impl<T0>(arg0, arg2, v20)
        };
        let v23 = v22 / 1000000000 * 1000000000;
        let v24 = v23;
        assert!(v23 != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::expected_a_non_zero_value());
        if (v19 != 0) {
            let v25 = v23 - 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up(calculate_fee<T0>(arg0, v1, v5), v23, 10000000000);
            v24 = v25;
            let v26 = v21 + v25;
            let v27 = 0;
            if (v25 > 1000 && v4 > v3) {
                let v28 = 0;
                let v29 = 0;
                while (v4 > v29) {
                    let v30 = 0x1::vector::borrow<CoinState>(&arg2, v29);
                    if (v29 != v3) {
                        if (v29 == 0) {
                            v28 = v28 + 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<u256>(v6);
                        } else {
                            v28 = v28 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*0x1::vector::borrow<u256>(&v6, v29), v30.last_price);
                        };
                    };
                    v29 = v29 + 1;
                };
                v27 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v28 * v25 / v26, *0x1::vector::borrow<u256>(&v0, v3) - v25 * *0x1::vector::borrow<u256>(&v6, v3) / v26);
            };
            tweak_price<T0>(arg0, arg2, v2, v7, v8, v5, v3, v27, v20, v26);
        } else {
            arg0.d = v20;
            arg0.virtual_price = 1000000000000000000;
            arg0.xcp_profit = 1000000000000000000;
        };
        increment_version<T0>(arg0);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(v24 / 1000000000)
    }

    public fun adjustment_step<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).rebalancing_params.adjustment_step
    }

    public fun admin_fee<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).fees.admin_fee
    }

    public fun balances<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : vector<u256> {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).balances
    }

    public fun balances_in_price<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : vector<u256> {
        let (v0, v1) = state_and_coin_states<T0>(arg0);
        balances_in_price_impl<T0>(v0, v1)
    }

    fun balances_in_price_impl<T0>(arg0: &StateV1<T0>, arg1: vector<CoinState>) : vector<u256> {
        let v0 = arg0.balances;
        let v1 = 1;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins) > v1) {
            let v2 = 0x1::vector::borrow_mut<u256>(&mut v0, v1);
            *v2 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*v2, 0x1::vector::borrow<CoinState>(&arg1, v1).price);
            v1 = v1 + 1;
        };
        v0
    }

    public fun balances_request<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : BalancesRequest {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load<T0>(v0);
        BalancesRequest{
            coins    : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            state_id : 0x2::object::id_address<StateV1<T0>>(v1),
            version  : v1.version,
        }
    }

    fun calculate_fee<T0>(arg0: &StateV1<T0>, arg1: vector<u256>, arg2: vector<u256>) : u256 {
        let v0 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sum(arg1);
        let v1 = 0;
        let v2 = 0;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins) > v1) {
            v2 = v2 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(*0x1::vector::borrow<u256>(&arg1, v1), v0 / arg0.n_coins);
            v1 = v1 + 1;
        };
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up(fee_impl<T0>(arg0, arg2), arg0.n_coins, 4 * (arg0.n_coins - 1)) * v2 / v0 + 100000
    }

    fun calculate_remove_one_coin_impl<T0, T1>(arg0: &StateV1<T1>, arg1: u256, arg2: u256, arg3: vector<CoinState>, arg4: u256, arg5: bool, arg6: bool) : (u256, u256, u256, vector<u256>, u64) {
        let v0 = arg0.balances;
        let v1 = 1;
        let v2 = 1000000000000000000;
        let v3 = 0;
        let v4 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins);
        while (v4 > v1) {
            let v5 = 0x1::vector::borrow<CoinState>(&arg3, v1);
            let v6 = 0x1::vector::borrow_mut<u256>(&mut v0, v1);
            if (v5.type_name == 0x1::type_name::get<T0>()) {
                v2 = v5.price;
                v3 = v5.index;
            };
            *v6 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*v6, v5.price);
            v1 = v1 + 1;
        };
        assert!(v3 != 300, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::invalid_coin_type());
        let v7 = if (arg5) {
            0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(arg1, arg2, v0)
        } else {
            arg0.d
        };
        let v8 = arg4 * v7 / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T1>(&arg0.lp_coin_supply)) * 1000000000;
        let v9 = v7 - v8 - 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up(fee_impl<T1>(arg0, v0), v8, 20000000000);
        let v10 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::y(arg1, arg2, &v0, v9, v3);
        let v11 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(*0x1::vector::borrow<u256>(&v0, v3) - v10, v2);
        *0x1::vector::borrow_mut<u256>(&mut v0, v3) = v10;
        let v12 = 0;
        if (arg6 && v11 > 100000 && arg4 > 100000) {
            let v13 = 0;
            let v14 = 0;
            while (v4 > v14) {
                if (v14 != v3) {
                    let v15 = if (v14 == 0) {
                        v13 + 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<u256>(arg0.balances)
                    } else {
                        v13 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*0x1::vector::borrow<u256>(&arg0.balances, v14), 0x1::vector::borrow<CoinState>(&arg3, v14).last_price)
                    };
                    v13 = v15;
                };
                v14 = v14 + 1;
            };
            v12 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v13 * v8 / v7, v11 - v8 * *0x1::vector::borrow<u256>(&arg0.balances, v3) / v7);
        };
        (v11, v12, v9, v0, v3)
    }

    public fun claim_admin_fees<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock, arg3: BalancesRequest, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::assert_pool_admin<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let (v0, v1) = state_and_coin_states_mut<T0>(arg0);
        claim_admin_fees_impl<T0>(v0, arg2, arg3, v1);
        increment_version<T0>(v0);
        let v2 = 0x2::balance::value<T0>(&v0.admin_balance);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_claim_admin_fees<T0>(v2);
        0x2::coin::take<T0>(&mut v0.admin_balance, v2, arg4)
    }

    fun claim_admin_fees_impl<T0>(arg0: &mut StateV1<T0>, arg1: &0x2::clock::Clock, arg2: BalancesRequest, arg3: vector<CoinState>) {
        let (v0, v1) = get_a_gamma<T0>(arg0, arg1);
        let v2 = arg0.xcp_profit;
        let v3 = arg0.xcp_profit_a;
        let v4 = arg0.virtual_price;
        let BalancesRequest {
            coins    : v5,
            state_id : v6,
            version  : v7,
        } = arg2;
        let v8 = v5;
        let v9 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins);
        assert!(0x2::object::id_address<StateV1<T0>>(arg0) == v6, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::wrong_pool_id());
        assert!(arg0.version == v7, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::version_was_updated());
        assert!(v9 == 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v8), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::missing_coin_balance());
        let v10 = 0;
        while (v9 > v10) {
            *0x1::vector::borrow_mut<u256>(&mut arg0.balances, v10) = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&v8, &0x1::vector::borrow<CoinState>(&arg3, v10).type_name);
            v10 = v10 + 1;
        };
        if (v2 > v3) {
            let v11 = (v2 - v3) * arg0.fees.admin_fee / 20000000000;
            if (v11 != 0) {
                0x2::balance::join<T0>(&mut arg0.admin_balance, 0x2::balance::increase_supply<T0>(&mut arg0.lp_coin_supply, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_up(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&arg0.lp_coin_supply)) * 1000000000, 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_up(v4, v4 - v11) - 1000000000000000000) / 1000000000)));
                arg0.xcp_profit = v2 - v11 * 2;
            };
        };
        arg0.virtual_price = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(xcp_impl<T0>(arg0, arg3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v0, v1, balances_in_price_impl<T0>(arg0, arg3))), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&arg0.lp_coin_supply)) * 1000000000);
        if (arg0.xcp_profit > v3) {
            arg0.xcp_profit_a = arg0.xcp_profit;
        };
    }

    public fun coin_balance<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        0x2::balance::value<T0>(coin_balance_impl<T0, T1>(load<T1>(v0)))
    }

    fun coin_balance_impl<T0, T1>(arg0: &StateV1<T1>) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.coin_balances, 0x1::type_name::get<T0>())
    }

    fun coin_balance_mut<T0, T1>(arg0: &mut StateV1<T1>) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coin_balances, 0x1::type_name::get<T0>())
    }

    public fun coin_decimals_scalar<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.decimals_scalar
    }

    public fun coin_index<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.index
    }

    public fun coin_last_price<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.last_price
    }

    public fun coin_price<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.price
    }

    public fun coin_price_oracle<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.price_oracle
    }

    fun coin_state<T0, T1>(arg0: &StateV1<T1>) : CoinState {
        let v0 = 0x1::type_name::get<T0>();
        *coin_state_with_key<T1>(arg0, &v0)
    }

    fun coin_state_vector_in_order<T0>(arg0: &StateV1<T0>, arg1: vector<0x1::type_name::TypeName>) : vector<CoinState> {
        let v0 = 0x1::vector::empty<CoinState>();
        let v1 = 0;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins) > v1) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v1);
            0x1::vector::push_back<CoinState>(&mut v0, *coin_state_with_key<T0>(arg0, &v2));
            v1 = v1 + 1;
        };
        v0
    }

    fun coin_state_with_key<T0>(arg0: &StateV1<T0>, arg1: &0x1::type_name::TypeName) : &CoinState {
        0x2::vec_map::get<0x1::type_name::TypeName, CoinState>(&arg0.coin_states, arg1)
    }

    fun coin_state_with_key_mut<T0>(arg0: &mut StateV1<T0>, arg1: &0x1::type_name::TypeName) : &mut CoinState {
        0x2::vec_map::get_mut<0x1::type_name::TypeName, CoinState>(&mut arg0.coin_states, arg1)
    }

    public fun coin_type<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : 0x1::type_name::TypeName {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = coin_state<T0, T1>(load<T1>(v0));
        v1.type_name
    }

    fun deposit_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::coin::value<T0>(&arg1));
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v1 = coin_state<T0, T1>(arg0);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v1.index);
        *v2 = *v2 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v0, v1.decimals_scalar);
        0x2::balance::join<T0>(coin_balance_mut<T0, T1>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun donate<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>) {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_donate_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_donate_hooks());
        donate_impl<T0, T1>(arg0, arg1, arg2);
    }

    fun donate_impl<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_coin());
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (v2, v3) = state_and_coin_states_mut<T1>(arg0);
        let v4 = v2.balances;
        deposit_coin<T0, T1>(v2, arg2);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_donate<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1>(v1, v0);
        add_liquidity_impl<T1>(v2, arg1, v3, v4);
    }

    public fun donate_with_hooks<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>) : 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_donate<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        donate_impl<T0, T1>(arg0, arg2, arg3);
        v0
    }

    public fun extra_profit<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).rebalancing_params.extra_profit
    }

    public fun fee<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = balances_in_price<T0>(arg0);
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        fee_impl<T0>(load<T0>(v1), v0)
    }

    fun fee_impl<T0>(arg0: &StateV1<T0>, arg1: vector<u256>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::reduction_coefficient(arg1, arg0.fees.gamma_fee);
        (arg0.fees.mid_fee * v0 + arg0.fees.out_fee * (1000000000000000000 - v0)) / 1000000000000000000
    }

    public fun future_a<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).a_gamma.future_a
    }

    public fun future_gamma<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).a_gamma.future_gamma
    }

    public fun future_time<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).a_gamma.future_time
    }

    public fun gamma<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (_, v2) = get_a_gamma<T0>(load<T0>(v0), arg1);
        v2
    }

    public fun gamma_fee<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).fees.gamma_fee
    }

    fun get_a_gamma<T0>(arg0: &StateV1<T0>, arg1: &0x2::clock::Clock) : (u256, u256) {
        let v0 = arg0.a_gamma.future_time;
        let v1 = arg0.a_gamma.future_gamma;
        let v2 = v1;
        let v3 = arg0.a_gamma.future_a;
        let v4 = v3;
        let v5 = 0x2::clock::timestamp_ms(arg1);
        if (v0 > v5) {
            let v6 = arg0.a_gamma.initial_time;
            let v7 = v0 - v6;
            let v8 = v5 - v6;
            let v9 = v7 - v8;
            v4 = (arg0.a_gamma.a * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v9) + v3 * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v8)) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v7);
            v2 = (arg0.a_gamma.gamma * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v9) + v1 * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v8)) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v7);
        };
        (v4, v2)
    }

    fun increment_version<T0>(arg0: &mut StateV1<T0>) {
        let v0 = if (arg0.version == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            0
        } else {
            arg0.version + 1
        };
        arg0.version = v0;
    }

    public fun initial_time<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).a_gamma.initial_time
    }

    public fun invariant_<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).d
    }

    public fun last_prices_timestamp<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).last_prices_timestamp
    }

    fun load<T0>(arg0: &mut 0x2::versioned::Versioned) : &StateV1<T0> {
        maybe_upgrade_state_to_latest(arg0);
        0x2::versioned::load_value<StateV1<T0>>(arg0)
    }

    fun load_mut<T0>(arg0: &mut 0x2::versioned::Versioned) : &mut StateV1<T0> {
        maybe_upgrade_state_to_latest(arg0);
        0x2::versioned::load_value_mut<StateV1<T0>>(arg0)
    }

    public fun lp_coin_price<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let (v0, v1) = state_and_coin_states<T0>(arg0);
        1000000000 * xcp_impl<T0>(v0, v1, v0.d) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&v0.lp_coin_supply))
    }

    public fun lp_coin_supply<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u64 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        0x2::balance::supply_value<T0>(&load<T0>(v0).lp_coin_supply)
    }

    public fun ma_half_time<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).rebalancing_params.ma_half_time
    }

    public fun max_a<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).max_a
    }

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x2::versioned::Versioned) {
        assert!(0x2::versioned::version(arg0) == 1, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::invalid_version());
    }

    public fun mid_fee<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).fees.mid_fee
    }

    public fun min_a<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).min_a
    }

    public fun n_coins<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).n_coins
    }

    public fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::balance::Supply<T2>, arg5: vector<u256>, arg6: vector<u256>, arg7: u256, arg8: vector<u256>, arg9: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let (v2, v3) = new_pool<T2>(arg0, v0, arg1, arg4, vector[0, 0], arg5, arg6, arg8, arg9);
        let v4 = v2;
        let v5 = &mut v4;
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_new_2_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(&v4));
        (v4, v3, register_2_pool<T0, T1, T2>(v5, arg0, arg2, arg3, arg1, arg7, arg9))
    }

    public fun new_2_pool_with_hooks<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::HooksBuilder, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::balance::Supply<T2>, arg6: vector<u256>, arg7: vector<u256>, arg8: u256, arg9: vector<u256>, arg10: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let (v2, v3) = new_pool_with_hooks<T2>(arg0, arg2, v0, arg1, arg5, vector[0, 0], arg6, arg7, arg9, arg10);
        let v4 = v2;
        let v5 = &mut v4;
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_new_2_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(&v4));
        (v4, v3, register_2_pool<T0, T1, T2>(v5, arg0, arg3, arg4, arg1, arg8, arg10))
    }

    public fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::balance::Supply<T3>, arg6: vector<u256>, arg7: vector<u256>, arg8: vector<u256>, arg9: vector<u256>, arg10: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let (v2, v3) = new_pool<T3>(arg0, v0, arg1, arg5, vector[0, 0, 0], arg6, arg7, arg9, arg10);
        let v4 = v2;
        let v5 = &mut v4;
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_new_3_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2, T3>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(&v4));
        (v4, v3, register_3_pool<T0, T1, T2, T3>(v5, arg0, arg2, arg3, arg4, arg1, arg8, arg10))
    }

    public fun new_3_pool_with_hooks<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::HooksBuilder, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::balance::Supply<T3>, arg7: vector<u256>, arg8: vector<u256>, arg9: vector<u256>, arg10: vector<u256>, arg11: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let (v2, v3) = new_pool_with_hooks<T3>(arg0, arg2, v0, arg1, arg6, vector[0, 0, 0], arg7, arg8, arg10, arg11);
        let v4 = v2;
        let v5 = &mut v4;
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_new_3_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2, T3>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(&v4));
        (v4, v3, register_3_pool<T0, T1, T2, T3>(v5, arg0, arg3, arg4, arg5, arg1, arg9, arg11))
    }

    fun new_pool<T0>(arg0: &0x2::clock::Clock, arg1: vector<0x1::type_name::TypeName>, arg2: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg3: 0x2::balance::Supply<T0>, arg4: vector<u256>, arg5: vector<u256>, arg6: vector<u256>, arg7: vector<u256>, arg8: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin) {
        let v0 = new_state_v1<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::new<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::make_coins_vec_set_from_vector(arg1), 0x2::versioned::create<StateV1<T0>>(1, v0, arg8), arg8)
    }

    fun new_pool_with_hooks<T0>(arg0: &0x2::clock::Clock, arg1: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::HooksBuilder, arg2: vector<0x1::type_name::TypeName>, arg3: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg4: 0x2::balance::Supply<T0>, arg5: vector<u256>, arg6: vector<u256>, arg7: vector<u256>, arg8: vector<u256>, arg9: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin) {
        let v0 = new_state_v1<T0>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::new_with_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::make_coins_vec_set_from_vector(arg2), 0x2::versioned::create<StateV1<T0>>(1, v0, arg9), arg1, arg9)
    }

    fun new_state_v1<T0>(arg0: &0x2::clock::Clock, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: 0x2::balance::Supply<T0>, arg3: vector<u256>, arg4: vector<u256>, arg5: vector<u256>, arg6: vector<u256>, arg7: &mut 0x2::tx_context::TxContext) : StateV1<T0> {
        assert!(0x2::balance::supply_value<T0>(&arg2) == 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::supply_must_have_zero_value());
        assert!(0x1::vector::length<u256>(&arg5) == 3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_have_3_values());
        assert!(0x1::vector::length<u256>(&arg6) == 3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_have_3_values());
        assert!(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::decimals<T0>(arg1) == 9, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::must_have_9_decimals());
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (v1, v2) = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::vector_2_to_tuple(arg4);
        let (v3, v4, v5) = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::vector_3_to_tuple(arg5);
        let (v6, v7, v8) = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::vector_3_to_tuple(arg6);
        let v9 = 0x1::vector::length<u256>(&arg3);
        let v10 = AGamma{
            a            : v1,
            gamma        : v2,
            future_a     : v1,
            future_gamma : v2,
            initial_time : v0,
            future_time  : 0,
        };
        let v11 = RebalancingParams{
            extra_profit    : v3,
            adjustment_step : v4,
            ma_half_time    : v5,
        };
        let v12 = Fees{
            mid_fee   : v6,
            out_fee   : v7,
            gamma_fee : v8,
            admin_fee : 2000000000,
        };
        StateV1<T0>{
            id                    : 0x2::object::new(arg7),
            d                     : 0,
            lp_coin_supply        : arg2,
            n_coins               : 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v9),
            balances              : arg3,
            a_gamma               : v10,
            xcp_profit            : 0,
            xcp_profit_a          : 1000000000000000000,
            virtual_price         : 0,
            rebalancing_params    : v11,
            fees                  : v12,
            last_prices_timestamp : v0,
            min_a                 : 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::min_a(v9),
            max_a                 : 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::max_a(v9),
            not_adjusted          : false,
            version               : 0,
            coin_states           : 0x2::vec_map::empty<0x1::type_name::TypeName, CoinState>(),
            coin_balances         : 0x2::bag::new(arg7),
            admin_balance         : 0x2::balance::zero<T0>(),
        }
    }

    public fun not_adjusted<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : bool {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).not_adjusted
    }

    public fun out_fee<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).fees.out_fee
    }

    public fun quote_add_liquidity<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: vector<u64>) : u64 {
        let (v0, v1) = state_and_coin_states<T0>(arg0);
        let v2 = v1;
        let v3 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&v0.lp_coin_supply)) * 1000000000;
        let v4 = v0.balances;
        let (v5, v6) = get_a_gamma<T0>(v0, arg1);
        let v7 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::empty_vector(v0.n_coins);
        let v8 = balances_in_price_impl<T0>(v0, v2);
        let v9 = if (v0.a_gamma.future_time != 0) {
            0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v5, v6, v8)
        } else {
            v0.d
        };
        let v10 = vector[];
        let v11 = 0;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(v0.n_coins) > v11) {
            let v12 = 0x1::vector::borrow_mut<u256>(&mut v4, v11);
            let v13 = 0x1::vector::borrow<CoinState>(&v2, v11);
            let v14 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(*0x1::vector::borrow<u64>(&arg2, v11));
            *v12 = *v12 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v14, v13.decimals_scalar);
            let v15 = if (v11 == 0) {
                *v12
            } else {
                0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(*v12, v13.price)
            };
            0x1::vector::push_back<u256>(&mut v10, v15);
            let v16 = v15 - *0x1::vector::borrow<u256>(&v8, v11);
            if (v16 != 0) {
                *0x1::vector::borrow_mut<u256>(&mut v7, v11) = v16;
            };
            v11 = v11 + 1;
        };
        let (v17, v18) = get_a_gamma<T0>(v0, arg1);
        let v19 = if (v9 != 0) {
            v3 * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v17, v18, v10) / v9 - v3
        } else {
            xcp_impl<T0>(v0, v2, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v17, v18, v10))
        };
        let v20 = v19 / 1000000000 * 1000000000;
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64((v20 - 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up(calculate_fee<T0>(v0, v7, v10), v20, 10000000000)) / 1000000000)
    }

    public fun quote_remove_liquidity<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: u64) : vector<u64> {
        let (v0, v1) = state_and_coin_states<T0>(arg0);
        let v2 = v1;
        let v3 = 0;
        let v4 = vector[];
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(v0.n_coins) > v3) {
            let v5 = *0x1::vector::borrow<CoinState>(&v2, v3);
            0x1::vector::push_back<u64>(&mut v4, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(arg1 - 1) * *0x1::vector::borrow<u256>(&v0.balances, v3) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T0>(&v0.lp_coin_supply)), v5.decimals_scalar)));
            v3 = v3 + 1;
        };
        v4
    }

    public fun quote_remove_liquidity_one_coin<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let (v0, v1) = state_and_coin_states<T1>(arg0);
        let v2 = v1;
        let (v3, v4) = get_a_gamma<T1>(v0, arg1);
        let (v5, _, _, _, v9) = calculate_remove_one_coin_impl<T0, T1>(v0, v3, v4, v2, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(arg2) * 1000000000, true, false);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v5, 0x1::vector::borrow<CoinState>(&v2, v9).decimals_scalar))
    }

    public fun quote_swap<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let (v0, v1) = state_and_coin_states<T2>(arg0);
        let v2 = v1;
        let v3 = coin_state<T0, T2>(v0);
        let v4 = coin_state<T1, T2>(v0);
        let (v5, v6) = get_a_gamma<T2>(v0, arg1);
        let v7 = vector[];
        let v8 = 0;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(v0.n_coins) > v8) {
            let v9 = *0x1::vector::borrow<CoinState>(&v2, v8);
            let v10 = if (v8 == v3.index) {
                *0x1::vector::borrow<u256>(&v0.balances, v8) + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(arg2), v3.decimals_scalar)
            } else {
                *0x1::vector::borrow<u256>(&v0.balances, v8)
            };
            let v11 = if (v8 == 0) {
                v10
            } else {
                0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v10, v9.price)
            };
            0x1::vector::push_back<u256>(&mut v7, v11);
            v8 = v8 + 1;
        };
        let v12 = *0x1::vector::borrow<u256>(&v7, v4.index);
        let v13 = v12 - 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::min(v12, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::y(v5, v6, &v7, v0.d, v4.index) + 1);
        let v14 = v13;
        let v15 = 0x1::vector::borrow_mut<u256>(&mut v7, v4.index);
        *v15 = *v15 - v13;
        if (v4.index != 0) {
            v14 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v13, v4.price);
        };
        let v16 = fee_impl<T2>(v0, v7) * v14 / 10000000000;
        (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v14 - v16, v4.decimals_scalar)), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(v16))
    }

    public fun ramp<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock, arg3: u256, arg4: u256, arg5: u64) {
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::assert_pool_admin<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v2 = load_mut<T0>(v1);
        assert!(v0 >= v2.a_gamma.initial_time + 86400000, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::wait_one_day());
        assert!(arg5 >= v0 + 86400000, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_ramp_time_is_too_short());
        let (v3, v4) = get_a_gamma<T0>(v2, arg2);
        assert!(arg3 >= v2.min_a, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_a_is_too_small());
        assert!(v2.max_a >= arg3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_gamma_is_too_big());
        assert!(arg4 >= 10000000000, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_gamma_is_too_small());
        assert!(10000000000000000 >= arg4, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_gamma_is_too_big());
        let v5 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(arg3, v3);
        assert!(10 * 1000000000000000000 >= v5, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_a_change_is_too_big());
        assert!(v5 >= 1000000000000000000 / 10, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_a_change_is_too_small());
        let v6 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(arg4, v4);
        assert!(10 * 1000000000000000000 >= v6, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_gamma_change_is_too_big());
        assert!(v6 >= 1000000000000000000 / 10, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::future_gamma_change_is_too_small());
        v2.a_gamma.a = v3;
        v2.a_gamma.gamma = v4;
        v2.a_gamma.initial_time = v0;
        v2.a_gamma.future_a = arg3;
        v2.a_gamma.future_gamma = arg4;
        v2.a_gamma.future_time = arg5;
        increment_version<T0>(v2);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_ramp_a_gamma<T0>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), v3, v4, v0, arg3, arg4, arg5);
    }

    public fun read_balance<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &mut BalancesRequest) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load<T1>(v0);
        assert!(0x2::object::id_address<StateV1<T1>>(v1) == arg1.state_id, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::wrong_pool_id());
        assert!(v1.version == arg1.version, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::version_was_updated());
        let v2 = coin_state<T0, T1>(v1);
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg1.coins, v2.type_name, 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::value<T0>(coin_balance_impl<T0, T1>(v1))), v2.decimals_scalar));
    }

    fun register_2_pool<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg5: u256, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_liquidity_amounts());
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load_mut<T2>(v0);
        register_coin<T0, T2>(v1, arg4, 1000000000000000000, 0);
        register_coin<T1, T2>(v1, arg4, arg5, 1);
        add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, 0, arg6)
    }

    fun register_3_pool<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg6: vector<u256>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0 && 0x2::coin::value<T2>(&arg4) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_liquidity_amounts());
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load_mut<T3>(v0);
        register_coin<T0, T3>(v1, arg5, 1000000000000000000, 0);
        register_coin<T1, T3>(v1, arg5, *0x1::vector::borrow<u256>(&arg6, 0), 1);
        register_coin<T2, T3>(v1, arg5, *0x1::vector::borrow<u256>(&arg6, 1), 2);
        add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0, arg7)
    }

    fun register_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimals, arg2: u256, arg3: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = CoinState{
            index           : arg3,
            price           : arg2,
            price_oracle    : arg2,
            last_price      : arg2,
            decimals_scalar : 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::scalar<T0>(arg1)),
            type_name       : v0,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, CoinState>(&mut arg0.coin_states, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coin_balances, v0, 0x2::balance::zero<T0>());
    }

    public fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0x2::coin::Coin<T2>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_remove_liquidity_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_remove_liquidity_hooks());
        remove_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    fun remove_liquidity_2_pool_impl<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0x2::coin::Coin<T2>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T2>(&arg1) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_coin());
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert!(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::are_coins_ordered<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, v0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::coins_must_be_in_order());
        let v2 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v3 = load_mut<T2>(v2);
        let v4 = 0x2::balance::supply_value<T2>(&v3.lp_coin_supply);
        let v5 = 0x2::balance::decrease_supply<T2>(&mut v3.lp_coin_supply, 0x2::coin::into_balance<T2>(arg1));
        v3.d = v3.d - v3.d * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v5) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v4);
        let v6 = withdraw_coin<T0, T2>(v3, v5, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<u64>(arg2), v4, arg3);
        let v7 = withdraw_coin<T1, T2>(v3, v5, *0x1::vector::borrow<u64>(&arg2, 1), v4, arg3);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_remove_liquidity_2_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), v5);
        increment_version<T2>(v3);
        (v6, v7)
    }

    public fun remove_liquidity_2_pool_with_hooks<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_remove_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let (v1, v2) = remove_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg2, arg3, arg4);
        (v0, v1, v2)
    }

    public fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0x2::coin::Coin<T3>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_remove_liquidity_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_remove_liquidity_hooks());
        remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3)
    }

    fun remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0x2::coin::Coin<T3>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(0x2::coin::value<T3>(&arg1) != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_coin());
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert!(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::are_coins_ordered<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, v0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::coins_must_be_in_order());
        let v2 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v3 = load_mut<T3>(v2);
        let v4 = 0x2::balance::supply_value<T3>(&v3.lp_coin_supply);
        let v5 = 0x2::balance::decrease_supply<T3>(&mut v3.lp_coin_supply, 0x2::coin::into_balance<T3>(arg1));
        v3.d = v3.d - v3.d * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v5) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v4);
        let v6 = withdraw_coin<T0, T3>(v3, v5, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<u64>(arg2), v4, arg3);
        let v7 = withdraw_coin<T1, T3>(v3, v5, *0x1::vector::borrow<u64>(&arg2, 1), v4, arg3);
        let v8 = withdraw_coin<T2, T3>(v3, v5, *0x1::vector::borrow<u64>(&arg2, 2), v4, arg3);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_remove_liquidity_3_pool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2, T3>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), 0x2::coin::value<T2>(&v8), v5);
        increment_version<T3>(v3);
        (v6, v7, v8)
    }

    public fun remove_liquidity_3_pool_with_hooks<T0, T1, T2, T3>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_remove_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let (v1, v2, v3) = remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg2, arg3, arg4);
        (v0, v1, v2, v3)
    }

    public fun remove_liquidity_one_coin<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::has_remove_liquidity_hooks<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::pool_has_no_remove_liquidity_hooks());
        remove_liquidity_one_coin_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun remove_liquidity_one_coin_impl<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_coin());
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (v2, v3) = state_and_coin_states_mut<T1>(arg0);
        let v4 = v3;
        let (v5, v6) = get_a_gamma<T1>(v2, arg1);
        let v7 = 0x2::clock::timestamp_ms(arg1);
        let v8 = v2.a_gamma.future_time;
        let (v9, v10, v11, v12, v13) = calculate_remove_one_coin_impl<T0, T1>(v2, v5, v6, v4, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v0) * 1000000000, v8 != 0, true);
        if (v7 >= v8) {
            v2.a_gamma.future_time = 1;
        };
        0x2::balance::decrease_supply<T1>(&mut v2.lp_coin_supply, 0x2::coin::into_balance<T1>(arg2));
        let v14 = 0x1::vector::borrow_mut<u256>(&mut v2.balances, v13);
        *v14 = *v14 - v9;
        let v15 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T1>(&v2.lp_coin_supply)) * 1000000000;
        tweak_price<T1>(v2, v4, v7, v5, v6, v12, v13, v10, v11, v15);
        let v16 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v9, 0x1::vector::borrow<CoinState>(&v4, v13).decimals_scalar));
        assert!(v16 >= arg3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::slippage());
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_remove_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1>(v1, v16, v0);
        increment_version<T1>(v2);
        0x2::coin::take<T0>(coin_balance_mut<T0, T1>(v2), v16, arg4)
    }

    public fun remove_liquidity_one_coin_with_hooks<T0, T1>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T0>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_remove_liquidity<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg2);
        (v0, remove_liquidity_one_coin_impl<T0, T1>(arg0, arg1, arg3, arg4, arg5))
    }

    fun state_and_coin_states<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : (&StateV1<T0>, vector<CoinState>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load<T0>(v0);
        (v1, coin_state_vector_in_order<T0>(v1, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::coins<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0)))
    }

    fun state_and_coin_states_mut<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : (&mut StateV1<T0>, vector<CoinState>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v1 = load_mut<T0>(v0);
        (v1, coin_state_vector_in_order<T0>(v1, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::coins<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0)))
    }

    public fun stop_ramp<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock) {
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::assert_pool_admin<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let v2 = load_mut<T0>(v1);
        let (v3, v4) = get_a_gamma<T0>(v2, arg2);
        v2.a_gamma.a = v3;
        v2.a_gamma.gamma = v4;
        v2.a_gamma.future_a = v3;
        v2.a_gamma.future_gamma = v4;
        v2.a_gamma.initial_time = v0;
        v2.a_gamma.future_time = v0;
        increment_version<T0>(v2);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_stop_ramp_a_gamma<T0>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0), v3, v4, v0);
    }

    fun swap_impl<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::cannot_swap_same_coin());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != 0, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::no_zero_coin());
        let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (v2, v3) = state_and_coin_states_mut<T2>(arg0);
        let v4 = v3;
        let v5 = coin_state<T0, T2>(v2);
        let v6 = v5.index;
        let v7 = *0x1::vector::borrow<u256>(&v2.balances, v6);
        let v8 = v7;
        deposit_coin<T0, T2>(v2, arg2);
        let v9 = 0x1::vector::borrow<CoinState>(&v4, v6);
        let v10 = coin_state<T1, T2>(v2);
        let (v11, v12) = get_a_gamma<T2>(v2, arg1);
        let v13 = v10.index;
        let v14 = 0x2::clock::timestamp_ms(arg1);
        let v15 = balances_in_price_impl<T2>(v2, v4);
        let v16 = v2.a_gamma.future_time;
        if (v16 != 0) {
            if (v9.index != 0) {
                v8 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v7, v9.price);
            };
            let v17 = 0x1::vector::borrow_mut<u256>(&mut v15, v9.index);
            *v17 = v8;
            v2.d = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(v11, v12, v15);
            *0x1::vector::borrow_mut<u256>(&mut v15, v9.index) = *v17;
            if (v14 >= v16) {
                v2.a_gamma.future_time = 1;
            };
        };
        let v18 = *0x1::vector::borrow<u256>(&v15, v10.index);
        let v19 = v18 - 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::min(v18, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::y(v11, v12, &v15, v2.d, v10.index) + 1);
        let v20 = 0x1::vector::borrow_mut<u256>(&mut v15, v10.index);
        *v20 = *v20 - v19;
        let v21 = if (v10.index != 0) {
            0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v19, v10.price)
        } else {
            v19
        };
        let v22 = v21 - fee_impl<T2>(v2, v15) * v21 / 10000000000;
        let v23 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v22, v10.decimals_scalar));
        assert!(v23 >= arg3, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::slippage());
        let v24 = 0x1::vector::borrow_mut<u256>(&mut v2.balances, v10.index);
        *v24 = *v24 - v22;
        let v25 = *0x1::vector::borrow<u256>(&v2.balances, v10.index) - v22;
        let v26 = v25;
        if (v10.index != 0) {
            v26 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v25, v10.price);
        };
        *0x1::vector::borrow_mut<u256>(&mut v15, v10.index) = v26;
        let v27 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(v0), v9.decimals_scalar);
        let v28 = 0;
        if (v27 > 100000 && v22 > 100000) {
            let v29 = if (v9.index != 0 && v10.index != 0) {
                v9.last_price * v27 / v22
            } else if (v9.index == 0) {
                0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v27, v22)
            } else {
                v13 = v9.index;
                0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v22, v27)
            };
            v28 = v29;
        };
        let v30 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(0x2::balance::supply_value<T2>(&v2.lp_coin_supply)) * 1000000000;
        tweak_price<T2>(v2, v4, v14, v11, v12, v15, v13, v28, 0, v30);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_swap<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile, T0, T1, T2>(v1, v0, v23);
        increment_version<T2>(v2);
        0x2::coin::take<T1>(coin_balance_mut<T1, T2>(v2), v23, arg4)
    }

    public fun swap_with_hooks<T0, T1, T2>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0x2::clock::Clock, arg2: 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::Request, 0x2::coin::Coin<T1>) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::finish_swap<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg2);
        (v0, swap_impl<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5))
    }

    fun tweak_price<T0>(arg0: &mut StateV1<T0>, arg1: vector<CoinState>, arg2: u64, arg3: u256, arg4: u256, arg5: vector<u256>, arg6: u64, arg7: u256, arg8: u256, arg9: u256) {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins);
        if (arg2 > arg0.last_prices_timestamp) {
            let v1 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::half_pow(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256((arg2 - arg0.last_prices_timestamp) / 1000), arg0.rebalancing_params.ma_half_time), 10000000000);
            let v2 = 1;
            while (v0 > v2) {
                let v3 = 0x1::vector::borrow_mut<CoinState>(&mut arg1, v2);
                v3.price_oracle = (v3.last_price * (1000000000000000000 - v1) + v3.price_oracle * v1) / 1000000000000000000;
                v2 = v2 + 1;
            };
            arg0.last_prices_timestamp = arg2;
        };
        let v4 = if (arg8 == 0) {
            0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(arg3, arg4, arg5)
        } else {
            arg8
        };
        if (arg7 != 0) {
            if (arg6 != 0) {
                0x1::vector::borrow_mut<CoinState>(&mut arg1, arg6).last_price = arg7;
            } else {
                let v5 = 1;
                while ((arg0.n_coins as u64) > v5) {
                    let v6 = 0x1::vector::borrow_mut<CoinState>(&mut arg1, v5);
                    v6.last_price = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v6.last_price, arg7);
                    v5 = v5 + 1;
                };
            };
        } else {
            let v7 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<u256>(arg5) / 1000000;
            let v8 = 0x1::vector::borrow_mut<u256>(&mut arg5, 0);
            *v8 = *v8 + v7;
            let v9 = 1;
            while (v0 > v9) {
                let v10 = 0x1::vector::borrow_mut<CoinState>(&mut arg1, v9);
                v10.last_price = v10.price * v7 / (*0x1::vector::borrow<u256>(&arg5, v9) - 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::y(arg3, arg4, &arg5, v4, v9));
                v9 = v9 + 1;
            };
        };
        let v11 = arg0.virtual_price;
        let v12 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v12, v4 / arg0.n_coins);
        let v13 = 1;
        while (v0 > v13) {
            0x1::vector::push_back<u256>(&mut v12, 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v4, arg0.n_coins * 0x1::vector::borrow<CoinState>(&arg1, v13).price));
            v13 = v13 + 1;
        };
        let v14 = 1000000000000000000;
        let v15 = 1000000000000000000;
        if (v11 != 0) {
            let v16 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::geometric_mean(v12, true), arg9);
            v15 = v16;
            v14 = arg0.xcp_profit * v16 / v11;
            if (v11 > v16 && arg0.a_gamma.future_time == 0) {
                abort 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::incurred_a_loss()
            };
            if (arg0.a_gamma.future_time == 1) {
                arg0.a_gamma.future_time = 0;
            };
        };
        arg0.xcp_profit = v14;
        let v17 = arg0.not_adjusted;
        let v18 = v17;
        if (!v17 && v15 * 2 - 1000000000000000000 > v14 + 2 * arg0.rebalancing_params.extra_profit) {
            v18 = true;
            arg0.not_adjusted = true;
        };
        if (v18) {
            let v19 = arg0.rebalancing_params.adjustment_step;
            let v20 = 0;
            let v21 = 1;
            while (v0 > v21) {
                let v22 = 0x1::vector::borrow<CoinState>(&arg1, v21);
                v20 = v20 + 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::pow(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(1000000000000000000, 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v22.price_oracle, v22.price)), 2);
                v21 = v21 + 1;
            };
            if (v20 > 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::pow(v19, 2) && v11 != 0) {
                let v23 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::sqrt(v20 / 1000000000000000000);
                let v24 = vector[0];
                let v25 = 1;
                while (v0 > v25) {
                    let v26 = 0x1::vector::borrow<CoinState>(&arg1, v25);
                    let v27 = (v26.price * (v23 - v19) + v19 * v26.price_oracle) / v23;
                    0x1::vector::push_back<u256>(&mut v24, v27);
                    let v28 = 0x1::vector::borrow_mut<u256>(&mut arg5, v25);
                    *v28 = *v28 * v27 / v26.price;
                    v25 = v25 + 1;
                };
                let v29 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::invariant_(arg3, arg4, arg5);
                *0x1::vector::borrow_mut<u256>(&mut arg5, 0) = v29 / arg0.n_coins;
                let v30 = 1;
                while (v0 > v30) {
                    *0x1::vector::borrow_mut<u256>(&mut arg5, v30) = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(v29, arg0.n_coins * *0x1::vector::borrow<u256>(&v24, v30));
                    v30 = v30 + 1;
                };
                let v31 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::geometric_mean(arg5, true), arg9);
                if (v31 > 1000000000000000000 && 2 * v31 - 1000000000000000000 > v14) {
                    let v32 = 1;
                    while (v0 > v32) {
                        0x1::vector::borrow_mut<CoinState>(&mut arg1, v32).price = *0x1::vector::borrow<u256>(&v24, v32);
                        v32 = v32 + 1;
                    };
                    update_coin_state_prices<T0>(arg0, arg1);
                    arg0.d = v29;
                    arg0.virtual_price = v31;
                    return
                };
                arg0.not_adjusted = false;
            };
        };
        update_coin_state_prices<T0>(arg0, arg1);
        arg0.d = v4;
        arg0.virtual_price = v15;
    }

    fun update_coin_state_prices<T0>(arg0: &mut StateV1<T0>, arg1: vector<CoinState>) {
        let v0 = 1;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins) > v0) {
            let v1 = 0x1::vector::borrow<CoinState>(&arg1, v0);
            let v2 = coin_state_with_key_mut<T0>(arg0, &v1.type_name);
            v2.last_price = v1.last_price;
            v2.price = v1.price;
            v2.price_oracle = v1.price_oracle;
            v0 = v0 + 1;
        };
    }

    public fun update_parameters<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>, arg1: &0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock, arg3: BalancesRequest, arg4: vector<0x1::option::Option<u256>>) {
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::assert_pool_admin<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0, arg1);
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::addy<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        let (v1, v2) = state_and_coin_states_mut<T0>(arg0);
        claim_admin_fees_impl<T0>(v1, arg2, arg3, v2);
        let v3 = 0x1::option::destroy_with_default<u256>(0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::head<0x1::option::Option<u256>>(arg4), v1.fees.mid_fee);
        let v4 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 1), v1.fees.out_fee);
        let v5 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 2), v1.fees.admin_fee);
        let v6 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 3), v1.fees.gamma_fee);
        let v7 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 4), v1.rebalancing_params.extra_profit);
        let v8 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 5), v1.rebalancing_params.adjustment_step);
        let v9 = 0x1::option::destroy_with_default<u256>(*0x1::vector::borrow<0x1::option::Option<u256>>(&arg4, 6), v1.rebalancing_params.ma_half_time);
        assert!(10000000000 >= v4 && v4 >= 500000, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::out_fee_out_of_range());
        assert!(10000000000 >= v3 && 500000 >= 500000, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::mid_fee_out_of_range());
        assert!(10000000000 > v5, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::admin_fee_is_too_big());
        assert!(v6 != 0 && 1000000000000000000 >= v6, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::gamma_fee_out_of_range());
        assert!(1000000000000000000 > v7, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::extra_profit_is_too_big());
        assert!(1000000000000000000 > v8, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::adjustment_step_is_too_big());
        assert!(v9 >= 1000 && 604800000 >= v9, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::ma_half_time_out_of_range());
        v1.fees.admin_fee = v5;
        v1.fees.out_fee = v4;
        v1.fees.mid_fee = v3;
        v1.fees.gamma_fee = v6;
        v1.rebalancing_params.extra_profit = v7;
        v1.rebalancing_params.adjustment_step = v8;
        v1.rebalancing_params.ma_half_time = v9;
        increment_version<T0>(v1);
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::pool_events::emit_update_parameters<T0>(v0, v5, v4, v3, v6, v7, v8, v9);
    }

    public fun virtual_price<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).virtual_price
    }

    fun withdraw_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = coin_state<T0, T1>(arg0);
        let v1 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v0.index);
        let v2 = *v1 * 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(arg1 - 1) / 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u256(arg3);
        *v1 = *v1 - v2;
        let v3 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_down(v2, v0.decimals_scalar));
        assert!(v3 >= arg2, 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::errors::slippage());
        0x2::coin::take<T0>(coin_balance_mut<T0, T1>(arg0), v3, arg4)
    }

    fun xcp_impl<T0>(arg0: &StateV1<T0>, arg1: vector<CoinState>, arg2: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v0, arg2 / arg0.n_coins);
        let v1 = 1;
        while (0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::utils::to_u64(arg0.n_coins) > v1) {
            let v2 = *0x1::vector::borrow<CoinState>(&arg1, v1);
            0x1::vector::push_back<u256>(&mut v0, 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::div_down(arg2, arg0.n_coins * v2.price));
            v1 = v1 + 1;
        };
        0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::volatile_math::geometric_mean(v0, true)
    }

    public fun xcp_profit<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).xcp_profit
    }

    public fun xcp_profit_a<T0>(arg0: &mut 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::InterestPool<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>) : u256 {
        let v0 = 0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::interest_pool::state_mut<0xa19b1624262192cec11132a41dd51cb8d779f8ca58b8430310d6282830710b1d::curves::Volatile>(arg0);
        load<T0>(v0).xcp_profit_a
    }

    // decompiled from Move bytecode v6
}

