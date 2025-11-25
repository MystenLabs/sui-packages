module 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2f7a3f8250aae687 {
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

    fun a143d34c56ac6fc77(arg0: &0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg14: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: u64, arg16: &vector<A44dc07697c5e5041>, arg17: u64, arg18: &mut Ab0784991b4b97608, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<A44dc07697c5e5041>(arg16)) {
            let v1 = 0x1::vector::borrow<A44dc07697c5e5041>(arg16, v0);
            if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::aabf49d2de82cae44(arg0) && v1.price + arg17 <= arg15) {
                let v2 = v1.a4c9f6a30dfcb26d4;
                if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::ae0a2f8b7674831a4()) {
                    let v3 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a099d08408fdb4a75();
                    let v4 = &v3;
                    let v5 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v5 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ad3e49cf279957e7d(v4, arg0)) {
                        v5
                    } else {
                        let v6 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v7 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000;
                        let v8 = arg15 - v7 - arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v5.aefb8102bf036ff88 = v8;
                        let v9 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ac019152139aa990a(v4, v6, v8);
                        v5.a8108687c4de4ea83 = v9;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 >= v9 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 <= v9) {
                            v5
                        } else {
                            let (v10, _) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v12 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v10, arg15, true);
                            let v13 = v12;
                            let v14 = arg15 - v7;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v12, v14), arg19, arg20);
                            let v15 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v14);
                            if (v12 > v15) {
                                v13 = v15;
                            };
                            if (v13 < 1 * 1000000000) {
                                v5.a44bce80f10717132 = true;
                                v5
                            } else {
                                let (v16, v17) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a44e5f8062dd6fde6(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v13, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v13, v14), v9, arg19, arg20);
                                let v18 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v16,
                                    a9df70c4191cc59c8 : v17,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v18);
                                v5.ada1b3c8a2397a876 = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v5);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::a9706b71488d40615()) {
                    let v19 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a099d08408fdb4a75();
                    let v20 = &v19;
                    let v21 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a29522d5809d7e86e(v20),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v21 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ad3e49cf279957e7d(v20, arg0)) {
                        v21
                    } else {
                        let v22 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v23 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000;
                        let v24 = arg15 - v23 - arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::get_fee_rate(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v21.aefb8102bf036ff88 = v24;
                        let v25 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ac019152139aa990a(v20, v22, v24);
                        v21.a8108687c4de4ea83 = v25;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v20) && v22 >= v25 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v20) && v22 <= v25) {
                            v21
                        } else {
                            let (v26, _) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v28 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v26, arg15, true);
                            let v29 = v28;
                            let v30 = arg15 - v23;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v28, v30), arg19, arg20);
                            let v31 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v30);
                            if (v28 > v31) {
                                v29 = v31;
                            };
                            if (v29 < 1 * 1000000000) {
                                v21.a44bce80f10717132 = true;
                                v21
                            } else {
                                let (v32, v33) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a44e5f8062dd6fde6(v20, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v29, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v29, v30), v25, arg19, arg20);
                                let v34 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v32,
                                    a9df70c4191cc59c8 : v33,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a29522d5809d7e86e(v20),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v34);
                                v21.ada1b3c8a2397a876 = true;
                                v21
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v21);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::afe80a6b6b615d930()) {
                    let v35 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a099d08408fdb4a75();
                    let v36 = &v35;
                    let v37 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a29522d5809d7e86e(v36),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v37 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ad3e49cf279957e7d(v36, arg0)) {
                        v37
                    } else {
                        let v38 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v39 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000;
                        let v40 = arg15 - v39 - arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::get_fee_rate(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v37.aefb8102bf036ff88 = v40;
                        let v41 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ac019152139aa990a(v36, v38, v40);
                        v37.a8108687c4de4ea83 = v41;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a3bf20a19fec6c3ca(v36) && v38 >= v41 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a3bf20a19fec6c3ca(v36) && v38 <= v41) {
                            v37
                        } else {
                            let (v42, _) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v44 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v42, arg15, true);
                            let v45 = v44;
                            let v46 = arg15 - v39;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v44, v46), arg19, arg20);
                            let v47 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v46);
                            if (v44 > v47) {
                                v45 = v47;
                            };
                            if (v45 < 1 * 1000000000) {
                                v37.a44bce80f10717132 = true;
                                v37
                            } else {
                                let (v48, v49) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a44e5f8062dd6fde6(v36, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v45, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v45, v46), v41, arg19, arg20);
                                let v50 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v48,
                                    a9df70c4191cc59c8 : v49,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a29522d5809d7e86e(v36),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v50);
                                v37.ada1b3c8a2397a876 = true;
                                v37
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v37);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::af95ffd01d13caab1()) {
                    let v51 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a099d08408fdb4a75();
                    let v52 = &v51;
                    let v53 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : true,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a29522d5809d7e86e(v52),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v53 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ad3e49cf279957e7d(v52, arg0)) {
                        v53
                    } else {
                        let v54 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v55 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000;
                        let v56 = arg15 - v55 - arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::get_fee_rate(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v53.aefb8102bf036ff88 = v56;
                        let v57 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ac019152139aa990a(v52, v54, v56);
                        v53.a8108687c4de4ea83 = v57;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a3bf20a19fec6c3ca(v52) && v54 >= v57 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a3bf20a19fec6c3ca(v52) && v54 <= v57) {
                            v53
                        } else {
                            let (v58, _) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v60 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v58, arg15, true);
                            let v61 = v60;
                            let v62 = arg15 - v55;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v60, v62), arg19, arg20);
                            let v63 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v62);
                            if (v60 > v63) {
                                v61 = v63;
                            };
                            if (v61 < 1 * 1000000000) {
                                v53.a44bce80f10717132 = true;
                                v53
                            } else {
                                let (v64, v65) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a44e5f8062dd6fde6(v52, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v61, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v61, v62), v57, arg19, arg20);
                                let v66 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v64,
                                    a9df70c4191cc59c8 : v65,
                                    ac7f210fc32637b79 : true,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a29522d5809d7e86e(v52),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v66);
                                v53.ada1b3c8a2397a876 = true;
                                v53
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v53);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun a3cd6d91ca7350f3f(arg0: &0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ad3e462cd25333e7f(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0)) {
            return 0
        };
        0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a7e35067d3a47eeae(arg0) + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a3710772f3b618373(arg0) * (v0 - 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0)) / 1000, arg5)
    }

    fun aa0de02ced96ab01c(arg0: &0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg14: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: u64, arg16: &vector<A44dc07697c5e5041>, arg17: u64, arg18: &mut Ab0784991b4b97608, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<A44dc07697c5e5041>(arg16)) {
            let v1 = 0x1::vector::borrow<A44dc07697c5e5041>(arg16, v0);
            if (v1.price >= arg15 + arg17) {
                let v2 = v1.a4c9f6a30dfcb26d4;
                if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::ae0a2f8b7674831a4()) {
                    let v3 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a099d08408fdb4a75();
                    let v4 = &v3;
                    let v5 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v5 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ad3e49cf279957e7d(v4, arg0)) {
                        v5
                    } else {
                        let v6 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v7 = arg15 + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000 + arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v5.aefb8102bf036ff88 = v7;
                        let v8 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a213fd2a6b463b66d(v4, v6, v7);
                        v5.a8108687c4de4ea83 = v8;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 <= v8 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v4) && v6 >= v8) {
                            v5
                        } else {
                            let (_, v10) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v11 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v10, arg15, false);
                            let v12 = v11;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v11, arg19, arg20);
                            let v13 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v11 > v13) {
                                v12 = v13;
                            };
                            if (v12 < 1 * 1000000000) {
                                v5.a44bce80f10717132 = true;
                                v5
                            } else {
                                let (v14, v15) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::af81a08da76e37dc0(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, v8, arg19, arg20);
                                let v16 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v14,
                                    a9df70c4191cc59c8 : v15,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a29522d5809d7e86e(v4),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v16);
                                v5.ada1b3c8a2397a876 = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v5);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::a9706b71488d40615()) {
                    let v17 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a099d08408fdb4a75();
                    let v18 = &v17;
                    let v19 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a29522d5809d7e86e(v18),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v19 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ad3e49cf279957e7d(v18, arg0)) {
                        v19
                    } else {
                        let v20 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v21 = arg15 + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000 + arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::get_fee_rate(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v19.aefb8102bf036ff88 = v21;
                        let v22 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a213fd2a6b463b66d(v18, v20, v21);
                        v19.a8108687c4de4ea83 = v22;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v18) && v20 <= v22 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v18) && v20 >= v22) {
                            v19
                        } else {
                            let (_, v24) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v25 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v24, arg15, false);
                            let v26 = v25;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v25, arg19, arg20);
                            let v27 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v25 > v27) {
                                v26 = v27;
                            };
                            if (v26 < 1 * 1000000000) {
                                v19.a44bce80f10717132 = true;
                                v19
                            } else {
                                let (v28, v29) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::af81a08da76e37dc0(v18, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v26, v22, arg19, arg20);
                                let v30 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v28,
                                    a9df70c4191cc59c8 : v29,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a29522d5809d7e86e(v18),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v30);
                                v19.ada1b3c8a2397a876 = true;
                                v19
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v19);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::afe80a6b6b615d930()) {
                    let v31 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a099d08408fdb4a75();
                    let v32 = &v31;
                    let v33 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a29522d5809d7e86e(v32),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v33 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ad3e49cf279957e7d(v32, arg0)) {
                        v33
                    } else {
                        let v34 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v35 = arg15 + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000 + arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::get_fee_rate(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v33.aefb8102bf036ff88 = v35;
                        let v36 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a213fd2a6b463b66d(v32, v34, v35);
                        v33.a8108687c4de4ea83 = v36;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a3bf20a19fec6c3ca(v32) && v34 <= v36 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a3bf20a19fec6c3ca(v32) && v34 >= v36) {
                            v33
                        } else {
                            let (_, v38) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v39 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v38, arg15, false);
                            let v40 = v39;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v39, arg19, arg20);
                            let v41 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v39 > v41) {
                                v40 = v41;
                            };
                            if (v40 < 1 * 1000000000) {
                                v33.a44bce80f10717132 = true;
                                v33
                            } else {
                                let (v42, v43) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::af81a08da76e37dc0(v32, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v40, v36, arg19, arg20);
                                let v44 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v42,
                                    a9df70c4191cc59c8 : v43,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a29522d5809d7e86e(v32),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v44);
                                v33.ada1b3c8a2397a876 = true;
                                v33
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v33);
                } else if (v2 == 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::af95ffd01d13caab1()) {
                    let v45 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a099d08408fdb4a75();
                    let v46 = &v45;
                    let v47 = Aa4652e2da86fbb61{
                        ac7f210fc32637b79 : false,
                        pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a29522d5809d7e86e(v46),
                        aefb8102bf036ff88 : 0,
                        a8108687c4de4ea83 : 0,
                        a300f5009218579d6 : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13),
                        a44bce80f10717132 : false,
                        ada1b3c8a2397a876 : false,
                    };
                    let v47 = if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ad3e49cf279957e7d(v46, arg0)) {
                        v47
                    } else {
                        let v48 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                        let v49 = arg15 + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000 + arg15 * 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::get_fee_rate(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13) / 1000000;
                        v47.aefb8102bf036ff88 = v49;
                        let v50 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a213fd2a6b463b66d(v46, v48, v49);
                        v47.a8108687c4de4ea83 = v50;
                        if (0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a3bf20a19fec6c3ca(v46) && v48 <= v50 || !0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a3bf20a19fec6c3ca(v46) && v48 >= v50) {
                            v47
                        } else {
                            let (_, v52) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
                            let v53 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v52, arg15, false);
                            let v54 = v53;
                            0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg14, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v53, arg19, arg20);
                            let v55 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                            if (v53 > v55) {
                                v54 = v55;
                            };
                            if (v54 < 1 * 1000000000) {
                                v47.a44bce80f10717132 = true;
                                v47
                            } else {
                                let (v56, v57) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::af81a08da76e37dc0(v46, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v54, v50, arg19, arg20);
                                let v58 = Ae5270409c4a31d29{
                                    a31f11751781e6c71 : v56,
                                    a9df70c4191cc59c8 : v57,
                                    ac7f210fc32637b79 : false,
                                    pool              : 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a29522d5809d7e86e(v46),
                                    a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg19),
                                    a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<Ae5270409c4a31d29>(v58);
                                v47.ada1b3c8a2397a876 = true;
                                v47
                            }
                        }
                    };
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut arg18.a888bd220dbabe932, v47);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun adc6afbc22cb36f39(arg0: &0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg14: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: u64, arg16: &mut u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        if (!0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a633fa15402372c35(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg17) < *arg16 + 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::ae9a4ee60c1c9da40(arg0)) {
            return
        };
        let v0 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v1 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v2 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::ae0a2f8b7674831a4();
        let v3 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::a099d08408fdb4a75();
        let (v4, v5) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(&v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
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
        let v8 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::a9706b71488d40615();
        let v9 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::a099d08408fdb4a75();
        let (v10, v11) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(&v9, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
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
        let v14 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::afe80a6b6b615d930();
        let v15 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::a099d08408fdb4a75();
        let (v16, v17) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a3029a63d54b9410b::ae3e8a1f78ac1be2d(&v15, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
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
        let v20 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::ad9e4d11aecc532fa::af95ffd01d13caab1();
        let v21 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::a099d08408fdb4a75();
        let (v22, v23) = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a96046ed7ec86c084::ae3e8a1f78ac1be2d(&v21, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
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
        let v26 = Ab0784991b4b97608{
            aab80f1dc57a77584 : v0,
            a8ea67a9d479b4cc3 : v1,
            a888bd220dbabe932 : 0x1::vector::empty<Aa4652e2da86fbb61>(),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg17),
        };
        let v27 = &mut v0;
        let v28 = 0x1::vector::length<A44dc07697c5e5041>(v27);
        if (v28 <= 1) {
        } else {
            let v29 = 0;
            while (v29 < v28) {
                let v30 = 0;
                let v31 = false;
                while (v30 < v28 - v29 - 1) {
                    let v32 = 0x1::vector::borrow<A44dc07697c5e5041>(v27, v30);
                    let v33 = 0x1::vector::borrow<A44dc07697c5e5041>(v27, v30 + 1);
                    let v34 = *v32;
                    let v35 = *v33;
                    if (!(v34.price < v35.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v27, v30) = *v33;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v27, v30 + 1) = *v32;
                        v31 = true;
                    };
                    v30 = v30 + 1;
                };
                if (!v31) {
                    break
                };
                v29 = v29 + 1;
            };
        };
        let v36 = &mut v1;
        let v37 = 0x1::vector::length<A44dc07697c5e5041>(v36);
        if (v37 <= 1) {
        } else {
            let v38 = 0;
            while (v38 < v37) {
                let v39 = 0;
                let v40 = false;
                while (v39 < v37 - v38 - 1) {
                    let v41 = 0x1::vector::borrow<A44dc07697c5e5041>(v36, v39);
                    let v42 = 0x1::vector::borrow<A44dc07697c5e5041>(v36, v39 + 1);
                    let v43 = *v41;
                    let v44 = *v42;
                    if (!(v43.price > v44.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v36, v39) = *v42;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v36, v39 + 1) = *v41;
                        v40 = true;
                    };
                    v39 = v39 + 1;
                };
                if (!v40) {
                    break
                };
                v38 = v38 + 1;
            };
        };
        let v45 = 0x2134a34efdd547b71d12e63026d49913f60f9ca987e7a77c87a9307abda4e8ed::a783956f993d811bc::a0ea1f46e048fbf21(arg0) * arg15 / 10000 / 1000;
        if (0x1::vector::borrow<A44dc07697c5e5041>(&v0, 0).price + v45 > arg15 && 0x1::vector::borrow<A44dc07697c5e5041>(&v1, 0).price < arg15 + v45) {
            0x2::event::emit<Ab0784991b4b97608>(v26);
            return
        };
        let v46 = &mut v26;
        a143d34c56ac6fc77(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v0, v45, v46, arg17, arg18);
        let v47 = &mut v26;
        aa0de02ced96ab01c(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1, v45, v47, arg17, arg18);
        let v48 = &v26.a888bd220dbabe932;
        let v49 = 0;
        while (v49 < 0x1::vector::length<Aa4652e2da86fbb61>(v48)) {
            if (0x1::vector::borrow<Aa4652e2da86fbb61>(v48, v49).ada1b3c8a2397a876) {
                *arg16 = 0x2::clock::timestamp_ms(arg17);
            };
            v49 = v49 + 1;
        };
        0x2::event::emit<Ab0784991b4b97608>(v26);
    }

    // decompiled from Move bytecode v6
}

