module 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::aaeb58f742bb7d09d {
    struct Aacc01655d0dfbab1 has drop {
        a49526e8be3cf123e: vector<u64>,
        aa784e08665117e43: vector<u64>,
        afc35d9b0ccb52fbe: vector<u64>,
        a650b4a54924e6b42: vector<u64>,
        ad7573a5b071d6a42: u64,
        a27d645b0fcb2dc75: u64,
        ab814e822c301efb4: u64,
        a021d28fd92bb1654: u64,
    }

    public fun a021d28fd92bb1654(arg0: &Aacc01655d0dfbab1) : u64 {
        arg0.a021d28fd92bb1654
    }

    public(friend) fun a05c79de03729de86(arg0: &Aacc01655d0dfbab1, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = arg0.a27d645b0fcb2dc75;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0.afc35d9b0ccb52fbe)) {
            if (arg1 == 0) {
                break
            };
            let v3 = *0x1::vector::borrow<u64>(&arg0.afc35d9b0ccb52fbe, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg0.a650b4a54924e6b42, v2);
            if (v4 == 0) {
                v2 = v2 + 1;
                continue
            };
            v1 = v3;
            let v5 = (((v4 as u128) * (v3 as u128) / 1000000000) as u64);
            if (arg1 >= v5) {
                v0 = v0 + v4;
                arg1 = arg1 - v5;
            } else {
                v0 = v0 + (((arg1 as u128) * 1000000000 / (v3 as u128)) as u64);
                arg1 = 0;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public(friend) fun a27098c94605e3b6a(arg0: &Aacc01655d0dfbab1, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = arg0.ad7573a5b071d6a42;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0.a49526e8be3cf123e)) {
            if (arg1 == 0) {
                break
            };
            let v3 = *0x1::vector::borrow<u64>(&arg0.a49526e8be3cf123e, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg0.aa784e08665117e43, v2);
            if (v4 == 0) {
                v2 = v2 + 1;
                continue
            };
            v1 = v3;
            let v5 = if (arg1 >= v4) {
                v4
            } else {
                arg1
            };
            v0 = v0 + (((v5 as u128) * (v3 as u128) / 1000000000) as u64);
            arg1 = arg1 - v5;
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun a27d645b0fcb2dc75(arg0: &Aacc01655d0dfbab1) : u64 {
        arg0.a27d645b0fcb2dc75
    }

    public(friend) fun a2daef4381117fe2e(arg0: &0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg3: u64, arg4: &0x2::clock::Clock) : Aacc01655d0dfbab1 {
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg2)) {
            let v9 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg2, v8);
            v8 = v8 + 1;
            if (0x2::clock::timestamp_ms(arg4) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v9)) {
                continue
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9)) {
                continue
            };
            let (v10, v11, _) = 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a10868438248226c1::a726fc82fd84e5e03(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v9));
            let v13 = v11;
            if (v10) {
                let (v14, v15) = 0x1::vector::index_of<u64>(&v7, &v13);
                if (!v14) {
                    continue
                };
                let v16 = 0x1::vector::borrow_mut<u64>(&mut v6, v15);
                let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9);
                assert!(*v16 >= v17, 13906835145005989887);
                *v16 = *v16 - v17;
                continue
            };
            let (v18, v19) = 0x1::vector::index_of<u64>(&v5, &v13);
            if (!v18) {
                continue
            };
            let v20 = 0x1::vector::borrow_mut<u64>(&mut v4, v19);
            let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9);
            assert!(*v20 >= v21, 13906835200840564735);
            *v20 = *v20 - v21;
        };
        let v22 = 0;
        while (v22 < 0x1::vector::length<u64>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v6, v22) < 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::ad2616e93a0796e5b(arg0)) {
                v22 = v22 + 1;
            } else {
                break
            };
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v5)) {
            if (*0x1::vector::borrow<u64>(&v4, v23) < 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::ad2616e93a0796e5b(arg0)) {
                v23 = v23 + 1;
            } else {
                break
            };
        };
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v6, v24) == 0) {
                v24 = v24 + 1;
            } else {
                break
            };
        };
        let v25 = 0;
        while (v25 < 0x1::vector::length<u64>(&v5)) {
            if (*0x1::vector::borrow<u64>(&v4, v25) == 0) {
                v25 = v25 + 1;
            } else {
                break
            };
        };
        Aacc01655d0dfbab1{
            a49526e8be3cf123e : v7,
            aa784e08665117e43 : v6,
            afc35d9b0ccb52fbe : v5,
            a650b4a54924e6b42 : v4,
            ad7573a5b071d6a42 : *0x1::vector::borrow<u64>(&v7, v22),
            a27d645b0fcb2dc75 : *0x1::vector::borrow<u64>(&v5, v23),
            ab814e822c301efb4 : *0x1::vector::borrow<u64>(&v7, v24),
            a021d28fd92bb1654 : *0x1::vector::borrow<u64>(&v5, v25),
        }
    }

    public fun a49526e8be3cf123e(arg0: &Aacc01655d0dfbab1) : &vector<u64> {
        &arg0.a49526e8be3cf123e
    }

    public fun a650b4a54924e6b42(arg0: &Aacc01655d0dfbab1) : &vector<u64> {
        &arg0.a650b4a54924e6b42
    }

    public fun aa784e08665117e43(arg0: &Aacc01655d0dfbab1) : &vector<u64> {
        &arg0.aa784e08665117e43
    }

    public fun ab814e822c301efb4(arg0: &Aacc01655d0dfbab1) : u64 {
        arg0.ab814e822c301efb4
    }

    public(friend) fun ad2b2505b5ae4a829(arg0: &Aacc01655d0dfbab1, arg1: &0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::A0ea878587b719a64, arg2: u64, arg3: bool, arg4: u64) : u64 {
        if (arg3) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg0.a49526e8be3cf123e)) {
                let v1 = *0x1::vector::borrow<u64>(&arg0.a49526e8be3cf123e, v0);
                if (v1 >= arg2) {
                    v0 = v0 + 1;
                    continue
                };
                if (*0x1::vector::borrow<u64>(&arg0.aa784e08665117e43, v0) < 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::ad2616e93a0796e5b(arg1)) {
                    v0 = v0 + 1;
                    continue
                };
                return v1 + arg4
            };
        } else {
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg0.afc35d9b0ccb52fbe)) {
                let v3 = *0x1::vector::borrow<u64>(&arg0.afc35d9b0ccb52fbe, v2);
                if (v3 <= arg2) {
                    v2 = v2 + 1;
                    continue
                };
                if (*0x1::vector::borrow<u64>(&arg0.a650b4a54924e6b42, v2) < 0x7704836b991086c5dab1bdcc8991d5d162711cd994bf1d2fb44d3316ab5be450::a783956f993d811bc::ad2616e93a0796e5b(arg1)) {
                    v2 = v2 + 1;
                    continue
                };
                return v3 - arg4
            };
        };
        arg2
    }

    public fun ad7573a5b071d6a42(arg0: &Aacc01655d0dfbab1) : u64 {
        arg0.ad7573a5b071d6a42
    }

    public fun afc35d9b0ccb52fbe(arg0: &Aacc01655d0dfbab1) : &vector<u64> {
        &arg0.afc35d9b0ccb52fbe
    }

    // decompiled from Move bytecode v6
}

