module 0xc86cfe808f5583be9dc51e1f86a18b9312d75e71d37be5194a01dd38562bcde2::pool_creator {
    public entry fun create_pool<T0, T1>(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg11, arg13);
        let (v2, v3, v4) = 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::pool_creator::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg9, arg10, arg11, arg12, arg13);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::position::Position>(v2, 0x2::tx_context::sender(arg13));
    }

    public entry fun create_pool_with_creation_cap<T0, T1>(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::factory::Pools, arg2: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: &mut 0x2::coin::Coin<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg4, arg6, arg7, arg8, arg9, arg12, arg14);
        let (v2, v3, v4) = 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::pool_creator::create_pool_with_creation_cap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, v1, arg10, arg11, arg12, arg13, arg14);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::position::Position>(v2, 0x2::tx_context::sender(arg14));
    }

    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    // decompiled from Move bytecode v6
}

