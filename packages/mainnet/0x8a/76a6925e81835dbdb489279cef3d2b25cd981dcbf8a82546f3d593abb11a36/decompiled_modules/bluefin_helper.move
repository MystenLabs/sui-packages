module 0x8a76a6925e81835dbdb489279cef3d2b25cd981dcbf8a82546f3d593abb11a36::bluefin_helper {
    public fun new_pool<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &0x2::clock::Clock, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg3), 0x2::url::new_unsafe_from_bytes(b""));
        let v1 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<0x2::sui::SUI>(arg2), 0x2::url::new_unsafe_from_bytes(b""));
        let (_, v3, _, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<T0, 0x2::sui::SUI, T1>(arg1, arg0, b"", b"", 0x1::ascii::into_bytes(0x2::coin::get_symbol<T0>(arg3)), 0x2::coin::get_decimals<T0>(arg3), 0x1::ascii::into_bytes(0x2::url::inner_url(&v0)), 0x1::ascii::into_bytes(0x2::coin::get_symbol<0x2::sui::SUI>(arg2)), 0x2::coin::get_decimals<0x2::sui::SUI>(arg2), 0x1::ascii::into_bytes(0x2::url::inner_url(&v1)), 200, 10000, 63901395939770060, 0x2::coin::into_balance<T1>(arg6), 4294523696, 443600, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<0x2::sui::SUI>(arg4), 0x2::coin::value<0x2::sui::SUI>(&arg4), false, arg7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg7), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg7), @0x0);
    }

    // decompiled from Move bytecode v6
}

