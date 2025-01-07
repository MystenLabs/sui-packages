module 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable {
    struct CoinState<phantom T0> has store {
        decimals: u256,
        index: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct StateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_coin_supply: 0x2::balance::Supply<T0>,
        lp_coin_decimals_scalar: u256,
        balances: vector<u256>,
        initial_a: u256,
        future_a: u256,
        initial_a_time: u256,
        future_a_time: u256,
        n_coins: u64,
        fees: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::StableFees,
        coins: 0x2::bag::Bag,
        admin_balances: 0x2::bag::Bag,
    }

    public fun swap<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_swap_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        swap_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun a<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v1 = load<T0>(v0);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v1.initial_a, v1.initial_a_time, v1.future_a, v1.future_a_time, arg1)
    }

    fun add_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.admin_balances, v0, 0x2::balance::zero<T0>());
        let v1 = CoinState<T0>{
            decimals : 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::scalar<T0>(arg1)),
            index    : arg2,
            balance  : 0x2::balance::zero<T0>(),
        };
        0x2::bag::add<0x1::type_name::TypeName, CoinState<T0>>(&mut arg0.coins, v0, v1);
    }

    public fun coin_decimals<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u8 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let (_, v2) = coin_state_metadata<T0, T1>(load<T1>(v0));
        (v2 as u8)
    }

    public fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_add_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun add_liquidity_2_pool_impl<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v3 = load_mut<T2>(v2);
        let v4 = virtual_price_impl<T2>(v3, arg1);
        let v5 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v3.initial_a, v3.initial_a_time, v3.future_a, v3.future_a_time, arg1);
        let v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v5, v3.balances);
        let v7 = deposit_coin<T0, T2>(v3, arg2);
        let v8 = deposit_coin<T1, T2>(v3, arg3);
        let v9 = calculate_mint_amount<T2>(v3, v5, v6, arg4);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_add_liquidity_2_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v7, v8, v9);
        let v10 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T2>(load<T2>(v10), arg1) >= v4, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        0x2::coin::from_balance<T2>(0x2::balance::increase_supply<T2>(&mut v3.lp_coin_supply, v9), arg5)
    }

    public fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_add_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v3 = load_mut<T3>(v2);
        let v4 = virtual_price_impl<T3>(v3, arg1);
        let v5 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v3.initial_a, v3.initial_a_time, v3.future_a, v3.future_a_time, arg1);
        let v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v5, v3.balances);
        let v7 = deposit_coin<T0, T3>(v3, arg2);
        let v8 = deposit_coin<T1, T3>(v3, arg3);
        let v9 = deposit_coin<T2, T3>(v3, arg4);
        let v10 = calculate_mint_amount<T3>(v3, v5, v6, arg5);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_add_liquidity_3_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v7, v8, v9, v10);
        let v11 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T3>(load<T3>(v11), arg1) >= v4, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        0x2::coin::from_balance<T3>(0x2::balance::increase_supply<T3>(&mut v3.lp_coin_supply, v10), arg6)
    }

    public fun add_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_add_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v3 = load_mut<T4>(v2);
        let v4 = virtual_price_impl<T4>(v3, arg1);
        let v5 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v3.initial_a, v3.initial_a_time, v3.future_a, v3.future_a_time, arg1);
        let v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v5, v3.balances);
        let v7 = deposit_coin<T0, T4>(v3, arg2);
        let v8 = deposit_coin<T1, T4>(v3, arg3);
        let v9 = deposit_coin<T2, T4>(v3, arg4);
        let v10 = deposit_coin<T3, T4>(v3, arg5);
        let v11 = calculate_mint_amount<T4>(v3, v5, v6, arg6);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_add_liquidity_4_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v7, v8, v9, v10, v11);
        let v12 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T4>(load<T4>(v12), arg1) >= v4, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        0x2::coin::from_balance<T4>(0x2::balance::increase_supply<T4>(&mut v3.lp_coin_supply, v11), arg7)
    }

    public fun add_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_add_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v3 = load_mut<T5>(v2);
        let v4 = virtual_price_impl<T5>(v3, arg1);
        let v5 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v3.initial_a, v3.initial_a_time, v3.future_a, v3.future_a_time, arg1);
        let v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v5, v3.balances);
        let v7 = deposit_coin<T0, T5>(v3, arg2);
        let v8 = deposit_coin<T1, T5>(v3, arg3);
        let v9 = deposit_coin<T2, T5>(v3, arg4);
        let v10 = deposit_coin<T3, T5>(v3, arg5);
        let v11 = deposit_coin<T4, T5>(v3, arg6);
        let v12 = calculate_mint_amount<T5>(v3, v5, v6, arg7);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_add_liquidity_5_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4, T5>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v7, v8, v9, v10, v11, v12);
        let v13 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T5>(load<T5>(v13), arg1) >= v4, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        0x2::coin::from_balance<T5>(0x2::balance::increase_supply<T5>(&mut v3.lp_coin_supply, v12), arg8)
    }

    public fun admin_balance<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&load<T1>(v0).admin_balances, 0x1::type_name::get<T0>()))
    }

    fun admin_balance_mut<T0, T1>(arg0: &mut StateV1<T1>) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.admin_balances, 0x1::type_name::get<T0>())
    }

    public fun balances<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : vector<u256> {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).balances
    }

    fun calculate_mint_amount<T0>(arg0: &StateV1<T0>, arg1: u256, arg2: u256, arg3: u64) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(arg1, arg0.balances);
        assert!(v0 > arg2, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        let v1 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x2::balance::supply_value<T0>(&arg0.lp_coin_supply));
        let v2 = if (v1 == 0) {
            0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v0 / 1000000000)
        } else {
            0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v1 * (v0 - arg2) / arg2)
        };
        assert!(v2 >= arg3, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::slippage());
        v2
    }

    public fun coin_balance<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        0x2::balance::value<T0>(coin_state_balance<T0, T1>(load<T1>(v0)))
    }

    public fun coin_index<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u8 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let (v1, _) = coin_state_metadata<T0, T1>(load<T1>(v0));
        (v1 as u8)
    }

    fun coin_state_balance<T0, T1>(arg0: &StateV1<T1>) : &0x2::balance::Balance<T0> {
        &0x2::bag::borrow<0x1::type_name::TypeName, CoinState<T0>>(&arg0.coins, 0x1::type_name::get<T0>()).balance
    }

    fun coin_state_balance_mut<T0, T1>(arg0: &mut StateV1<T1>) : &mut 0x2::balance::Balance<T0> {
        &mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, CoinState<T0>>(&mut arg0.coins, 0x1::type_name::get<T0>()).balance
    }

    fun coin_state_metadata<T0, T1>(arg0: &StateV1<T1>) : (u64, u256) {
        let v0 = 0x2::bag::borrow<0x1::type_name::TypeName, CoinState<T0>>(&arg0.coins, 0x1::type_name::get<T0>());
        (v0.index, v0.decimals)
    }

    fun deposit_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: 0x2::coin::Coin<T0>) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x2::coin::value<T0>(&arg1));
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0
        };
        let (v1, v2) = coin_state_metadata<T0, T1>(arg0);
        let v3 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v1);
        *v3 = *v3 + v0 * 1000000000000000000 / v2;
        0x2::balance::join<T0>(coin_state_balance_mut<T0, T1>(arg0), 0x2::coin::into_balance<T0>(arg1))
    }

    public fun fees<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::StableFees {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).fees
    }

    public fun future_a<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).future_a
    }

    public fun future_a_time<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).future_a_time
    }

    public fun initial_a<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).initial_a
    }

    public fun initial_a_time<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).initial_a_time
    }

    fun load<T0>(arg0: &mut 0x2::versioned::Versioned) : &StateV1<T0> {
        maybe_upgrade_state_to_latest(arg0);
        0x2::versioned::load_value<StateV1<T0>>(arg0)
    }

    fun load_mut<T0>(arg0: &mut 0x2::versioned::Versioned) : &mut StateV1<T0> {
        maybe_upgrade_state_to_latest(arg0);
        0x2::versioned::load_value_mut<StateV1<T0>>(arg0)
    }

    public fun lp_coin_decimals_scalar<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).lp_coin_decimals_scalar
    }

    public fun lp_coin_supply<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        0x2::balance::supply_value<T0>(&load<T0>(v0).lp_coin_supply)
    }

    fun maybe_upgrade_state_to_latest(arg0: &mut 0x2::versioned::Versioned) {
        assert!(0x2::versioned::version(arg0) == 1, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_version());
    }

    public fun n_coins<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>) : u64 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        load<T0>(v0).n_coins
    }

    public fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg5: 0x2::balance::Supply<T2>, arg6: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let (v2, v3) = new_pool<T2>(arg4, arg1, arg5, v0, arg6);
        let (v4, v5) = new_2_pool_impl<T0, T1, T2>(v2, arg0, arg2, arg3, arg4, arg6);
        (v4, v3, v5)
    }

    public(friend) fun new_2_pool_impl<T0, T1, T2>(arg0: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0x2::coin::Coin<T2>) {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_liquidity_amounts());
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&mut arg0);
        let v1 = load_mut<T2>(v0);
        add_coin<T0, T2>(v1, arg4, 0);
        add_coin<T1, T2>(v1, arg4, 1);
        let v2 = &mut arg0;
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_new_2_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&arg0));
        (arg0, add_liquidity_2_pool_impl<T0, T1, T2>(v2, arg1, arg2, arg3, 0, arg5))
    }

    public fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg6: 0x2::balance::Supply<T3>, arg7: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let (v2, v3) = new_pool<T3>(arg5, arg1, arg6, v0, arg7);
        let (v4, v5) = new_3_pool_impl<T0, T1, T2, T3>(v2, arg0, arg2, arg3, arg4, arg5, arg7);
        (v4, v3, v5)
    }

    public(friend) fun new_3_pool_impl<T0, T1, T2, T3>(arg0: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg6: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0x2::coin::Coin<T3>) {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0 && 0x2::coin::value<T2>(&arg4) != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_liquidity_amounts());
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&mut arg0);
        let v1 = load_mut<T3>(v0);
        add_coin<T0, T3>(v1, arg5, 0);
        add_coin<T1, T3>(v1, arg5, 1);
        add_coin<T2, T3>(v1, arg5, 2);
        let v2 = &mut arg0;
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_new_3_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&arg0));
        (arg0, add_liquidity_3_pool_impl<T0, T1, T2, T3>(v2, arg1, arg2, arg3, arg4, 0, arg6))
    }

    public fun new_4_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg7: 0x2::balance::Supply<T4>, arg8: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T4>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        let (v2, v3) = new_pool<T4>(arg6, arg1, arg7, v0, arg8);
        let (v4, v5) = new_4_pool_impl<T0, T1, T2, T3, T4>(v2, arg0, arg2, arg3, arg4, arg5, arg6, arg8);
        (v4, v3, v5)
    }

    public(friend) fun new_4_pool_impl<T0, T1, T2, T3, T4>(arg0: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg7: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0x2::coin::Coin<T4>) {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0 && 0x2::coin::value<T2>(&arg4) != 0 && 0x2::coin::value<T3>(&arg5) != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_liquidity_amounts());
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&mut arg0);
        let v1 = load_mut<T4>(v0);
        add_coin<T0, T4>(v1, arg6, 0);
        add_coin<T1, T4>(v1, arg6, 1);
        add_coin<T2, T4>(v1, arg6, 2);
        add_coin<T3, T4>(v1, arg6, 3);
        let v2 = &mut arg0;
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_new_4_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&arg0));
        (arg0, add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(v2, arg1, arg2, arg3, arg4, arg5, 0, arg7))
    }

    public fun new_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg8: 0x2::balance::Supply<T5>, arg9: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T5>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        let (v2, v3) = new_pool<T5>(arg7, arg1, arg8, v0, arg9);
        let (v4, v5) = new_5_pool_impl<T0, T1, T2, T3, T4, T5>(v2, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        (v4, v3, v5)
    }

    public(friend) fun new_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg8: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0x2::coin::Coin<T5>) {
        assert!(0x2::coin::value<T0>(&arg2) != 0 && 0x2::coin::value<T1>(&arg3) != 0 && 0x2::coin::value<T2>(&arg4) != 0 && 0x2::coin::value<T3>(&arg5) != 0 && 0x2::coin::value<T4>(&arg6) != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_liquidity_amounts());
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&mut arg0);
        let v1 = load_mut<T5>(v0);
        add_coin<T0, T5>(v1, arg7, 0);
        add_coin<T1, T5>(v1, arg7, 1);
        add_coin<T2, T5>(v1, arg7, 2);
        add_coin<T3, T5>(v1, arg7, 3);
        add_coin<T4, T5>(v1, arg7, 4);
        let v2 = &mut arg0;
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_new_5_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4, T5>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(&arg0));
        (arg0, add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(v2, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg8))
    }

    fun new_pool<T0>(arg0: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg1: u256, arg2: 0x2::balance::Supply<T0>, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin) {
        let v0 = new_state_v1<T0>(arg0, arg1, arg2, 0x1::vector::length<0x1::type_name::TypeName>(&arg3), arg4);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::new<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::make_coins_vec_set_from_vector(arg3), 0x2::versioned::create<StateV1<T0>>(1, v0, arg4), arg4)
    }

    public(friend) fun new_pool_with_hooks<T0>(arg0: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::HooksBuilder, arg1: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg2: u256, arg3: 0x2::balance::Supply<T0>, arg4: vector<0x1::type_name::TypeName>, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin) {
        let v0 = new_state_v1<T0>(arg1, arg2, arg3, 0x1::vector::length<0x1::type_name::TypeName>(&arg4), arg5);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::new_with_hooks<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::make_coins_vec_set_from_vector(arg4), 0x2::versioned::create<StateV1<T0>>(1, v0, arg5), arg0, arg5)
    }

    fun new_state_v1<T0>(arg0: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg1: u256, arg2: 0x2::balance::Supply<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StateV1<T0> {
        assert!(0x2::balance::supply_value<T0>(&arg2) == 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::supply_must_have_zero_value());
        assert!(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::decimals<T0>(arg0) == 9, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::must_have_9_decimals());
        StateV1<T0>{
            id                      : 0x2::object::new(arg4),
            lp_coin_supply          : arg2,
            lp_coin_decimals_scalar : 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::scalar<T0>(arg0)),
            balances                : 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::empty_vector(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(arg3)),
            initial_a               : arg1,
            future_a                : arg1,
            initial_a_time          : 0,
            future_a_time           : 0,
            n_coins                 : arg3,
            fees                    : 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::new(),
            coins                   : 0x2::bag::new(arg4),
            admin_balances          : 0x2::bag::new(arg4),
        }
    }

    public fun quote_swap<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64, u64) {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v1 = load<T2>(v0);
        let (v2, v3) = coin_state_metadata<T0, T2>(v1);
        let (v4, v5) = coin_state_metadata<T1, T2>(v1);
        let v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_fee_in_amount(&v1.fees, arg2);
        let v7 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64((*0x1::vector::borrow<u256>(&v1.balances, v4) - 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::y(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v1.initial_a, v1.initial_a_time, v1.future_a, v1.future_a_time, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v2), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v4), *0x1::vector::borrow<u256>(&v1.balances, v2) + 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(arg2 - v6) * 1000000000000000000 / v3, v1.balances)) * v5 / 1000000000000000000);
        let v8 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_fee_out_amount(&v1.fees, v7);
        (v7 - v8, v6, v8)
    }

    public fun ramp<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock, arg3: u256, arg4: u256) {
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::assert_pool_admin<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v2 = load_mut<T0>(v1);
        assert!(v0 > 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v2.initial_a_time) + 86400000, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::wait_one_day());
        assert!(arg4 >= 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0 + 86400000), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::future_ramp_time_is_too_short());
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v2.initial_a, v2.initial_a_time, v2.future_a, v2.future_a_time, arg2);
        assert!(arg3 != 0 && arg3 < 1000000, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_amplifier());
        assert!(arg3 > v3 && v3 * 10 >= arg3 || v3 > arg3 && arg3 * 10 >= v3, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_amplifier());
        v2.initial_a = v3;
        v2.initial_a_time = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0);
        v2.future_a = arg3;
        v2.future_a_time = arg4;
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_ramp_a<T0>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v3, arg3, arg4, v0);
    }

    public fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_remove_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        remove_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun remove_liquidity_2_pool_impl<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0x2::coin::value<T2>(&arg2);
        assert!(v2 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_coin());
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v4 = load_mut<T2>(v3);
        let v5 = virtual_price_impl<T2>(v4, arg1);
        let v6 = take_coin<T0, T2>(v4, v2, arg3, arg4);
        let v7 = take_coin<T1, T2>(v4, v2, arg3, arg4);
        0x2::balance::decrease_supply<T2>(&mut v4.lp_coin_supply, 0x2::coin::into_balance<T2>(arg2));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_remove_liquidity_2_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), v2);
        let v8 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T2>(load<T2>(v8), arg1) >= v5, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        (v6, v7)
    }

    public fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_remove_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0x2::coin::value<T3>(&arg2);
        assert!(v2 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_coin());
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v4 = load_mut<T3>(v3);
        let v5 = virtual_price_impl<T3>(v4, arg1);
        let v6 = take_coin<T0, T3>(v4, v2, arg3, arg4);
        let v7 = take_coin<T1, T3>(v4, v2, arg3, arg4);
        let v8 = take_coin<T2, T3>(v4, v2, arg3, arg4);
        0x2::balance::decrease_supply<T3>(&mut v4.lp_coin_supply, 0x2::coin::into_balance<T3>(arg2));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_remove_liquidity_3_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), 0x2::coin::value<T2>(&v8), v2);
        let v9 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T3>(load<T3>(v9), arg1) >= v5, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        (v6, v7, v8)
    }

    public fun remove_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0x2::coin::Coin<T4>, arg2: &0x2::clock::Clock, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_remove_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        remove_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0, arg2, arg1, arg3, arg4)
    }

    public(friend) fun remove_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T4>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0x2::coin::value<T4>(&arg2);
        assert!(v2 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_coin());
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v4 = load_mut<T4>(v3);
        let v5 = virtual_price_impl<T4>(v4, arg1);
        let v6 = take_coin<T0, T4>(v4, v2, arg3, arg4);
        let v7 = take_coin<T1, T4>(v4, v2, arg3, arg4);
        let v8 = take_coin<T2, T4>(v4, v2, arg3, arg4);
        let v9 = take_coin<T3, T4>(v4, v2, arg3, arg4);
        0x2::balance::decrease_supply<T4>(&mut v4.lp_coin_supply, 0x2::coin::into_balance<T4>(arg2));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_remove_liquidity_4_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), 0x2::coin::value<T2>(&v8), 0x2::coin::value<T3>(&v9), v2);
        let v10 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T4>(load<T4>(v10), arg1) >= v5, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        (v6, v7, v8, v9)
    }

    public fun remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T5>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_remove_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        remove_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun remove_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T5>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::are_coins_ordered<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::coins_must_be_in_order());
        let v2 = 0x2::coin::value<T5>(&arg2);
        assert!(v2 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_coin());
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v4 = load_mut<T5>(v3);
        let v5 = virtual_price_impl<T5>(v4, arg1);
        let v6 = take_coin<T0, T5>(v4, v2, arg3, arg4);
        let v7 = take_coin<T1, T5>(v4, v2, arg3, arg4);
        let v8 = take_coin<T2, T5>(v4, v2, arg3, arg4);
        let v9 = take_coin<T3, T5>(v4, v2, arg3, arg4);
        let v10 = take_coin<T4, T5>(v4, v2, arg3, arg4);
        0x2::balance::decrease_supply<T5>(&mut v4.lp_coin_supply, 0x2::coin::into_balance<T5>(arg2));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_remove_liquidity_5_pool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2, T3, T4, T5>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v7), 0x2::coin::value<T2>(&v8), 0x2::coin::value<T3>(&v9), 0x2::coin::value<T4>(&v10), v2);
        let v11 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T5>(load<T5>(v11), arg1) >= v5, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        (v6, v7, v8, v9, v10)
    }

    public fun remove_one_coin_liquidity<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::has_remove_liquidity_hook<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::this_pool_has_hooks());
        remove_one_coin_liquidity_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun remove_one_coin_liquidity_impl<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::no_zero_coin());
        let v1 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v2 = load_mut<T1>(v1);
        let v3 = virtual_price_impl<T1>(v2, arg1);
        let (v4, v5) = coin_state_metadata<T0, T1>(v2);
        let v6 = 0x1::vector::borrow_mut<u256>(&mut v2.balances, v4);
        let v7 = *v6;
        *v6 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::y_lp(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v2.initial_a, v2.initial_a_time, v2.future_a, v2.future_a_time, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v4), v2.balances, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x2::balance::supply_value<T1>(&v2.lp_coin_supply))) + 1;
        let v8 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64((v7 - 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::min(v7, *v6)) * v5 / 1000000000000000000);
        assert!(v8 >= arg3, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::slippage());
        0x2::balance::decrease_supply<T1>(&mut v2.lp_coin_supply, 0x2::coin::into_balance<T1>(arg2));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v8, v0);
        let v9 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        assert!(virtual_price_impl<T1>(load<T1>(v9), arg1) >= v3, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        0x2::coin::take<T0>(coin_state_balance_mut<T0, T1>(v2), v8, arg4)
    }

    public fun stop_ramp<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, arg2: &0x2::clock::Clock) {
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::assert_pool_admin<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v2 = load_mut<T0>(v1);
        let v3 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v2.initial_a, v2.initial_a_time, v2.future_a, v2.future_a_time, arg2);
        v2.initial_a = v3;
        v2.initial_a_time = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0);
        v2.future_a = v3;
        v2.future_a_time = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_stop_ramp_a<T0>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v3, v0);
    }

    public(friend) fun swap_impl<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::cannot_swap_same_coin());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != 0, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::cannot_swap_zero_value());
        let v1 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v2 = load_mut<T2>(v1);
        let (v3, v4) = coin_state_metadata<T0, T2>(v2);
        let (v5, v6) = coin_state_metadata<T1, T2>(v2);
        let v7 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_fee_in_amount(&v2.fees, v0);
        let v8 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_admin_amount(&v2.fees, v7);
        let v9 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v0 - v7 - v8) * 1000000000000000000 / v4;
        let v10 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(v2.initial_a, v2.initial_a_time, v2.future_a, v2.future_a_time, arg1);
        let v11 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64((*0x1::vector::borrow<u256>(&v2.balances, v5) - 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::y(v10, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v3), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v5), *0x1::vector::borrow<u256>(&v2.balances, v3) + v9, v2.balances)) * v6 / 1000000000000000000);
        let v12 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_fee_out_amount(&v2.fees, v11);
        let v13 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::calculate_admin_amount(&v2.fees, v12);
        let v14 = v11 - v12 - v13;
        assert!(v14 >= arg3, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::slippage());
        let v15 = 0x1::vector::borrow_mut<u256>(&mut v2.balances, v3);
        *v15 = *v15 + v9 + 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v7 - v8) * 1000000000000000000 / v4;
        let v16 = 0x1::vector::borrow_mut<u256>(&mut v2.balances, v5);
        *v16 = *v16 - 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(v14 + v13) * 1000000000000000000 / v6;
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v10, v2.balances) >= 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(v10, v2.balances), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::invalid_invariant());
        let v17 = coin_state_balance_mut<T0, T2>(v2);
        0x2::balance::join<T0>(v17, 0x2::coin::into_balance<T0>(arg2));
        let v18 = admin_balance_mut<T0, T2>(v2);
        0x2::balance::join<T0>(v18, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v8, arg4)));
        let v19 = coin_state_balance_mut<T1, T2>(v2);
        0x2::balance::join<T1>(admin_balance_mut<T1, T2>(v2), 0x2::balance::split<T1>(v19, v13));
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_swap<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1, T2>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v0, v14);
        0x2::coin::take<T1>(v19, v14, arg4)
    }

    fun take_coin<T0, T1>(arg0: &mut StateV1<T1>, arg1: u64, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = coin_state_metadata<T0, T1>(arg0);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v0);
        let v3 = *v2 * v1 / 1000000000000000000 * 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(arg1) / 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x2::balance::supply_value<T1>(&arg0.lp_coin_supply));
        assert!(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v3) >= *0x1::vector::borrow<u64>(&arg2, v0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::errors::slippage());
        *v2 = *v2 - v3 * 1000000000000000000 / v1;
        0x2::coin::take<T0>(coin_state_balance_mut<T0, T1>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u64(v3), arg3)
    }

    public fun take_fees<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::assert_pool_admin<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1);
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v1 = load_mut<T1>(v0);
        let v2 = admin_balance_mut<T0, T1>(v1);
        let v3 = 0x2::balance::value<T0>(v2);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_take_fees<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0, T1>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), v3);
        0x2::coin::take<T0>(v2, v3, arg2)
    }

    public fun update_fee<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, arg2: 0x1::option::Option<u256>, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>) {
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::assert_pool_admin<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1);
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        let v1 = load_mut<T0>(v0);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::update_fee_in_percent(&mut v1.fees, arg2);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::update_fee_out_percent(&mut v1.fees, arg3);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::update_admin_fee_percent(&mut v1.fees, arg4);
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_events::emit_update_stable_fee<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable, T0>(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::addy<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::fee_in_percent(&v1.fees), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::fee_out_percent(&v1.fees), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_fees::admin_fee_percent(&v1.fees));
    }

    public fun virtual_price<T0>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::state_mut<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0);
        virtual_price_impl<T0>(load<T0>(v0), arg1)
    }

    fun virtual_price_impl<T0>(arg0: &StateV1<T0>, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils::to_u256(0x2::balance::supply_value<T0>(&arg0.lp_coin_supply));
        if (v0 == 0) {
            return 0
        };
        0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::invariant_(0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::stable_math::a(arg0.initial_a, arg0.initial_a_time, arg0.future_a, arg0.future_a_time, arg1), arg0.balances) * arg0.lp_coin_decimals_scalar / v0
    }

    // decompiled from Move bytecode v6
}

