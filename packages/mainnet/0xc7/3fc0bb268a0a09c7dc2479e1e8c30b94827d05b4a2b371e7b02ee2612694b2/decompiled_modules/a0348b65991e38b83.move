module 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a0348b65991e38b83 {
    struct Ae1807f915445e017 has copy, drop {
        a717f51b034470d1f: 0x1::string::String,
    }

    struct A39d28c0e018ba745 has copy, drop {
        a70d631a34fc90610: u64,
        a1907c3c9dbf507be: u64,
    }

    public(friend) fun a15c536f8ba435e85(arg0: vector<u8>) {
        let v0 = Ae1807f915445e017{a717f51b034470d1f: 0x1::string::utf8(arg0)};
        0x2::event::emit<Ae1807f915445e017>(v0);
    }

    public(friend) fun a4f6e7e0f807d8009(arg0: &0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: &0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg10: &mut u64, arg11: &0x2::tx_context::TxContext) {
        let v0 = arg7 * 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a08c9d43f296691a1(arg0) / 1000 / 10000;
        if (arg8 && 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg9) + v0 < arg7) {
            let (v1, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v4 = (arg7 - v0) / v1 * v1;
            let v5 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a25cd0a9a0177bf90(arg0) + 1000000 * (arg7 - 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg9) - v0) / 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg9) * 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a0c40826cc82d548a(arg0) / 100, true);
            let v6 = v5;
            0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg4, arg3, 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v5, v4), arg6, arg11);
            let v7 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v4);
            let v8 = v7;
            let v9 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::ac89fc20276c7e30c(arg0, 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::aa2dd106d27c96b47(arg0), v4);
            let v10 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
            if (v10 >= v9) {
                v8 = 0;
            } else {
                let v11 = v9 - v10;
                if (v7 > v11) {
                    v8 = v11;
                };
            };
            if (v5 > v8) {
                v6 = v8;
            };
            let v12 = v6 / v2 * v2;
            if (v12 < 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a25cd0a9a0177bf90(arg0)) {
                a15c536f8ba435e85(b"at_limit");
                return
            };
            if (v4 > 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a82053465eda9bdc4(arg0)) {
                a15c536f8ba435e85(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg6) < *arg10 + 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::ac342a6a5cd6c420e(arg0)) {
                a15c536f8ba435e85(b"within_cooldown");
                return
            };
            if (!0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::aabf49d2de82cae44(arg0)) {
                a15c536f8ba435e85(b"not_allowed");
                return
            };
            let (v13, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v12, v4);
            a5cbb92dc76b371c3(arg2, arg4, arg5, v13 * 2, arg6, arg11);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v4, v12, true, true, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg11);
            *arg10 = 0x2::clock::timestamp_ms(arg6);
        };
        if (!arg8 && arg7 + v0 < 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::ad7573a5b071d6a42(arg9)) {
            let (v15, v16, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v18 = (arg7 + v0 + v15 - 1) / v15 * v15;
            let v19 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a25cd0a9a0177bf90(arg0) + 1000000 * (0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::ad7573a5b071d6a42(arg9) - v0 - arg7) / 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg9) * 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a0c40826cc82d548a(arg0) / 100, false);
            let v20 = v19;
            0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg4, arg3, v19, arg6, arg11);
            let v21 = 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
            if (v19 > v21) {
                v20 = v21;
            };
            let v22 = v20 / v16 * v16;
            if (v22 < 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::a25cd0a9a0177bf90(arg0)) {
                a15c536f8ba435e85(b"at_limit");
                return
            };
            if (v18 < 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::af5b451c97d6b5192(arg0)) {
                a15c536f8ba435e85(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg6) < *arg10 + 0xc73fc0bb268a0a09c7dc2479e1e8c30b94827d05b4a2b371e7b02ee2612694b2::a783956f993d811bc::ac342a6a5cd6c420e(arg0)) {
                a15c536f8ba435e85(b"within_cooldown");
                return
            };
            let (v23, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v22, v18);
            a5cbb92dc76b371c3(arg2, arg4, arg5, v23, arg6, arg11);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v18, v22, false, true, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg11);
            *arg10 = 0x2::clock::timestamp_ms(arg6);
        };
    }

    fun a5cbb92dc76b371c3(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
        if (v0 >= arg3) {
            return
        };
        let v1 = (arg3 - v0) * 2;
        let v2 = v1;
        if (v1 < 10 * 1000000) {
            v2 = 10 * 1000000;
        };
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v6 = v2 / v4 * v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v6, true, false, arg4, arg5);
        let v8 = A39d28c0e018ba745{
            a70d631a34fc90610 : v6,
            a1907c3c9dbf507be : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
        };
        0x2::event::emit<A39d28c0e018ba745>(v8);
    }

    // decompiled from Move bytecode v6
}

