module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::guarded_adapters {
    public fun aftermath_dao_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg2: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        validate<T1>(&arg8, arg10, arg0, arg11);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::aftermath_dao_a2b<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        guard_output<T2>(&v0, arg9);
        v0
    }

    public fun aftermath_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        validate<T1>(&arg7, arg9, arg0, arg10);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::aftermath_a2b<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
        guard_output<T2>(&v0, arg8);
        v0
    }

    public fun bluefin_a2b_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T1> {
        validate_price(arg6, true);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, validate<T0>(&arg3, arg5, arg0, arg7), arg6);
        let v3 = v1;
        0x2::balance::join<T0>(&mut arg3, v0);
        guard_output<T1>(&v3, arg4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v2);
        v3
    }

    public fun bluefin_b2a_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T0> {
        validate_price(arg6, true);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, validate<T1>(&arg3, arg5, arg0, arg7), arg6);
        let v3 = v0;
        0x2::balance::join<T1>(&mut arg3, v1);
        guard_output<T0>(&v3, arg4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v2);
        v3
    }

    public fun bluemove_a2b_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate<T0>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bmr_a<T0, T1>(arg1, arg2, arg6);
        guard_output<T1>(&v0, arg3);
        v0
    }

    public fun bluemove_b2a_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate<T1>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bmr_b<T0, T1>(arg1, arg2, arg6);
        guard_output<T0>(&v0, arg3);
        v0
    }

    public fun cetus_a2b_v6<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T1> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, validate<T0>(&arg3, arg5, arg0, arg7), arg6, arg0);
        let v3 = v1;
        0x2::balance::join<T0>(&mut arg3, v0);
        guard_output<T1>(&v3, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v2);
        v3
    }

    public fun cetus_b2a_v6<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T0> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, validate<T1>(&arg3, arg5, arg0, arg7), arg6, arg0);
        let v3 = v0;
        0x2::balance::join<T1>(&mut arg3, v1);
        guard_output<T0>(&v3, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v2);
        v3
    }

    public fun cetus_dlmm_a2b_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate<T0>(&arg4, arg6, arg0, arg7);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::cd_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8);
        guard_output<T1>(&v0, arg5);
        v0
    }

    public fun cetus_dlmm_b2a_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate<T1>(&arg4, arg6, arg0, arg7);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::cd_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8);
        guard_output<T0>(&v0, arg5);
        v0
    }

    public fun dlmm_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        validate<T0>(&arg3, arg5, arg0, arg6);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, true, arg4, 0x2::coin::from_balance<T0>(arg3, arg7), 0x2::coin::zero<T1>(arg7), arg0, arg7);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        guard_output<T1>(&v2, arg4);
        (v2, 0x2::coin::into_balance<T0>(v0))
    }

    public fun dlmm_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        validate<T1>(&arg3, arg5, arg0, arg6);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, false, arg4, 0x2::coin::zero<T0>(arg7), 0x2::coin::from_balance<T1>(arg3, arg7), arg0, arg7);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        guard_output<T0>(&v2, arg4);
        (v2, 0x2::coin::into_balance<T1>(v1))
    }

    public fun flowx_amm_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate<T0>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::fx_a<T0, T1>(arg1, arg2, arg6);
        guard_output<T1>(&v0, arg3);
        v0
    }

    public fun flowx_amm_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate<T1>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::fx_b<T0, T1>(arg1, arg2, arg6);
        guard_output<T0>(&v0, arg3);
        v0
    }

    public fun flowx_clmm_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate<T0>(&arg4, arg6, arg0, arg8);
        validate_price(arg7, false);
        let v0 = 0x2::coin::into_balance<T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flowx_clmm_a2b<T0, T1>(arg1, arg2, arg3, arg0, 0x2::coin::from_balance<T0>(arg4, arg9), arg7, arg9));
        guard_output<T1>(&v0, arg5);
        v0
    }

    public fun flowx_clmm_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate<T1>(&arg4, arg6, arg0, arg8);
        validate_price(arg7, false);
        let v0 = 0x2::coin::into_balance<T0>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flowx_clmm_b2a<T0, T1>(arg1, arg2, arg3, arg0, 0x2::coin::from_balance<T1>(arg4, arg9), arg7, arg9));
        guard_output<T0>(&v0, arg5);
        v0
    }

    fun guard_output<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(arg1 > 0 && 0x2::balance::value<T0>(arg0) >= arg1, 602);
    }

    public fun kriya_amm_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate<T0>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_a<T0, T1>(arg1, arg2, arg6);
        guard_output<T1>(&v0, arg3);
        v0
    }

    public fun kriya_amm_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate<T1>(&arg2, arg4, arg0, arg5);
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_b<T0, T1>(arg1, arg2, arg6);
        guard_output<T0>(&v0, arg3);
        v0
    }

    public fun kriya_clmm_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg2, true, true, validate<T0>(&arg3, arg5, arg0, arg7), arg6, arg0, arg1, arg8);
        let v3 = v1;
        0x2::balance::join<T0>(&mut arg3, v0);
        guard_output<T1>(&v3, arg4);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, v2, arg3, 0x2::balance::zero<T1>(), arg1, arg8);
        v3
    }

    public fun kriya_clmm_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg2, false, true, validate<T1>(&arg3, arg5, arg0, arg7), arg6, arg0, arg1, arg8);
        let v3 = v0;
        0x2::balance::join<T1>(&mut arg3, v1);
        guard_output<T0>(&v3, arg4);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, v2, 0x2::balance::zero<T0>(), arg3, arg1, arg8);
        v3
    }

    public fun magma_a2b_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T1> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, validate<T0>(&arg3, arg5, arg0, arg7), arg6, arg0);
        let v3 = v1;
        0x2::balance::join<T0>(&mut arg3, v0);
        guard_output<T1>(&v3, arg4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v2);
        v3
    }

    public fun magma_b2a_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : 0x2::balance::Balance<T0> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, validate<T1>(&arg3, arg5, arg0, arg7), arg6, arg0);
        let v3 = v0;
        0x2::balance::join<T1>(&mut arg3, v1);
        guard_output<T0>(&v3, arg4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v2);
        v3
    }

    public fun momentum_x2y_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, validate<T0>(&arg3, arg5, arg0, arg7), arg6, arg0, arg1, arg8);
        let v3 = v1;
        0x2::balance::join<T0>(&mut arg3, v0);
        guard_output<T1>(&v3, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v2, arg3, 0x2::balance::zero<T1>(), arg1, arg8);
        v3
    }

    public fun momentum_y2x_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate_price(arg6, false);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, validate<T1>(&arg3, arg5, arg0, arg7), arg6, arg0, arg1, arg8);
        let v3 = v0;
        0x2::balance::join<T1>(&mut arg3, v1);
        guard_output<T0>(&v3, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v2, 0x2::balance::zero<T0>(), arg3, arg1, arg8);
        v3
    }

    public fun turbos_a2b_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        validate_price(arg6, false);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg3, arg8));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v0, validate<T0>(&arg3, arg5, arg0, arg7), arg4, arg6, true, 0x2::tx_context::sender(arg8), arg7, arg0, arg1, arg8);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        guard_output<T1>(&v3, arg4);
        (v3, 0x2::coin::into_balance<T0>(v2))
    }

    public fun turbos_b2a_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        validate_price(arg6, false);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg3, arg8));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v0, validate<T1>(&arg3, arg5, arg0, arg7), arg4, arg6, true, 0x2::tx_context::sender(arg8), arg7, arg0, arg1, arg8);
        let v3 = 0x2::coin::into_balance<T0>(v1);
        guard_output<T0>(&v3, arg4);
        (v3, 0x2::coin::into_balance<T1>(v2))
    }

    fun validate<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 > 0, 600);
        assert!(arg1 == 0 || v0 <= arg1, 601);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 <= arg3, 603);
        assert!(arg3 - v1 <= 30000, 604);
        v0
    }

    fun validate_price(arg0: u128, arg1: bool) {
        if (arg1) {
            assert!(arg0 > 4295048017, 605);
            assert!(arg0 < 79226673515401279992447579055, 605);
        } else {
            assert!(arg0 >= 4295048017, 605);
            assert!(arg0 <= 79226673515401279992447579055, 605);
        };
    }

    // decompiled from Move bytecode v7
}

