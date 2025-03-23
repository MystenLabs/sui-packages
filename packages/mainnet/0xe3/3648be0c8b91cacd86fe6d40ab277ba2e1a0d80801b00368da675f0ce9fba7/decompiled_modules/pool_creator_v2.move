module 0xe33648be0c8b91cacd86fe6d40ab277ba2e1a0d80801b00368da675f0ce9fba7::pool_creator_v2 {
    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::clmm_math::get_liquidity_by_amount(0x810344e626dbc98b93565b08cc435ead55513182604bae4f34b4228dfb2a680d::i32::from_u32(arg1), 0x810344e626dbc98b93565b08cc435ead55513182604bae4f34b4228dfb2a680d::i32::from_u32(arg2), 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    public entry fun create_pool_v2<T0, T1>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg1: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg11, arg13);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5, v6) = 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::factory::create_pool_with_liquidity<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, v3, v2, 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), arg11, arg12, arg13);
        0x2::coin::destroy_zero<T0>(v5);
        0x2::coin::destroy_zero<T1>(v6);
        0x2::transfer::public_transfer<0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::position::Position>(v4, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

