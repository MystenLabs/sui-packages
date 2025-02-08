module 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::router {
    public entry fun burn_lp<T0, T1, T2>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T2>, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::burn_lp<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_clmm_fee<T0, T1, T2>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::claim_clmm_fee<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_clmm_reward<T0, T1, T2, T3>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::claim_clmm_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun claim_fee<T0>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::claim_fee<T0>(arg0, arg1, arg2);
    }

    public entry fun claim_swap_fee<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg3: &0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::claim_swap_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun start_bonding_curve<T0, T1>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurves, arg2: 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<T0>, arg3: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::clock::Clock, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::start_bonding_curve<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun swap_exact_input_meme<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::swap_exact_input_meme<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_coin<0x2::sui::SUI>(v0, arg6);
        transfer_coin<T0>(v1, arg6);
    }

    public entry fun swap_exact_input_sui<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::swap_exact_input_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_coin<0x2::sui::SUI>(v0, arg6);
        transfer_coin<T0>(v1, arg6);
    }

    public entry fun swap_exact_output_meme<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::swap_exact_output_meme<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_coin<0x2::sui::SUI>(v0, arg6);
        transfer_coin<T0>(v1, arg6);
    }

    public entry fun swap_exact_output_sui<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::swap_exact_output_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_coin<0x2::sui::SUI>(v0, arg6);
        transfer_coin<T0>(v1, arg6);
    }

    public entry fun update_url_by_creator<T0, T1>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurve<T0>, arg2: 0x1::ascii::String, arg3: &mut 0x2::coin::Coin<T1>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::update_url_by_creator<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claim_earning<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_coin<T0>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::claim_earning<T0>(arg0, arg1, arg2), arg2);
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

