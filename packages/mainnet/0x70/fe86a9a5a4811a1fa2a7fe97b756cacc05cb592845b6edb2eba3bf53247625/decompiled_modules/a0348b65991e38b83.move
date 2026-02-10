module 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a0348b65991e38b83 {
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

    public(friend) fun a4f6e7e0f807d8009(arg0: &0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg13: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg14: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg15: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg17: &0x2::clock::Clock, arg18: u64, arg19: bool, arg20: &0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg21: &mut u64, arg22: &mut 0x2::tx_context::TxContext) {
        if (!0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::adb133bf959620b1a(arg0)) {
            return
        };
        let v0 = arg18 * 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a08c9d43f296691a1(arg0) / 1000 / 10000;
        if (arg19 && 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg20) + v0 < arg18) {
            let (v1, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v4 = (arg18 - v0) / v1 * v1;
            let v5 = 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a25cd0a9a0177bf90(arg0) + 1000000 * (arg18 - 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg20) - v0) / 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg20) * 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a0c40826cc82d548a(arg0) / 100, true);
            let v6 = v5;
            0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg4, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v5, v4), arg17, arg22);
            let v7 = 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a10868438248226c1::a0dd9168687113963(arg0, arg2, 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v4), v4);
            if (v5 > v7) {
                v6 = v7;
            };
            let v8 = v6 / v2 * v2;
            if (v8 < 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a25cd0a9a0177bf90(arg0)) {
                a15c536f8ba435e85(b"at_limit");
                return
            };
            if (v4 > 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a82053465eda9bdc4(arg0)) {
                a15c536f8ba435e85(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg17) < *arg21 + 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::ac342a6a5cd6c420e(arg0)) {
                a15c536f8ba435e85(b"within_cooldown");
                return
            };
            if (!0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::aabf49d2de82cae44(arg0)) {
                a15c536f8ba435e85(b"not_allowed");
                return
            };
            let (v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v8, v4);
            a5cbb92dc76b371c3(arg2, arg4, arg5, v9 * 2, arg17, arg22);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v4, v8, true, true, 0x2::clock::timestamp_ms(arg17) + 1000, arg17, arg22);
            *arg21 = 0x2::clock::timestamp_ms(arg17);
        };
        if (!arg19 && arg18 + v0 < 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::ad7573a5b071d6a42(arg20)) {
            let (v11, v12, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v14 = (arg18 + v0 + v11 - 1) / v11 * v11;
            let v15 = 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a25cd0a9a0177bf90(arg0) + 1000000 * (0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::ad7573a5b071d6a42(arg20) - v0 - arg18) / 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::aaeb58f742bb7d09d::a27d645b0fcb2dc75(arg20) * 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a0c40826cc82d548a(arg0) / 100, false);
            let v16 = v15;
            0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg4, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v15, arg17, arg22);
            let v17 = 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
            if (v15 > v17) {
                v16 = v17;
            };
            let v18 = v16 / v12 * v12;
            if (v18 < 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::a25cd0a9a0177bf90(arg0)) {
                a15c536f8ba435e85(b"at_limit");
                return
            };
            if (v14 < 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::af5b451c97d6b5192(arg0)) {
                a15c536f8ba435e85(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg17) < *arg21 + 0x70fe86a9a5a4811a1fa2a7fe97b756cacc05cb592845b6edb2eba3bf53247625::a783956f993d811bc::ac342a6a5cd6c420e(arg0)) {
                a15c536f8ba435e85(b"within_cooldown");
                return
            };
            let (v19, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v18, v14);
            a5cbb92dc76b371c3(arg2, arg4, arg5, v19, arg17, arg22);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v14, v18, false, true, 0x2::clock::timestamp_ms(arg17) + 1000, arg17, arg22);
            *arg21 = 0x2::clock::timestamp_ms(arg17);
        };
    }

    fun a5cbb92dc76b371c3(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
        if (v0 >= arg3) {
            return
        };
        let v1 = (arg3 - v0) * 2;
        let v2 = v1;
        if (v1 < 100 * 1000000) {
            v2 = 100 * 1000000;
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

