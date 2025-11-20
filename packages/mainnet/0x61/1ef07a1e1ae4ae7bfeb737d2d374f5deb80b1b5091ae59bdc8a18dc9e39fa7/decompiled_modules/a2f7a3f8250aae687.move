module 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2f7a3f8250aae687 {
    struct Aa4652e2da86fbb61 has copy, drop {
        ac7f210fc32637b79: bool,
        pool: 0x1::string::String,
        aefb8102bf036ff88: u64,
        a8108687c4de4ea83: u128,
        a300f5009218579d6: u128,
        a44bce80f10717132: bool,
        ada1b3c8a2397a876: bool,
    }

    struct Ae5270409c4a31d29 has copy, drop {
        a31f11751781e6c71: u64,
        a9df70c4191cc59c8: u64,
        ac7f210fc32637b79: bool,
        pool: 0x1::string::String,
        a1c7efc41c3937d9d: u64,
        a7d027a58611a0718: 0x2::object::ID,
    }

    struct Ab0784991b4b97608 has copy, drop {
        a547282f0fe3920e7: u64,
        ab44f992cf846f2cf: u64,
        ae8101499fdb44afd: u64,
        af606f9990a27847d: u64,
        a909b08d73b16bc75: u64,
        adb7acd0b88587e33: u64,
        a888bd220dbabe932: vector<Aa4652e2da86fbb61>,
        a1c7efc41c3937d9d: u64,
    }

    struct A44dc07697c5e5041 has copy, drop {
        price: u64,
        a4c9f6a30dfcb26d4: u64,
    }

    fun a699d557e137ab980(arg0: A44dc07697c5e5041, arg1: A44dc07697c5e5041, arg2: A44dc07697c5e5041) : (A44dc07697c5e5041, A44dc07697c5e5041, A44dc07697c5e5041) {
        let (v0, v1) = if (arg0.price >= arg1.price) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = if (v3.price >= arg2.price) {
            (v3, arg2)
        } else {
            (arg2, v3)
        };
        let v6 = v5;
        let (v7, v8) = if (v2.price >= v6.price) {
            (v2, v6)
        } else {
            (v6, v2)
        };
        (v4, v7, v8)
    }

    fun a952d36d1e6d37f5f(arg0: A44dc07697c5e5041, arg1: A44dc07697c5e5041, arg2: A44dc07697c5e5041) : (A44dc07697c5e5041, A44dc07697c5e5041, A44dc07697c5e5041) {
        let (v0, v1) = if (arg0.price <= arg1.price) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = if (v3.price <= arg2.price) {
            (v3, arg2)
        } else {
            (arg2, v3)
        };
        let v6 = v5;
        let (v7, v8) = if (v2.price <= v6.price) {
            (v2, v6)
        } else {
            (v6, v2)
        };
        (v4, v7, v8)
    }

    public(friend) fun adc6afbc22cb36f39(arg0: &0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: &mut u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (!0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::ada14a7c9727063c9(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg13) < *arg12 + 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::ae9a4ee60c1c9da40(arg0)) {
            return
        };
        let v0 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a099d08408fdb4a75();
        let (v1, v2) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(&v0, arg4);
        let v3 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a099d08408fdb4a75();
        let (v4, v5) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(&v3, arg6);
        let v6 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a099d08408fdb4a75();
        let (v7, v8) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ae3e8a1f78ac1be2d(&v6, arg8);
        let v9 = Ab0784991b4b97608{
            a547282f0fe3920e7 : v2,
            ab44f992cf846f2cf : v1,
            ae8101499fdb44afd : v5,
            af606f9990a27847d : v4,
            a909b08d73b16bc75 : v7,
            adb7acd0b88587e33 : v8,
            a888bd220dbabe932 : 0x1::vector::empty<Aa4652e2da86fbb61>(),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg13),
        };
        let v10 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000;
        if (0x1::u64::min(0x1::u64::min(v1, v4), v7) + v10 > arg11 && 0x1::u64::max(0x1::u64::max(v2, v5), v8) < arg11 + v10) {
            0x2::event::emit<Ab0784991b4b97608>(v9);
            return
        };
        let v11 = A44dc07697c5e5041{
            price             : v1,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a9706b71488d40615(),
        };
        let v12 = A44dc07697c5e5041{
            price             : v4,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::ae0a2f8b7674831a4(),
        };
        let v13 = A44dc07697c5e5041{
            price             : v7,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::afe80a6b6b615d930(),
        };
        let (v14, v15, v16) = a952d36d1e6d37f5f(v11, v12, v13);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::aabf49d2de82cae44(arg0) && v19.price + v10 <= arg11) {
            let v20 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v19.a4c9f6a30dfcb26d4, true, arg13, arg14);
            0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, v20);
            if (v18.price + v10 <= arg11) {
                let v21 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v18.a4c9f6a30dfcb26d4, true, arg13, arg14);
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, v21);
                if (v17.price + v10 <= arg11) {
                    let v22 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v17.a4c9f6a30dfcb26d4, true, arg13, arg14);
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, v22);
                };
            };
        };
        let v23 = A44dc07697c5e5041{
            price             : v2,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a9706b71488d40615(),
        };
        let v24 = A44dc07697c5e5041{
            price             : v5,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::ae0a2f8b7674831a4(),
        };
        let v25 = A44dc07697c5e5041{
            price             : v8,
            a4c9f6a30dfcb26d4 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::afe80a6b6b615d930(),
        };
        let (v26, v27, v28) = a699d557e137ab980(v23, v24, v25);
        let v29 = v28;
        let v30 = v27;
        let v31 = v26;
        if (v31.price >= arg11 + v10) {
            let v32 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v31.a4c9f6a30dfcb26d4, false, arg13, arg14);
            0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, v32);
            if (v30.price >= arg11 + v10) {
                let v33 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v30.a4c9f6a30dfcb26d4, false, arg13, arg14);
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, v33);
                if (v29.price >= arg11 + v10) {
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v9.a888bd220dbabe932, afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v29.a4c9f6a30dfcb26d4, false, arg13, arg14));
                };
            };
        };
        let v34 = &v9.a888bd220dbabe932;
        let v35 = 0;
        while (v35 < 0x1::vector::length<Aa4652e2da86fbb61>(v34)) {
            if (0x1::vector::borrow<Aa4652e2da86fbb61>(v34, v35).ada1b3c8a2397a876) {
                *arg12 = 0x2::clock::timestamp_ms(arg13);
            };
            v35 = v35 + 1;
        };
        0x2::event::emit<Ab0784991b4b97608>(v9);
    }

    fun afc08853f58c750bf(arg0: &0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        if (arg12 == 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::ae0a2f8b7674831a4()) {
            let v1 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a099d08408fdb4a75();
            if (arg13) {
                let v2 = &v1;
                let v3 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a29522d5809d7e86e(v2),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v4 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000;
                let v5 = arg11 - v4 - arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ad309a39ae203b2a9(v2, arg6) / 1000000;
                v3.aefb8102bf036ff88 = v5;
                let v6 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ac019152139aa990a(v2, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6), v5);
                v3.a8108687c4de4ea83 = v6;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v2) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6) >= v6 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v2) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6) <= v6) {
                    v3
                } else {
                    let (v7, _) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v2, arg6);
                    let v9 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v7, arg11, true);
                    let v10 = v9;
                    let v11 = arg11 - v4;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg10, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v9, v11), arg14, arg15);
                    let v12 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v11);
                    if (v9 > v12) {
                        v10 = v12;
                    };
                    if (v10 < 1 * 1000000000) {
                        v3.a44bce80f10717132 = true;
                        v3
                    } else {
                        let (v13, v14) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a44e5f8062dd6fde6(v2, arg2, arg6, arg7, v10, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v10, v11), v6, arg14, arg15);
                        let v15 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v13,
                            a9df70c4191cc59c8 : v14,
                            ac7f210fc32637b79 : true,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a29522d5809d7e86e(v2),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v15);
                        v3.ada1b3c8a2397a876 = true;
                        v3
                    }
                }
            } else {
                let v16 = &v1;
                let v17 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a29522d5809d7e86e(v16),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v18 = arg11 + 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000 + arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ad309a39ae203b2a9(v16, arg6) / 1000000;
                v17.aefb8102bf036ff88 = v18;
                let v19 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a213fd2a6b463b66d(v16, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6), v18);
                v17.a8108687c4de4ea83 = v19;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v16) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6) <= v19 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v16) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6) >= v19) {
                    v17
                } else {
                    let (_, v21) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v16, arg6);
                    let v22 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v21, arg11, false);
                    let v23 = v22;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg10, v22, arg14, arg15);
                    let v24 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v22 > v24) {
                        v23 = v24;
                    };
                    if (v23 < 1 * 1000000000) {
                        v17.a44bce80f10717132 = true;
                        v17
                    } else {
                        let (v25, v26) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::af81a08da76e37dc0(v16, arg2, arg6, arg7, v23, v19, arg14, arg15);
                        let v27 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v25,
                            a9df70c4191cc59c8 : v26,
                            ac7f210fc32637b79 : false,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a2ec4300f6df080d1::a29522d5809d7e86e(v16),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v27);
                        v17.ada1b3c8a2397a876 = true;
                        v17
                    }
                }
            }
        } else if (arg12 == 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a9706b71488d40615()) {
            let v28 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a099d08408fdb4a75();
            if (arg13) {
                let v29 = &v28;
                let v30 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a29522d5809d7e86e(v29),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v31 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000;
                let v32 = arg11 - v31 - arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ad309a39ae203b2a9(v29, arg4) / 1000000;
                v30.aefb8102bf036ff88 = v32;
                let v33 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ac019152139aa990a(v29, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4), v32);
                v30.a8108687c4de4ea83 = v33;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v29) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4) >= v33 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v29) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4) <= v33) {
                    v30
                } else {
                    let (v34, _) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v29, arg4);
                    let v36 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v34, arg11, true);
                    let v37 = v36;
                    let v38 = arg11 - v31;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg10, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v36, v38), arg14, arg15);
                    let v39 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v38);
                    if (v36 > v39) {
                        v37 = v39;
                    };
                    if (v37 < 1 * 1000000000) {
                        v30.a44bce80f10717132 = true;
                        v30
                    } else {
                        let (v40, v41) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a44e5f8062dd6fde6(v29, arg2, arg4, arg5, v37, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v37, v38), v33, arg14, arg15);
                        let v42 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v40,
                            a9df70c4191cc59c8 : v41,
                            ac7f210fc32637b79 : true,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a29522d5809d7e86e(v29),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v42);
                        v30.ada1b3c8a2397a876 = true;
                        v30
                    }
                }
            } else {
                let v43 = &v28;
                let v44 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a29522d5809d7e86e(v43),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v45 = arg11 + 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000 + arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ad309a39ae203b2a9(v43, arg4) / 1000000;
                v44.aefb8102bf036ff88 = v45;
                let v46 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a213fd2a6b463b66d(v43, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4), v45);
                v44.a8108687c4de4ea83 = v46;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v43) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4) <= v46 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v43) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4) >= v46) {
                    v44
                } else {
                    let (_, v48) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v43, arg4);
                    let v49 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v48, arg11, false);
                    let v50 = v49;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg10, v49, arg14, arg15);
                    let v51 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v49 > v51) {
                        v50 = v51;
                    };
                    if (v50 < 1 * 1000000000) {
                        v44.a44bce80f10717132 = true;
                        v44
                    } else {
                        let (v52, v53) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::af81a08da76e37dc0(v43, arg2, arg4, arg5, v50, v46, arg14, arg15);
                        let v54 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v52,
                            a9df70c4191cc59c8 : v53,
                            ac7f210fc32637b79 : false,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::aa3c3c838649f8f32::a29522d5809d7e86e(v43),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v54);
                        v44.ada1b3c8a2397a876 = true;
                        v44
                    }
                }
            }
        } else {
            assert!(arg12 == 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::afe80a6b6b615d930(), 13906835939574939647);
            let v55 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a099d08408fdb4a75();
            if (arg13) {
                let v56 = &v55;
                let v57 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a29522d5809d7e86e(v56),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v58 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000;
                let v59 = arg11 - v58 - arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ad309a39ae203b2a9(v56, arg8) / 1000000;
                v57.aefb8102bf036ff88 = v59;
                let v60 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ac019152139aa990a(v56, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8), v59);
                v57.a8108687c4de4ea83 = v60;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a3bf20a19fec6c3ca(v56) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8) >= v60 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a3bf20a19fec6c3ca(v56) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8) <= v60) {
                    v57
                } else {
                    let (v61, _) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v56, arg8);
                    let v63 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v61, arg11, true);
                    let v64 = v63;
                    let v65 = arg11 - v58;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg10, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v63, v65), arg14, arg15);
                    let v66 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v65);
                    if (v63 > v66) {
                        v64 = v66;
                    };
                    if (v64 < 1 * 1000000000) {
                        v57.a44bce80f10717132 = true;
                        v57
                    } else {
                        let (v67, v68) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a44e5f8062dd6fde6(v56, arg2, arg8, arg9, v64, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v64, v65), v60, arg14, arg15);
                        let v69 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v67,
                            a9df70c4191cc59c8 : v68,
                            ac7f210fc32637b79 : true,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a29522d5809d7e86e(v56),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v69);
                        v57.ada1b3c8a2397a876 = true;
                        v57
                    }
                }
            } else {
                let v70 = &v55;
                let v71 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a29522d5809d7e86e(v70),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v72 = arg11 + 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000 + arg11 * 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ad309a39ae203b2a9(v70, arg8) / 1000000;
                v71.aefb8102bf036ff88 = v72;
                let v73 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a213fd2a6b463b66d(v70, 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8), v72);
                v71.a8108687c4de4ea83 = v73;
                if (0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a3bf20a19fec6c3ca(v70) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8) <= v73 || !0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a3bf20a19fec6c3ca(v70) && 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8) >= v73) {
                    v71
                } else {
                    let (_, v75) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v70, arg8);
                    let v76 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v75, arg11, false);
                    let v77 = v76;
                    0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg10, v76, arg14, arg15);
                    let v78 = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v76 > v78) {
                        v77 = v78;
                    };
                    if (v77 < 1 * 1000000000) {
                        v71.a44bce80f10717132 = true;
                        v71
                    } else {
                        let (v79, v80) = 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::af81a08da76e37dc0(v70, arg2, arg8, arg9, v77, v73, arg14, arg15);
                        let v81 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v79,
                            a9df70c4191cc59c8 : v80,
                            ac7f210fc32637b79 : false,
                            pool              : 0x611ef07a1e1ae4ae7bfeb737d2d374f5deb80b1b5091ae59bdc8a18dc9e39fa7::a3029a63d54b9410b::a29522d5809d7e86e(v70),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg14),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v81);
                        v71.ada1b3c8a2397a876 = true;
                        v71
                    }
                }
            }
        }
    }

    // decompiled from Move bytecode v6
}

