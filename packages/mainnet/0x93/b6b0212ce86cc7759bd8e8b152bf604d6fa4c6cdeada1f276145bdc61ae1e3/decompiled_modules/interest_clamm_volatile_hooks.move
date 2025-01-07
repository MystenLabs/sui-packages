module 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile_hooks {
    public fun swap<T0, T1, T2>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T1>) {
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_swap<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::swap_impl<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5))
    }

    public fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T2>) {
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_add_liquidity<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6))
    }

    public fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T3>) {
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_add_liquidity<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::HooksBuilder, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg5: 0x2::balance::Supply<T2>, arg6: vector<u256>, arg7: vector<u256>, arg8: u256, arg9: vector<u256>, arg10: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_admin::PoolAdmin, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let (v2, v3) = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::new_pool_with_hooks<T2>(arg0, arg1, v0, arg4, arg5, vector[0, 0], arg6, arg7, arg9, arg10);
        let v4 = v2;
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_events::emit_new_2_pool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile, T0, T1, T2>(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::addy<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(&v4));
        (v4, v3, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::register_2_pool<T0, T1, T2>(&mut v4, arg0, arg2, arg3, arg4, arg8, arg10))
    }

    public fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::HooksBuilder, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg6: 0x2::balance::Supply<T3>, arg7: vector<u256>, arg8: vector<u256>, arg9: vector<u256>, arg10: vector<u256>, arg11: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_admin::PoolAdmin, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let (v2, v3) = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::new_pool_with_hooks<T3>(arg0, arg1, v0, arg5, arg6, vector[0, 0, 0], arg7, arg8, arg10, arg11);
        let v4 = v2;
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_events::emit_new_3_pool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile, T0, T1, T2, T3>(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::addy<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(&v4));
        (v4, v3, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::register_3_pool<T0, T1, T2, T3>(&mut v4, arg0, arg2, arg3, arg4, arg5, arg9, arg11))
    }

    public fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::remove_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg2, arg3, arg4);
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_remove_liquidity<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), v0, v1)
    }

    public fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, v2) = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg2, arg3, arg4);
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_remove_liquidity<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), v0, v1, v2)
    }

    public fun remove_liquidity_one_coin<T0, T1>(arg0: &mut 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request, 0x2::coin::Coin<T0>) {
        (0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks::finish_remove_liquidity<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(arg0, arg1), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile::remove_liquidity_one_coin_impl<T0, T1>(arg0, arg2, arg3, arg4, arg5))
    }

    // decompiled from Move bytecode v6
}

