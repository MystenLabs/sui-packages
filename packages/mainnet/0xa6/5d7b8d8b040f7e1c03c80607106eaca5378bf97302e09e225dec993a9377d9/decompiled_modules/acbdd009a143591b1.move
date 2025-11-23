module 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::acbdd009a143591b1 {
    struct Ab2e8f06dee18694c has copy, drop {
        a4742fce427cde154: u64,
        ad7e8e73c2ee77f2f: u64,
        a3ee7989ef33f75e0: bool,
    }

    struct A5b6e601a9dd094f6 has copy, drop {
        a78b31959d95a8214: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        ae63e5e327dfede32: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        a2898d90a62a26786: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        aac13c19f5a69edcf: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        a182fca6383ba4f6e: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        ab14016f3aa05263c: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        aba99c43f1c22f905: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        aea31edf160e09be2: u64,
        ad4126fa2c4cb08d4: u64,
        acac07663075b2d68: u128,
    }

    public(friend) fun a40f8bc58a06c8b33(arg0: &0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        if (!0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a783956f993d811bc::a6b29e084f28cbe0e(arg0)) {
            return
        };
        let v0 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a099d08408fdb4a75();
        let v1 = &v0;
        let v2 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a558d3d4811fa675d(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0);
        let v3 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::ac4104d3c58483259(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v2);
        let v4 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a10868438248226c1::ad3e462cd25333e7f(v2, arg13) <= v3;
        let v5 = Ab2e8f06dee18694c{
            a4742fce427cde154 : v2,
            ad7e8e73c2ee77f2f : v3,
            a3ee7989ef33f75e0 : v4,
        };
        0x2::event::emit<Ab2e8f06dee18694c>(v5);
        if (!v4) {
            0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a5eefc623c389ac57(v1, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, arg14, arg15);
        } else {
            let v6 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a99ab6d0cf8644a81(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0);
            let v7 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::aa8fecb213cfb45e1(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0);
            let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v6, v7);
            let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1));
            let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1));
            let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v9, v7);
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v10, v7);
            let v13 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2);
            let v14 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
            let v15 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a783956f993d811bc::ae2894da560e9dfaf(arg0);
            let v16 = if (v13 < v15) {
                v13
            } else {
                v15
            };
            let v17 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a783956f993d811bc::a8f57f404176c397b(arg0);
            let v18 = if (v14 < v17) {
                v14
            } else {
                v17
            };
            let v19 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a7235c62aa5b27437(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v11, v12, v16, false);
            let v20 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a7235c62aa5b27437(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v11, v12, v18, true);
            let v21 = if (v19 < v20) {
                v19
            } else {
                v20
            };
            let v22 = A5b6e601a9dd094f6{
                a78b31959d95a8214 : v6,
                ae63e5e327dfede32 : v7,
                a2898d90a62a26786 : v8,
                aac13c19f5a69edcf : v9,
                a182fca6383ba4f6e : v10,
                ab14016f3aa05263c : v11,
                aba99c43f1c22f905 : v12,
                aea31edf160e09be2 : v16,
                ad4126fa2c4cb08d4 : v18,
                acac07663075b2d68 : v21,
            };
            0x2::event::emit<A5b6e601a9dd094f6>(v22);
            0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a6dc79187e3841ff0(v1, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v11, v12, v21, arg14, arg15);
        };
    }

    public(friend) fun a94cdf867cab7cc5c(arg0: &0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        if (arg13 <= 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1) && arg14 <= 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a10868438248226c1::ab78d0325509532d4(arg0, arg1)) {
            return
        };
        let v0 = 0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a099d08408fdb4a75();
        0xa65d7b8d8b040f7e1c03c80607106eaca5378bf97302e09e225dec993a9377d9::a2ec4300f6df080d1::a5eefc623c389ac57(&v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, arg15, arg16);
    }

    // decompiled from Move bytecode v6
}

