module 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2f7a3f8250aae687 {
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

    struct A44dc07697c5e5041 has copy, drop {
        price: u64,
        a4c9f6a30dfcb26d4: u64,
    }

    struct Ab0784991b4b97608 has copy, drop {
        aab80f1dc57a77584: vector<A44dc07697c5e5041>,
        a8ea67a9d479b4cc3: vector<A44dc07697c5e5041>,
        a888bd220dbabe932: vector<Aa4652e2da86fbb61>,
        a1c7efc41c3937d9d: u64,
    }

    fun a143d34c56ac6fc77(arg0: &0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &vector<A44dc07697c5e5041>, arg18: u64, arg19: &mut Ab0784991b4b97608, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<A44dc07697c5e5041>(arg17)) {
            let v1 = 0x1::vector::borrow<A44dc07697c5e5041>(arg17, v0);
            if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::aabf49d2de82cae44(arg0) && v1.price + arg18 <= arg16) {
                let v2 = v1.a4c9f6a30dfcb26d4;
                if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::aab87bac9248ea5a8()) {
                    let v3 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(0);
                    let v4 = &v3;
                    let v5 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v5 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a7ab2afdf1e994bfb(v4, arg0))) {
                        v5
                    } else {
                        let v6 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v7 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
                        let v8 = arg16 - v7 - arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v5.aefb8102bf036ff88 = v8;
                        let v9 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ac019152139aa990a(v4, v6, v8);
                        v5.a8108687c4de4ea83 = v9;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 >= v9 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 <= v9) {
                            v5
                        } else {
                            let (v10, _) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v12 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v10, arg16, true);
                            let v13 = v12;
                            let v14 = arg16 - v7;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v12, v14), arg20, arg21);
                            let v15 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v14);
                            if (v12 > v15) {
                                v13 = v15;
                            };
                            if (v13 < 1 * 1000000000) {
                                v5.a44bce80f10717132 = true;
                                v5
                            } else {
                                let (v16, v17) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a44e5f8062dd6fde6(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v13, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v13, v14), v9, arg20, arg21);
                                let v18 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v16,
                                    a9df70c4191cc59c8 : v17,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v18);
                                v5.ada1b3c8a2397a876 = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v5);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a761ed5468043598f()) {
                    let v19 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(1);
                    let v20 = &v19;
                    let v21 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v20),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v21 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a7ab2afdf1e994bfb(v20, arg0))) {
                        v21
                    } else {
                        let v22 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v23 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
                        let v24 = arg16 - v23 - arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::get_fee_rate(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v21.aefb8102bf036ff88 = v24;
                        let v25 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ac019152139aa990a(v20, v22, v24);
                        v21.a8108687c4de4ea83 = v25;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v20) && v22 >= v25 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v20) && v22 <= v25) {
                            v21
                        } else {
                            let (v26, _) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v28 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v26, arg16, true);
                            let v29 = v28;
                            let v30 = arg16 - v23;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v28, v30), arg20, arg21);
                            let v31 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v30);
                            if (v28 > v31) {
                                v29 = v31;
                            };
                            if (v29 < 1 * 1000000000) {
                                v21.a44bce80f10717132 = true;
                                v21
                            } else {
                                let (v32, v33) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a44e5f8062dd6fde6(v20, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v29, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v29, v30), v25, arg20, arg21);
                                let v34 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v32,
                                    a9df70c4191cc59c8 : v33,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v20),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v34);
                                v21.ada1b3c8a2397a876 = true;
                                v21
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v21);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a9706b71488d40615()) {
                    let v35 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a099d08408fdb4a75();
                    let v36 = &v35;
                    let v37 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a29522d5809d7e86e(v36),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v37 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a7ab2afdf1e994bfb(v36, arg0))) {
                        v37
                    } else {
                        let v38 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v39 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
                        let v40 = arg16 - v39 - arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::get_fee_rate(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v37.aefb8102bf036ff88 = v40;
                        let v41 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::ac019152139aa990a(v36, v38, v40);
                        v37.a8108687c4de4ea83 = v41;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v36) && v38 >= v41 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v36) && v38 <= v41) {
                            v37
                        } else {
                            let (v42, _) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v44 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v42, arg16, true);
                            let v45 = v44;
                            let v46 = arg16 - v39;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v44, v46), arg20, arg21);
                            let v47 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v46);
                            if (v44 > v47) {
                                v45 = v47;
                            };
                            if (v45 < 1 * 1000000000) {
                                v37.a44bce80f10717132 = true;
                                v37
                            } else {
                                let (v48, v49) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a44e5f8062dd6fde6(v36, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v45, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v45, v46), v41, arg20, arg21);
                                let v50 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v48,
                                    a9df70c4191cc59c8 : v49,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a29522d5809d7e86e(v36),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v50);
                                v37.ada1b3c8a2397a876 = true;
                                v37
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v37);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::afe80a6b6b615d930()) {
                    let v51 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a099d08408fdb4a75();
                    let v52 = &v51;
                    let v53 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a29522d5809d7e86e(v52),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v53 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a7ab2afdf1e994bfb(v52, arg0))) {
                        v53
                    } else {
                        let v54 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v55 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
                        let v56 = arg16 - v55 - arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::get_fee_rate(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v53.aefb8102bf036ff88 = v56;
                        let v57 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::ac019152139aa990a(v52, v54, v56);
                        v53.a8108687c4de4ea83 = v57;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a3bf20a19fec6c3ca(v52) && v54 >= v57 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a3bf20a19fec6c3ca(v52) && v54 <= v57) {
                            v53
                        } else {
                            let (v58, _) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v60 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v58, arg16, true);
                            let v61 = v60;
                            let v62 = arg16 - v55;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v60, v62), arg20, arg21);
                            let v63 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v62);
                            if (v60 > v63) {
                                v61 = v63;
                            };
                            if (v61 < 1 * 1000000000) {
                                v53.a44bce80f10717132 = true;
                                v53
                            } else {
                                let (v64, v65) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a44e5f8062dd6fde6(v52, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v61, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v61, v62), v57, arg20, arg21);
                                let v66 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v64,
                                    a9df70c4191cc59c8 : v65,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a29522d5809d7e86e(v52),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v66);
                                v53.ada1b3c8a2397a876 = true;
                                v53
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v53);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::af95ffd01d13caab1()) {
                    let v67 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a099d08408fdb4a75();
                    let v68 = &v67;
                    let v69 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a29522d5809d7e86e(v68),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v69 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a7ab2afdf1e994bfb(v68, arg0))) {
                        v69
                    } else {
                        let v70 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v71 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
                        let v72 = arg16 - v71 - arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::get_fee_rate(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v69.aefb8102bf036ff88 = v72;
                        let v73 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::ac019152139aa990a(v68, v70, v72);
                        v69.a8108687c4de4ea83 = v73;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a3bf20a19fec6c3ca(v68) && v70 >= v73 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a3bf20a19fec6c3ca(v68) && v70 <= v73) {
                            v69
                        } else {
                            let (v74, _) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v76 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v74, arg16, true);
                            let v77 = v76;
                            let v78 = arg16 - v71;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v76, v78), arg20, arg21);
                            let v79 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v78);
                            if (v76 > v79) {
                                v77 = v79;
                            };
                            if (v77 < 1 * 1000000000) {
                                v69.a44bce80f10717132 = true;
                                v69
                            } else {
                                let (v80, v81) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a44e5f8062dd6fde6(v68, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v77, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v77, v78), v73, arg20, arg21);
                                let v82 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v80,
                                    a9df70c4191cc59c8 : v81,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a29522d5809d7e86e(v68),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v82);
                                v69.ada1b3c8a2397a876 = true;
                                v69
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v69);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun a3cd6d91ca7350f3f(arg0: &0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::A0ea878587b719a64, arg1: &0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ad3e462cd25333e7f(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0)) {
            return 0
        };
        0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a7e35067d3a47eeae(arg0) + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a3710772f3b618373(arg0) * (v0 - 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0)) / 1000, arg5)
    }

    fun aa0de02ced96ab01c(arg0: &0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &vector<A44dc07697c5e5041>, arg18: u64, arg19: &mut Ab0784991b4b97608, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<A44dc07697c5e5041>(arg17)) {
            let v1 = 0x1::vector::borrow<A44dc07697c5e5041>(arg17, v0);
            if (v1.price >= arg16 + arg18) {
                let v2 = v1.a4c9f6a30dfcb26d4;
                if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::aab87bac9248ea5a8()) {
                    let v3 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(0);
                    let v4 = &v3;
                    let v5 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v5 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a7ab2afdf1e994bfb(v4, arg0))) {
                        v5
                    } else {
                        let v6 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v7 = arg16 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000 + arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v5.aefb8102bf036ff88 = v7;
                        let v8 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a213fd2a6b463b66d(v4, v6, v7);
                        v5.a8108687c4de4ea83 = v8;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 <= v8 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 >= v8) {
                            v5
                        } else {
                            let (_, v10) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v11 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v10, arg16, false);
                            let v12 = v11;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v11, arg20, arg21);
                            let v13 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v11 > v13) {
                                v12 = v13;
                            };
                            if (v12 < 1 * 1000000000) {
                                v5.a44bce80f10717132 = true;
                                v5
                            } else {
                                let (v14, v15) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::af81a08da76e37dc0(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v12, v8, arg20, arg21);
                                let v16 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v14,
                                    a9df70c4191cc59c8 : v15,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v16);
                                v5.ada1b3c8a2397a876 = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v5);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a761ed5468043598f()) {
                    let v17 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(1);
                    let v18 = &v17;
                    let v19 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v18),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v19 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a7ab2afdf1e994bfb(v18, arg0))) {
                        v19
                    } else {
                        let v20 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v21 = arg16 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000 + arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::get_fee_rate(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v19.aefb8102bf036ff88 = v21;
                        let v22 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a213fd2a6b463b66d(v18, v20, v21);
                        v19.a8108687c4de4ea83 = v22;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v18) && v20 <= v22 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v18) && v20 >= v22) {
                            v19
                        } else {
                            let (_, v24) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v25 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v24, arg16, false);
                            let v26 = v25;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v25, arg20, arg21);
                            let v27 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v25 > v27) {
                                v26 = v27;
                            };
                            if (v26 < 1 * 1000000000) {
                                v19.a44bce80f10717132 = true;
                                v19
                            } else {
                                let (v28, v29) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::af81a08da76e37dc0(v18, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v26, v22, arg20, arg21);
                                let v30 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v28,
                                    a9df70c4191cc59c8 : v29,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a29522d5809d7e86e(v18),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v30);
                                v19.ada1b3c8a2397a876 = true;
                                v19
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v19);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a9706b71488d40615()) {
                    let v31 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a099d08408fdb4a75();
                    let v32 = &v31;
                    let v33 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a29522d5809d7e86e(v32),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v33 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a7ab2afdf1e994bfb(v32, arg0))) {
                        v33
                    } else {
                        let v34 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v35 = arg16 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000 + arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::get_fee_rate(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v33.aefb8102bf036ff88 = v35;
                        let v36 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a213fd2a6b463b66d(v32, v34, v35);
                        v33.a8108687c4de4ea83 = v36;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v32) && v34 <= v36 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v32) && v34 >= v36) {
                            v33
                        } else {
                            let (_, v38) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v39 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v38, arg16, false);
                            let v40 = v39;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v39, arg20, arg21);
                            let v41 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v39 > v41) {
                                v40 = v41;
                            };
                            if (v40 < 1 * 1000000000) {
                                v33.a44bce80f10717132 = true;
                                v33
                            } else {
                                let (v42, v43) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::af81a08da76e37dc0(v32, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v40, v36, arg20, arg21);
                                let v44 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v42,
                                    a9df70c4191cc59c8 : v43,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a29522d5809d7e86e(v32),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v44);
                                v33.ada1b3c8a2397a876 = true;
                                v33
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v33);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::afe80a6b6b615d930()) {
                    let v45 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a099d08408fdb4a75();
                    let v46 = &v45;
                    let v47 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a29522d5809d7e86e(v46),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v47 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a7ab2afdf1e994bfb(v46, arg0))) {
                        v47
                    } else {
                        let v48 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v49 = arg16 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000 + arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::get_fee_rate(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v47.aefb8102bf036ff88 = v49;
                        let v50 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a213fd2a6b463b66d(v46, v48, v49);
                        v47.a8108687c4de4ea83 = v50;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a3bf20a19fec6c3ca(v46) && v48 <= v50 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a3bf20a19fec6c3ca(v46) && v48 >= v50) {
                            v47
                        } else {
                            let (_, v52) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v53 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v52, arg16, false);
                            let v54 = v53;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v53, arg20, arg21);
                            let v55 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v53 > v55) {
                                v54 = v55;
                            };
                            if (v54 < 1 * 1000000000) {
                                v47.a44bce80f10717132 = true;
                                v47
                            } else {
                                let (v56, v57) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::af81a08da76e37dc0(v46, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v54, v50, arg20, arg21);
                                let v58 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v56,
                                    a9df70c4191cc59c8 : v57,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a29522d5809d7e86e(v46),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v58);
                                v47.ada1b3c8a2397a876 = true;
                                v47
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v47);
                } else if (v2 == 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::af95ffd01d13caab1()) {
                    let v59 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a099d08408fdb4a75();
                    let v60 = &v59;
                    let v61 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a29522d5809d7e86e(v60),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v61 = if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ad3e49cf279957e7d(0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a7ab2afdf1e994bfb(v60, arg0))) {
                        v61
                    } else {
                        let v62 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v63 = arg16 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000 + arg16 * 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::get_fee_rate(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v61.aefb8102bf036ff88 = v63;
                        let v64 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a213fd2a6b463b66d(v60, v62, v63);
                        v61.a8108687c4de4ea83 = v64;
                        if (0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a3bf20a19fec6c3ca(v60) && v62 <= v64 || !0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a3bf20a19fec6c3ca(v60) && v62 >= v64) {
                            v61
                        } else {
                            let (_, v66) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v67 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v66, arg16, false);
                            let v68 = v67;
                            0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v67, arg20, arg21);
                            let v69 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v67 > v69) {
                                v68 = v69;
                            };
                            if (v68 < 1 * 1000000000) {
                                v61.a44bce80f10717132 = true;
                                v61
                            } else {
                                let (v70, v71) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::af81a08da76e37dc0(v60, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v68, v64, arg20, arg21);
                                let v72 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v70,
                                    a9df70c4191cc59c8 : v71,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a29522d5809d7e86e(v60),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg20),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v72);
                                v61.ada1b3c8a2397a876 = true;
                                v61
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg19.a888bd220dbabe932, v61);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun adc6afbc22cb36f39(arg0: &0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &mut u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        if (!0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a633fa15402372c35(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg18) < *arg17 + 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::ae9a4ee60c1c9da40(arg0)) {
            return
        };
        let v0 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v1 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v2 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::aab87bac9248ea5a8();
        let v3 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(0);
        let (v4, v5) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(&v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v6 = A44dc07697c5e5041{
            price             : v4,
            a4c9f6a30dfcb26d4 : v2,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v6);
        let v7 = A44dc07697c5e5041{
            price             : v5,
            a4c9f6a30dfcb26d4 : v2,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v7);
        let v8 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a761ed5468043598f();
        let v9 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::a099d08408fdb4a75(1);
        let (v10, v11) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(&v9, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v12 = A44dc07697c5e5041{
            price             : v10,
            a4c9f6a30dfcb26d4 : v8,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v12);
        let v13 = A44dc07697c5e5041{
            price             : v11,
            a4c9f6a30dfcb26d4 : v8,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v13);
        let v14 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::a9706b71488d40615();
        let v15 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::a099d08408fdb4a75();
        let (v16, v17) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(&v15, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v18 = A44dc07697c5e5041{
            price             : v16,
            a4c9f6a30dfcb26d4 : v14,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v18);
        let v19 = A44dc07697c5e5041{
            price             : v17,
            a4c9f6a30dfcb26d4 : v14,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v19);
        let v20 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::afe80a6b6b615d930();
        let v21 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::a099d08408fdb4a75();
        let (v22, v23) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a3029a63d54b9410b::ae3e8a1f78ac1be2d(&v21, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v24 = A44dc07697c5e5041{
            price             : v22,
            a4c9f6a30dfcb26d4 : v20,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v24);
        let v25 = A44dc07697c5e5041{
            price             : v23,
            a4c9f6a30dfcb26d4 : v20,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v25);
        let v26 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::ad9e4d11aecc532fa::af95ffd01d13caab1();
        let v27 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::a099d08408fdb4a75();
        let (v28, v29) = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a96046ed7ec86c084::ae3e8a1f78ac1be2d(&v27, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v30 = A44dc07697c5e5041{
            price             : v28,
            a4c9f6a30dfcb26d4 : v26,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v30);
        let v31 = A44dc07697c5e5041{
            price             : v29,
            a4c9f6a30dfcb26d4 : v26,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v31);
        let v32 = Ab0784991b4b97608{
            aab80f1dc57a77584 : v0,
            a8ea67a9d479b4cc3 : v1,
            a888bd220dbabe932 : 0x1::vector::empty<Aa4652e2da86fbb61>(),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg18),
        };
        let v33 = &mut v0;
        let v34 = 0x1::vector::length<A44dc07697c5e5041>(v33);
        if (v34 <= 1) {
        } else {
            let v35 = 0;
            while (v35 < v34) {
                let v36 = 0;
                let v37 = false;
                while (v36 < v34 - v35 - 1) {
                    let v38 = 0x1::vector::borrow<A44dc07697c5e5041>(v33, v36);
                    let v39 = 0x1::vector::borrow<A44dc07697c5e5041>(v33, v36 + 1);
                    let v40 = *v38;
                    let v41 = *v39;
                    if (!(v40.price < v41.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v33, v36) = *v39;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v33, v36 + 1) = *v38;
                        v37 = true;
                    };
                    v36 = v36 + 1;
                };
                if (!v37) {
                    break
                };
                v35 = v35 + 1;
            };
        };
        let v42 = &mut v1;
        let v43 = 0x1::vector::length<A44dc07697c5e5041>(v42);
        if (v43 <= 1) {
        } else {
            let v44 = 0;
            while (v44 < v43) {
                let v45 = 0;
                let v46 = false;
                while (v45 < v43 - v44 - 1) {
                    let v47 = 0x1::vector::borrow<A44dc07697c5e5041>(v42, v45);
                    let v48 = 0x1::vector::borrow<A44dc07697c5e5041>(v42, v45 + 1);
                    let v49 = *v47;
                    let v50 = *v48;
                    if (!(v49.price > v50.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v42, v45) = *v48;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v42, v45 + 1) = *v47;
                        v46 = true;
                    };
                    v45 = v45 + 1;
                };
                if (!v46) {
                    break
                };
                v44 = v44 + 1;
            };
        };
        let v51 = 0xa76d2de9002f14c86485d65e7d4f508a8e0543a11a3b64a8116bde51782911b3::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg16 / 10000 / 1000;
        if (0x1::vector::borrow<A44dc07697c5e5041>(&v0, 0).price + v51 > arg16 && 0x1::vector::borrow<A44dc07697c5e5041>(&v1, 0).price < arg16 + v51) {
            0x2::event::emit<Ab0784991b4b97608>(v32);
            return
        };
        let v52 = &mut v32;
        a143d34c56ac6fc77(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &v0, v51, v52, arg18, arg19);
        let v53 = &mut v32;
        aa0de02ced96ab01c(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &v1, v51, v53, arg18, arg19);
        let v54 = &v32.a888bd220dbabe932;
        let v55 = 0;
        while (v55 < 0x1::vector::length<Aa4652e2da86fbb61>(v54)) {
            if (0x1::vector::borrow<Aa4652e2da86fbb61>(v54, v55).ada1b3c8a2397a876) {
                *arg17 = 0x2::clock::timestamp_ms(arg18);
            };
            v55 = v55 + 1;
        };
        0x2::event::emit<Ab0784991b4b97608>(v32);
    }

    // decompiled from Move bytecode v6
}

