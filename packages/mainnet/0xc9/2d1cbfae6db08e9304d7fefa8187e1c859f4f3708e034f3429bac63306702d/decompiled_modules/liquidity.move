module 0xc92d1cbfae6db08e9304d7fefa8187e1c859f4f3708e034f3429bac63306702d::liquidity {
    public entry fun add_liquidity_with_all<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: u128, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg0, arg1, arg2, arg3, 0x1::string::utf8(b""), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg12));
    }

    public entry fun mint_pepe_and_add_liquidity(arg0: &mut 0x2::coin::TreasuryCap<0xc92d1cbfae6db08e9304d7fefa8187e1c859f4f3708e034f3429bac63306702d::raise_pepe::RAISE_PEPE>, arg1: &mut 0x2::tx_context::TxContext) {
        0xc92d1cbfae6db08e9304d7fefa8187e1c859f4f3708e034f3429bac63306702d::raise_pepe::mint(arg0, 100000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

