module 0x3035edfa2b549474e56ea96e6d3536d801cb428ddb58ba54f96ae6dc1a571e1a::suiai_v2 {
    struct SUIAI_V2 has drop {
        dummy_field: bool,
    }

    public entry fun init_cetus_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T1>(&arg1) as u256);
        let v1 = (0x2::coin::value<T0>(&arg0) as u256);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v5 = *0x1::ascii::as_bytes(&v4);
        let v6 = 0;
        let v7 = false;
        while (v6 < 0x1::vector::length<u8>(&v5)) {
            let v8 = *0x1::vector::borrow<u8>(&v5, v6);
            let v9 = *0x1::vector::borrow<u8>(&v3, v6);
            if (v9 < v8) {
                v7 = false;
                break
            };
            if (v9 > v8) {
                v7 = true;
                break
            };
            v6 = v6 + 1;
        };
        if (v7) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool_with_liquidity<T1, T0>(arg2, arg3, 60, sqrt(340282366920938463463374607431768211456 * v1 / v0), 0x1::string::utf8(b""), 4294523716, 443580, arg1, arg0, (v0 as u64), (v1 as u64), true, arg4, arg5);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v10, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool_with_liquidity<T0, T1>(arg2, arg3, 60, sqrt(340282366920938463463374607431768211456 * v0 / v1), 0x1::string::utf8(b""), 4294523716, 443580, arg0, arg1, (v1 as u64), (v0 as u64), false, arg4, arg5);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v13, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v15, @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc);
        };
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

