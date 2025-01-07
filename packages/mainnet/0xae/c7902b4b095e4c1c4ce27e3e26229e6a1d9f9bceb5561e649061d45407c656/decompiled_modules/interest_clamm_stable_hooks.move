module 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable_hooks {
    public fun swap<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T1>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_swap<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::swap_impl<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5))
    }

    public fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T2>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_add_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6))
    }

    public fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T3>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_add_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    public fun add_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T4>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_add_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8))
    }

    public fun add_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: 0x2::coin::Coin<T4>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T5>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_add_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))
    }

    public fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::HooksBuilder, arg2: u256, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg6: 0x2::balance::Supply<T2>, arg7: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T2>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let (v2, v3) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_pool_with_hooks<T2>(arg1, arg5, arg2, arg6, v0, arg7);
        let (v4, v5) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_2_pool_impl<T0, T1, T2>(v2, arg0, arg3, arg4, arg5, arg7);
        (v4, v3, v5)
    }

    public fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::HooksBuilder, arg2: u256, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg7: 0x2::balance::Supply<T3>, arg8: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T3>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        let (v2, v3) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_pool_with_hooks<T3>(arg1, arg6, arg2, arg7, v0, arg8);
        let (v4, v5) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_3_pool_impl<T0, T1, T2, T3>(v2, arg0, arg3, arg4, arg5, arg6, arg8);
        (v4, v3, v5)
    }

    public fun new_4_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::HooksBuilder, arg2: u256, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg8: 0x2::balance::Supply<T4>, arg9: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T4>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        let (v2, v3) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_pool_with_hooks<T4>(arg1, arg7, arg2, arg8, v0, arg9);
        let (v4, v5) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_4_pool_impl<T0, T1, T2, T3, T4>(v2, arg0, arg3, arg4, arg5, arg6, arg7, arg9);
        (v4, v3, v5)
    }

    public fun new_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::HooksBuilder, arg2: u256, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: 0x2::coin::Coin<T4>, arg8: &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg9: 0x2::balance::Supply<T5>, arg10: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::pool_admin::PoolAdmin, 0x2::coin::Coin<T5>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        let (v2, v3) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_pool_with_hooks<T5>(arg1, arg8, arg2, arg9, v0, arg10);
        let (v4, v5) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::new_5_pool_impl<T0, T1, T2, T3, T4, T5>(v2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        (v4, v3, v5)
    }

    public fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::remove_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg3, arg2, arg4, arg5);
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), v0, v1)
    }

    public fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T3>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, v2) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::remove_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5);
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), v0, v1, v2)
    }

    public fun remove_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T4>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        let (v0, v1, v2, v3) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::remove_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0, arg2, arg3, arg4, arg5);
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), v0, v1, v2, v3)
    }

    public fun remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: 0x2::coin::Coin<T5>, arg3: &0x2::clock::Clock, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        let (v0, v1, v2, v3, v4) = 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::remove_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0, arg3, arg2, arg4, arg5);
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), v0, v1, v2, v3, v4)
    }

    public fun remove_one_coin_liquidity<T0, T1>(arg0: &mut 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::InterestPool<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>, arg1: 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_pool::Request, 0x2::coin::Coin<T0>) {
        (0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::hooks::finish_remove_liquidity<0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::curves::Stable>(arg0, arg1), 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::interest_clamm_stable::remove_one_coin_liquidity_impl<T0, T1>(arg0, arg2, arg3, arg4, arg5))
    }

    // decompiled from Move bytecode v6
}

