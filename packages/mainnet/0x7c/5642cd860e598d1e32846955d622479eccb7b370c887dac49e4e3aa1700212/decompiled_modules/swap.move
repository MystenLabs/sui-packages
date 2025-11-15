module 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::swap {
    struct Aa4652e2da86fbb61 has copy, drop {
        ac7f210fc32637b79: bool,
        pool: 0x1::string::String,
        aefb8102bf036ff88: u64,
        a8108687c4de4ea83: u128,
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
        a1292ba3fd758fee5: u64,
        ab80b3face789416e: u64,
        a888bd220dbabe932: vector<Aa4652e2da86fbb61>,
        a1c7efc41c3937d9d: u64,
    }

    struct A44dc07697c5e5041 has copy, drop {
        price: u64,
        a4c9f6a30dfcb26d4: u64,
    }

    fun a03a7a08b3fc5601f(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"mmt"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 - 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 - arg7 * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = a1134e088837aa9d7(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) >= v2) {
            return v0
        };
        let (v3, _) = a81988e8adaef46c8(arg4);
        let v5 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v3, arg7, true);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg6, 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v5, v3), arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v3);
        if (v5 > v7) {
            v6 = v7;
        };
        if (v6 < 1 * 1000000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, v6, v2, arg8, arg5, arg9);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let (v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v11);
        assert!(v14 == 0, 13906836102783696895);
        let v16 = Ae5270409c4a31d29{
            a31f11751781e6c71 : 0x2::balance::value<0x2::sui::SUI>(&v13),
            a9df70c4191cc59c8 : v15 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"mmt"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v15, arg9);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v17, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v11, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v17), arg5, arg9);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    fun a1134e088837aa9d7(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    fun a34a6cb13f0f0ba27(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    fun a3cd6d91ca7350f3f(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ad3e462cd25333e7f(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0)) {
            return 0
        };
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a7e35067d3a47eeae(arg0) + 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a3710772f3b618373(arg0) * (v0 - 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0)) / 1000, arg5)
    }

    fun a53a6510421a6f072(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"cetus"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 - 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 - arg7 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = acde36a6fa6c393c2(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4) <= v2) {
            return v0
        };
        let (v3, _) = a5f42bce61cf9751a(arg4);
        let v5 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v3, arg7, true);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg6, 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v5, v3), arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v3);
        if (v5 > v7) {
            v6 = v7;
        };
        if (v6 < 1 * 1000000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, true, false, v6, v2, arg8);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v11) - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13);
        let v15 = Ae5270409c4a31d29{
            a31f11751781e6c71 : 0x2::balance::value<0x2::sui::SUI>(&v12),
            a9df70c4191cc59c8 : v14,
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"cetus"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v12, arg9), arg9);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v14, arg9);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16), 0x2::balance::zero<0x2::sui::SUI>(), v11);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    fun a56d3904b8dd7066f(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"mmt"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 + 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 + arg7 * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = a8e0f142d42cfb97e(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) <= v2) {
            return v0
        };
        let (_, v4) = a81988e8adaef46c8(arg4);
        let v5 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v4, arg7, false);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg6, v5, arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
        if (v5 > v7) {
            v6 = v7;
        };
        if (v6 < 1 * 1000000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v6, v2, arg8, arg5, arg9);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let (v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v11);
        assert!(v15 == 0, 13906835540142981119);
        let v16 = v14 - 0x2::balance::value<0x2::sui::SUI>(&v13);
        let v17 = Ae5270409c4a31d29{
            a31f11751781e6c71 : v16,
            a9df70c4191cc59c8 : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"mmt"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v17);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9), arg9);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v16, arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut v18, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v11, 0x2::coin::into_balance<0x2::sui::SUI>(v18), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg5, arg9);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    fun a5f42bce61cf9751a(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>) : (u64, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0);
        let v1 = ((340282366920938463463374607431768211456000000000 / (v0 as u256) * (v0 as u256)) as u64);
        let v2 = v1 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
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

    public fun a71e5099e46e14836(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: &mut u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (!0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::ada14a7c9727063c9(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg13) < *arg12 + 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::ae9a4ee60c1c9da40(arg0)) {
            return
        };
        let (v0, v1) = a81988e8adaef46c8(arg4);
        let (v2, v3) = a5f42bce61cf9751a(arg6);
        let (v4, v5) = ac2bf261a85c7939b(arg8);
        let v6 = Ab0784991b4b97608{
            a547282f0fe3920e7 : v1,
            ab44f992cf846f2cf : v0,
            ae8101499fdb44afd : v3,
            af606f9990a27847d : v2,
            a1292ba3fd758fee5 : v4,
            ab80b3face789416e : v5,
            a888bd220dbabe932 : 0x1::vector::empty<Aa4652e2da86fbb61>(),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg13),
        };
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg11 / 10000 / 1000;
        if (0x1::u64::min(0x1::u64::min(v0, v2), v4) + v7 > arg11 && 0x1::u64::max(0x1::u64::max(v1, v3), v5) < arg11 + v7) {
            0x2::event::emit<Ab0784991b4b97608>(v6);
            return
        };
        let v8 = A44dc07697c5e5041{
            price             : v0,
            a4c9f6a30dfcb26d4 : 0,
        };
        let v9 = A44dc07697c5e5041{
            price             : v2,
            a4c9f6a30dfcb26d4 : 1,
        };
        let v10 = A44dc07697c5e5041{
            price             : v4,
            a4c9f6a30dfcb26d4 : 2,
        };
        let (v11, v12, v13) = a952d36d1e6d37f5f(v8, v9, v10);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        if (0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::aabf49d2de82cae44(arg0) && v16.price + v7 <= arg11) {
            let v17 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v16.a4c9f6a30dfcb26d4, true, arg13, arg14);
            0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, v17);
            if (v15.price + v7 <= arg11) {
                let v18 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v15.a4c9f6a30dfcb26d4, true, arg13, arg14);
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, v18);
                if (v14.price + v7 <= arg11) {
                    let v19 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v14.a4c9f6a30dfcb26d4, true, arg13, arg14);
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, v19);
                };
            };
        };
        let v20 = A44dc07697c5e5041{
            price             : v1,
            a4c9f6a30dfcb26d4 : 0,
        };
        let v21 = A44dc07697c5e5041{
            price             : v3,
            a4c9f6a30dfcb26d4 : 1,
        };
        let v22 = A44dc07697c5e5041{
            price             : v5,
            a4c9f6a30dfcb26d4 : 2,
        };
        let (v23, v24, v25) = a699d557e137ab980(v20, v21, v22);
        let v26 = v25;
        let v27 = v24;
        let v28 = v23;
        if (v28.price >= arg11 + v7) {
            let v29 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v28.a4c9f6a30dfcb26d4, false, arg13, arg14);
            0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, v29);
            if (v27.price >= arg11 + v7) {
                let v30 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v27.a4c9f6a30dfcb26d4, false, arg13, arg14);
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, v30);
                if (v26.price >= arg11 + v7) {
                    0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v6.a888bd220dbabe932, afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v26.a4c9f6a30dfcb26d4, false, arg13, arg14));
                };
            };
        };
        let v31 = &v6.a888bd220dbabe932;
        let v32 = 0;
        while (v32 < 0x1::vector::length<Aa4652e2da86fbb61>(v31)) {
            if (0x1::vector::borrow<Aa4652e2da86fbb61>(v31, v32).ada1b3c8a2397a876) {
                *arg12 = 0x2::clock::timestamp_ms(arg13);
            };
            v32 = v32 + 1;
        };
        0x2::event::emit<Ab0784991b4b97608>(v6);
    }

    fun a81988e8adaef46c8(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = ((1000000000 * (v0 as u256) * (v0 as u256) / 340282366920938463463374607431768211456) as u64);
        let v2 = v1 * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
    }

    fun a8e0f142d42cfb97e(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
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

    fun aad97e24c6145e5cc(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"cetus"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 + 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 + arg7 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = aee479d24be81fbe9(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4) >= v2) {
            return v0
        };
        let (_, v4) = a5f42bce61cf9751a(arg4);
        let v5 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v4, arg7, false);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg6, v5, arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
        if (v5 > v7) {
            v6 = v7;
        };
        if (v6 < 1 * 1000000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, false, true, v6, v2, arg8);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v11) - 0x2::balance::value<0x2::sui::SUI>(&v12);
        let v15 = Ae5270409c4a31d29{
            a31f11751781e6c71 : v14,
            a9df70c4191cc59c8 : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13),
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"cetus"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13, arg9), arg9);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v14, arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut v16, 0x2::coin::from_balance<0x2::sui::SUI>(v12, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(v16), v11);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    fun ac2bf261a85c7939b(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = ((1000000000 * (v0 as u256) * (v0 as u256) / 340282366920938463463374607431768211456) as u64);
        let v2 = v1 * 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
    }

    fun acab78d938826a48b(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"bluefin"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 + 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 + arg7 * 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = a8e0f142d42cfb97e(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) <= v2) {
            return v0
        };
        let (_, v4) = ac2bf261a85c7939b(arg4);
        let v5 = a3cd6d91ca7350f3f(arg0, arg1, arg2, v4, arg7, false);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg6, v5, arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
        if (v5 > v7) {
            v6 = v7;
        };
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v6, v2);
        let v9 = v6 - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v8);
        if (v9 < 1 * 1000000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v9, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, v9, 0, v2);
        let v12 = v11;
        let v13 = v10;
        let v14 = Ae5270409c4a31d29{
            a31f11751781e6c71 : v9 - 0x2::balance::value<0x2::sui::SUI>(&v13),
            a9df70c4191cc59c8 : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
            ac7f210fc32637b79 : false,
            pool              : 0x1::string::utf8(b"bluefin"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9), arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    fun acde36a6fa6c393c2(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
    }

    fun aee479d24be81fbe9(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    fun afc08853f58c750bf(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        if (arg12 == 0 && arg13) {
            a03a7a08b3fc5601f(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg14, arg15)
        } else if (arg12 == 0 && !arg13) {
            a56d3904b8dd7066f(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg14, arg15)
        } else if (arg12 == 1 && arg13) {
            a53a6510421a6f072(arg0, arg1, arg2, arg3, arg6, arg7, arg10, arg11, arg14, arg15)
        } else if (arg12 == 1 && !arg13) {
            aad97e24c6145e5cc(arg0, arg1, arg2, arg3, arg6, arg7, arg10, arg11, arg14, arg15)
        } else if (arg12 == 2 && arg13) {
            affd71c734fc79051(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg14, arg15)
        } else {
            assert!(arg12 == 2 && !arg13, 13906838868742635519);
            acab78d938826a48b(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg14, arg15)
        }
    }

    fun affd71c734fc79051(arg0: &0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        let v0 = Aa4652e2da86fbb61{
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"bluefin"),
            aefb8102bf036ff88 : 0,
            a8108687c4de4ea83 : 0,
            a44bce80f10717132 : false,
            ada1b3c8a2397a876 : false,
        };
        let v1 = arg7 - 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a783956f993d811bc::a082bc5b19227e420(arg0) * arg7 / 10000 / 1000 - arg7 * 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) / 1000000;
        v0.aefb8102bf036ff88 = v1;
        let v2 = a1134e088837aa9d7(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4), v1);
        v0.a8108687c4de4ea83 = v2;
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4) >= v2) {
            return v0
        };
        let (v3, _) = ac2bf261a85c7939b(arg4);
        let v5 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, a3cd6d91ca7350f3f(arg0, arg1, arg2, v3, arg7, true), v3);
        let v6 = v5;
        0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg6, v5, arg8, arg9);
        let v7 = 0x7c5642cd860e598d1e32846955d622479eccb7b370c887dac49e4e3aa1700212::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2);
        if (v5 > v7) {
            v6 = v7;
        };
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, true, v6, v2);
        let v9 = v6 - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v8);
        if (v9 < 1 * 1000000) {
            v0.a44bce80f10717132 = true;
            return v0
        };
        let (v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v9, arg9)), false, true, v9, 18446744073709551615, v2);
        let v12 = v11;
        let v13 = v10;
        let v14 = Ae5270409c4a31d29{
            a31f11751781e6c71 : 0x2::balance::value<0x2::sui::SUI>(&v13),
            a9df70c4191cc59c8 : v9 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
            ac7f210fc32637b79 : true,
            pool              : 0x1::string::utf8(b"bluefin"),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg8),
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<Ae5270409c4a31d29>(v14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9), arg9);
        v0.ada1b3c8a2397a876 = true;
        v0
    }

    // decompiled from Move bytecode v6
}

