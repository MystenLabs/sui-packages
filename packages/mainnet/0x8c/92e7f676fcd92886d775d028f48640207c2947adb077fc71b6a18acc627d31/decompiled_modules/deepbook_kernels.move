module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::deepbook_kernels {
    public fun aftermath_deepbook_base_quote_v1<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg8: 0x2::balance::Balance<T1>, arg9: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::aftermath_b2a<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg10, arg15);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg10, 205);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T1, T2>(arg0, arg7, v0, arg9, arg11, arg12, arg13, arg14, arg15);
        (v2, v3, v4, v5, v1, v6)
    }

    public fun bluefin_deepbook_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bf_a<T0, T1>(arg0, arg1, arg2, arg4, arg11);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg6, 201);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg3, v0, arg5, arg7, arg8, arg9, arg10, arg11);
        (v2, v3, v4, v5, v1, v6)
    }

    public fun cetus_deepbook_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_a_b<T0, T1>(arg0, arg1, arg2, arg4, arg11);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg6, 200);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg3, v0, arg5, arg7, arg8, arg9, arg10, arg11);
        (v2, v3, v4, v5, v1, v6)
    }

    public fun deepbook_aftermath_base_quote_v1<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: 0x2::balance::Balance<T1>, arg9: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T1, T2>(arg0, arg1, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::aftermath_a2b<T0, T2, T1>(arg2, arg3, arg4, arg5, arg6, arg7, v0, arg13, arg16);
        assert!(0x2::balance::value<T1>(&v5) >= arg13, 205);
        0x2::balance::join<T1>(&mut v5, v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 >= arg14, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun deepbook_bluefin_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bf_b<T0, T1>(arg0, arg2, arg3, v0, arg12);
        assert!(0x2::balance::value<T0>(&v5) >= arg9, 201);
        0x2::balance::join<T0>(&mut v5, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg10, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun deepbook_cetus_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_b_a<T0, T1>(arg0, arg2, arg3, v0, arg12);
        assert!(0x2::balance::value<T0>(&v5) >= arg9, 200);
        0x2::balance::join<T0>(&mut v5, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg10, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun deepbook_magma_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::mb<T0, T1>(arg0, arg2, arg3, v0, arg12);
        assert!(0x2::balance::value<T0>(&v5) >= arg9, 206);
        0x2::balance::join<T0>(&mut v5, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg10, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun deepbook_momentum_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::mmt_b<T0, T1>(arg0, arg2, arg3, v0, arg12);
        assert!(0x2::balance::value<T0>(&v5) >= arg9, 204);
        0x2::balance::join<T0>(&mut v5, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg10, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun deepbook_turbos_base_quote_v1<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_b<T0, T1, T2>(arg2, v0, arg0, arg3, arg12);
        assert!(0x2::balance::value<T0>(&v5) >= arg9, 203);
        0x2::balance::join<T0>(&mut v5, v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg10, 202);
        (v5, v2, v3, v4, v6)
    }

    public fun magma_deepbook_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::ma<T0, T1>(arg0, arg1, arg2, arg4, arg11);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg6, 206);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg3, v0, arg5, arg7, arg8, arg9, arg10, arg11);
        (v2, v3, v4, v5, v1, v6)
    }

    public fun momentum_deepbook_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::mmt_a<T0, T1>(arg0, arg1, arg2, arg4, arg11);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg6, 204);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg3, v0, arg5, arg7, arg8, arg9, arg10, arg11);
        (v2, v3, v4, v5, v1, v6)
    }

    public fun turbos_deepbook_base_quote_v1<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_a<T0, T1, T2>(arg1, arg4, arg0, arg2, arg11);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg6, 203);
        let (v2, v3, v4, v5, v6) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg3, v0, arg5, arg7, arg8, arg9, arg10, arg11);
        (v2, v3, v4, v5, v1, v6)
    }

    // decompiled from Move bytecode v7
}

