module 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::acbdd009a143591b1 {
    public(friend) fun a40f8bc58a06c8b33(arg0: &0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a099d08408fdb4a75();
        let v1 = &v0;
        let v2 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a558d3d4811fa675d(v1, arg5);
        if (!(0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a10868438248226c1::ad3e462cd25333e7f(v2, arg11) <= 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::ac4104d3c58483259(v1, arg5, arg6, v2))) {
            0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a5eefc623c389ac57(v1, arg2, arg1, arg5, arg6, arg12, arg13);
        } else {
            let v3 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a99ab6d0cf8644a81(v1, arg5);
            let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1));
            let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1));
            let v6 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2);
            let v7 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
            let v8 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a783956f993d811bc::ae2894da560e9dfaf(arg0);
            let v9 = if (v6 < v8) {
                v6
            } else {
                v8
            };
            let v10 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a783956f993d811bc::a8f57f404176c397b(arg0);
            let v11 = if (v7 < v10) {
                v7
            } else {
                v10
            };
            let v12 = if (v9 < 1 * 1000000 || v11 < 1 * 1000000000) {
                0
            } else {
                let v13 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a7235c62aa5b27437(v1, arg5, v4, v5, v9, false);
                let v14 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a7235c62aa5b27437(v1, arg5, v4, v5, v11, true);
                if (v13 < v14) {
                    v13
                } else {
                    v14
                }
            };
            0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a6dc79187e3841ff0(v1, arg2, arg1, arg5, arg6, v4, v5, v12, arg12, arg13);
        };
    }

    public(friend) fun a94cdf867cab7cc5c(arg0: &0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg11 <= 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1) && arg12 <= 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a10868438248226c1::ab78d0325509532d4(arg0, arg1)) {
            return
        };
        let v0 = 0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a099d08408fdb4a75();
        0x3573a2ab6edf9cc05c15608bf1ec63c524d595e733e9243fcd7edc0a04ed7586::a2ec4300f6df080d1::a5eefc623c389ac57(&v0, arg1, arg2, arg5, arg6, arg13, arg14);
    }

    // decompiled from Move bytecode v6
}

