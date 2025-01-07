module 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::test {
    fun check_profit_arb(arg0: u64, arg1: u64, arg2: u128) : bool {
        arg1 < ((arg2 * (arg0 as u128) >> 64) as u64)
    }

    fun compute_multiple(arg0: u128, arg1: u128, arg2: u128, arg3: u64) : u64 {
        let v0 = 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::arithmetic::mul_128(arg2, arg1);
        (((arg3 as u128) * (0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::arithmetic::mul_128(arg0, arg1) - v0) / (0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::arithmetic::mul_128(arg0, arg2) - v0)) as u64) - (arg3 as u64) >> 1
    }

    public fun find_best_arb<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &0x2::clock::Clock, arg12: &0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::fee::Fee, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::fee::check_fee(1, 0x2::tx_context::sender(arg13), arg12);
        let v0 = find_route(arg0, arg0, arg1, arg2, 1, arg8, arg9);
        let v1 = *0x1::vector::borrow<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::Route>(&v0, 0);
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::emit_route(v1);
        let v2 = 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::get_route_sqrt_price(&v1);
        if (v2 < arg3) {
            abort 9
        };
        let v3 = 0x2::coin::value<T0>(&arg7);
        let v4 = if (v3 / arg5 < arg6) {
            v3 / arg5
        } else {
            arg6
        };
        let v5 = 18446744073709551616;
        let v6 = 1;
        let v7 = 0x2::coin::split<T0>(&mut arg7, arg5, arg13);
        let v8 = &mut v5;
        let v9 = swap_route_static<T0, T0>(v8, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::get_route_route(&v1), v7, arg8, arg9, arg10, arg11, arg13);
        let v10 = arg5;
        let v11 = 0x2::coin::value<T0>(&v9);
        0x2::coin::join<T0>(&mut arg7, v9);
        assert!(0x2::coin::value<T0>(&arg7) >= v3, 31);
        while (v5 > arg3) {
            let v12 = compute_multiple(v2, v5, arg3, v6);
            let v13 = if (v12 <= v4) {
                v12
            } else {
                v4
            };
            v6 = v13;
            if (v13 < 1) {
                break
            };
            let v14 = v13 * arg5;
            let v15 = 0x2::coin::split<T0>(&mut arg7, v14, arg13);
            v2 = v5;
            v5 = 18446744073709551616;
            let v16 = &mut v5;
            let v17 = swap_route_static<T0, T0>(v16, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::get_route_route(&v1), v15, arg8, arg9, arg10, arg11, arg13);
            v10 = v10 + v14;
            v11 = v11 + 0x2::coin::value<T0>(&v17);
            0x2::coin::join<T0>(&mut arg7, v17);
            assert!(0x2::coin::value<T0>(&arg7) >= v3, 13);
        };
        let v18 = 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::fee::get_fee(arg12);
        let v19 = if (v18 == 0) {
            0
        } else {
            v11 / v18
        };
        if (check_profit_arb(v10, v11 - v19, arg4)) {
            abort 99
        };
        if (v18 > 0) {
            0x2::pay::split_and_transfer<T0>(&mut arg7, v19, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::fee::get_recipient(arg12), arg13);
        };
        arg7
    }

    public fun find_prices(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>) : vector<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode> {
        let v0 = 0x1::vector::empty<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>();
        let v1 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        let v2 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::add_prices<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v1, 1), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v2, 1), 1), 1, arg0);
        let v3 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        let v4 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::add_prices<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v3, 2), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v4, 2), 1), 2, arg1);
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::emit_prices(v0);
        v0
    }

    public fun find_prices_no_fee(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>) : vector<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode> {
        let v0 = 0x1::vector::empty<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>();
        let v1 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        let v2 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::add_prices_no_fee<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v1, 1), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v2, 1), 1), 1, arg0);
        let v3 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        let v4 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::add_prices_no_fee<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v0, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v3, 2), 0), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v4, 2), 1), 2, arg1);
        0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::emit_prices(v0);
        v0
    }

    public(friend) fun find_route(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>) : vector<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::Route> {
        let v0 = find_prices(arg5, arg6);
        let v1 = 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::new_state(arg0, 20);
        let v2 = 0;
        while (v2 < arg3) {
            0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::evolve(&mut v1, &v0, arg4, arg2);
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<vector<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::Route>>(&v1, arg1)
    }

    public(friend) fun swap_route_static<T0, T1>(arg0: &mut u128, arg1: vector<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &arg1;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v0)) {
            0x1::vector::push_back<u16>(&mut v1, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::price_node_arg(0x1::vector::borrow<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v0, v2)));
            v2 = v2 + 1;
        };
        let v3 = &arg1;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v3)) {
            0x1::vector::push_back<u64>(&mut v4, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::price_node_from(0x1::vector::borrow<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v3, v5)));
            v5 = v5 + 1;
        };
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(&arg1)) {
            let v8 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
            let v9 = *0x1::vector::borrow<vector<u64>>(&v8, (*0x1::vector::borrow<u16>(&v1, v7) as u64));
            let v10 = 0;
            loop {
                if (*0x1::vector::borrow<u64>(&v9, v10) == *0x1::vector::borrow<u64>(&v4, v7)) {
                    break
                };
                v10 = v10 + 1;
            };
            0x1::vector::push_back<u16>(&mut v6, (v10 as u16));
            v7 = v7 + 1;
        };
        let v11 = &arg1;
        let v12 = vector[];
        let v13 = 0;
        while (v13 < 0x1::vector::length<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v11)) {
            0x1::vector::push_back<u64>(&mut v12, 0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::price_node_to(0x1::vector::borrow<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(v11, v13)));
            v13 = v13 + 1;
        };
        let v14 = vector[];
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::paths::PriceNode>(&arg1)) {
            let v16 = vector[vector[11, 0], vector[14, 11], vector[14, 0], vector[3, 0], vector[12, 8], vector[13, 0], vector[7, 8], vector[2, 0], vector[6, 0], vector[10, 0], vector[13, 11], vector[13, 16], vector[13, 9], vector[13, 19], vector[16, 8], vector[9, 18], vector[15, 8], vector[18, 8], vector[5, 0], vector[8, 19], vector[8, 17], vector[13, 8], vector[16, 0], vector[13, 10], vector[17, 0], vector[13, 0], vector[12, 8], vector[0, 12], vector[3, 0], vector[2, 0], vector[0, 13], vector[0, 8], vector[4, 0], vector[15, 8], vector[5, 0], vector[11, 4], vector[10, 0]];
            let v17 = *0x1::vector::borrow<vector<u64>>(&v16, (*0x1::vector::borrow<u16>(&v1, v15) as u64));
            let v18 = 0;
            loop {
                if (*0x1::vector::borrow<u64>(&v17, v18) == *0x1::vector::borrow<u64>(&v12, v15)) {
                    break
                };
                v18 = v18 + 1;
            };
            0x1::vector::push_back<u16>(&mut v14, (v18 as u16));
            v15 = v15 + 1;
        };
        let v19 = 0;
        let v20 = 0x2::bag::new(arg7);
        0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut v20, b"", arg2);
        while (v19 < 0x1::vector::length<u16>(&v1)) {
            let v21 = *0x1::vector::borrow<u16>(&v1, v19);
            if (v21 == 0) {
                abort 9223374008244764671
            };
            if (v21 == 1) {
                0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::swap_bag<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg0, &mut v20, arg3, *0x1::vector::borrow<u16>(&v6, v19), arg5, arg6, arg7);
            } else if (v21 == 2) {
                0xd94b26beaa62b2122ff0e087f20a070645e4d0d23a1bb02f9faa6dc0beb0ccd5::cetus::swap_bag<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg0, &mut v20, arg4, *0x1::vector::borrow<u16>(&v6, v19), arg5, arg6, arg7);
            };
            v19 = v19 + 1;
        };
        0x2::bag::destroy_empty(v20);
        0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(&mut v20, b"")
    }

    // decompiled from Move bytecode v6
}

