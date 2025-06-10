module 0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::pool_creator {
    public entry fun create_pool<T0, T1>(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg11, arg13);
        let (v2, v3, v4) = 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::pool_creator::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg9, arg10, arg11, arg12, arg13);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::position::Position>(v2, 0x2::tx_context::sender(arg13));
    }

    public entry fun create_pool_with_creation_cap<T0, T1>(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::factory::Pools, arg2: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::factory::PoolCreationCap, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: &mut 0x2::coin::Coin<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg4, arg6, arg7, arg8, arg9, arg12, arg14);
        let (v2, v3, v4) = 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::pool_creator::create_pool_with_creation_cap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, v1, arg10, arg11, arg12, arg13, arg14);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::position::Position>(v2, 0x2::tx_context::sender(arg14));
    }

    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    // decompiled from Move bytecode v6
}

