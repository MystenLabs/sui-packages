module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees {
    public fun collect_fees_10_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg14, arg15);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg14, arg15);
    }

    public fun collect_fees_11_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: &mut 0x2::coin::Coin<T10>, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg15, arg16);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T10>(arg0, arg1, arg2, arg3, arg14, arg15, arg16);
    }

    public fun collect_fees_12_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: &mut 0x2::coin::Coin<T10>, arg15: &mut 0x2::coin::Coin<T11>, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T10>(arg0, arg1, arg2, arg3, arg14, arg16, arg17);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T11>(arg0, arg1, arg2, arg3, arg15, arg16, arg17);
    }

    public fun collect_fees_1_coins<T0>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun collect_fees_2_coins<T0, T1>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
    }

    public fun collect_fees_3_coins<T0, T1, T2>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun collect_fees_4_coins<T0, T1, T2, T3>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg8, arg9);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg8, arg9);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg8, arg9);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg8, arg9);
    }

    public fun collect_fees_5_coins<T0, T1, T2, T3, T4>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg9, arg10);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg9, arg10);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg9, arg10);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg9, arg10);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg9, arg10);
    }

    public fun collect_fees_6_coins<T0, T1, T2, T3, T4, T5>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg10, arg11);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg10, arg11);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg10, arg11);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg10, arg11);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg10, arg11);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg10, arg11);
    }

    public fun collect_fees_7_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg11, arg12);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg11, arg12);
    }

    public fun collect_fees_8_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg12, arg13);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg12, arg13);
    }

    public fun collect_fees_9_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg1: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg2: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg3: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg13, arg14);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg13, arg14);
    }

    // decompiled from Move bytecode v6
}

