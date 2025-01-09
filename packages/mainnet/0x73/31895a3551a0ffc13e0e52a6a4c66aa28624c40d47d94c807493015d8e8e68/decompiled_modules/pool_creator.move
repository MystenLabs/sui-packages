module 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::pool_creator {
    public fun create_pool_v2<T0, T1>(arg0: &0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::config::GlobalConfig, arg1: &mut 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)) <= arg3 && 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6)) > arg3, 5);
        assert!(!0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::is_permission_pair<T0, T1>(arg1, arg2), 1);
        0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::create_pool_v2_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::coin::value<T0>(&arg7), 0x2::coin::value<T1>(&arg8), arg11, arg12, arg13)
    }

    public fun create_pool_v2_by_creation_cap<T0, T1>(arg0: &0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::config::GlobalConfig, arg1: &mut 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::Pools, arg2: &0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 1
    }

    public fun create_pool_v2_with_creation_cap<T0, T1>(arg0: &0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::config::GlobalConfig, arg1: &mut 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::Pools, arg2: &0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::permission_pair_cap<T0, T1>(arg1, arg3) == 0x2::object::id<0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::PoolCreationCap>(arg2), 4);
        assert!(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6)) <= arg4 && 0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7)) > arg4, 5);
        0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::factory::create_pool_v2_<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x2::coin::value<T0>(&arg8), 0x2::coin::value<T1>(&arg9), arg12, arg13, arg14)
    }

    public fun full_range_tick_range(arg0: u32) : (u32, u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::tick_bound() % arg0);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::min_tick(), v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x7331895a3551a0ffc13e0e52a6a4c66aa28624c40d47d94c807493015d8e8e68::tick_math::max_tick(), v0)))
    }

    // decompiled from Move bytecode v6
}

