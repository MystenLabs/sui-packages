module 0xa4ceb3319e8790520c53aef2e1197a41c18c4bfedaf05bcef490bee7fd436f59::pool_creator_v2 {
    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::clmm_math::get_liquidity_by_amount(0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::from_u32(arg1), 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::i32::from_u32(arg2), 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    public entry fun create_pool_v2<T0, T1>(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg11, arg13);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5, v6) = 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::factory::create_pool_with_liquidity<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, v3, v2, 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), arg11, arg12, arg13);
        0x2::coin::destroy_zero<T0>(v5);
        0x2::coin::destroy_zero<T1>(v6);
        0x2::transfer::public_transfer<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::position::Position>(v4, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

