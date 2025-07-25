module 0x464a1cf963d2bc3433c5ff955d9703e726c6bd1e5b160e137b3ec6b6bbfbd6a3::router {
    struct AftermathAmmRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut AftermathAmmRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut AftermathAmmRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AftermathAmmRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AftermathAmmRouterWrapper>(v0);
    }

    public fun swap_exact_in<T0, T1, T2, T3>(arg0: &mut AftermathAmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T1>, arg3: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg8);
        let v0 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::swap::swap_exact_in<T1, T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 1000000000000000000, arg10);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T3>(arg1, &arg0.id, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun swap_exact_out<T0, T1, T2, T3>(arg0: &mut AftermathAmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T1>, arg3: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: u64, arg9: &mut 0x2::coin::Coin<T2>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, arg9);
        let v0 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::swap::swap_exact_out<T1, T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 1000000000000000000, arg11);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T3>(arg1, &arg0.id, 0x2::coin::value<T3>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

