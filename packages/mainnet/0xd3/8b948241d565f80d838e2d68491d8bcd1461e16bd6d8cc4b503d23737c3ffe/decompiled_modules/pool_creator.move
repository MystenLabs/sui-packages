module 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::pool_creator {
    public fun create_pool<T0, T1>(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)) <= arg3 && 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6)) > arg3, 5);
        assert!(!0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::is_permission_pair<T0, T1>(arg1, arg2), 1);
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::coin::value<T0>(&arg7), 0x2::coin::value<T1>(&arg8), arg11, arg12, arg13)
    }

    public fun create_pool_with_creation_cap<T0, T1>(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::Pools, arg2: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::permission_pair_cap<T0, T1>(arg1, arg3) == 0x2::object::id<0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::PoolCreationCap>(arg2), 4);
        assert!(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6)) <= arg4 && 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7)) > arg4, 5);
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::factory::create_pool<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x2::coin::value<T0>(&arg8), 0x2::coin::value<T1>(&arg9), arg12, arg13, arg14)
    }

    public fun full_range_tick_range(arg0: u32) : (u32, u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::tick_bound() % arg0);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::min_tick(), v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::tick_math::max_tick(), v0)))
    }

    // decompiled from Move bytecode v6
}

