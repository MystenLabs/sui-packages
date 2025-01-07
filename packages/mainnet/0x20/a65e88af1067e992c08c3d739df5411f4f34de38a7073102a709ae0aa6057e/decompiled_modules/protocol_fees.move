module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees {
    public fun collect_fees_10_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg14, arg15);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg14, arg15);
    }

    public fun collect_fees_11_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: &mut 0x2::coin::Coin<T10>, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg15, arg16);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T10>(arg0, arg1, arg2, arg3, arg14, arg15, arg16);
    }

    public fun collect_fees_12_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: &mut 0x2::coin::Coin<T9>, arg14: &mut 0x2::coin::Coin<T10>, arg15: &mut 0x2::coin::Coin<T11>, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T9>(arg0, arg1, arg2, arg3, arg13, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T10>(arg0, arg1, arg2, arg3, arg14, arg16, arg17);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T11>(arg0, arg1, arg2, arg3, arg15, arg16, arg17);
    }

    public fun collect_fees_2_coins<T0, T1>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
    }

    public fun collect_fees_3_coins<T0, T1, T2>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg7, arg8);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
    }

    public fun collect_fees_4_coins<T0, T1, T2, T3>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg8, arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg8, arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg8, arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg8, arg9);
    }

    public fun collect_fees_5_coins<T0, T1, T2, T3, T4>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg9, arg10);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg9, arg10);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg9, arg10);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg9, arg10);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg9, arg10);
    }

    public fun collect_fees_6_coins<T0, T1, T2, T3, T4, T5>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg10, arg11);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg10, arg11);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg10, arg11);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg10, arg11);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg10, arg11);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg10, arg11);
    }

    public fun collect_fees_7_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg11, arg12);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg11, arg12);
    }

    public fun collect_fees_8_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg12, arg13);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg12, arg13);
    }

    public fun collect_fees_9_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg1: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg2: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg3: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: &mut 0x2::coin::Coin<T4>, arg9: &mut 0x2::coin::Coin<T5>, arg10: &mut 0x2::coin::Coin<T6>, arg11: &mut 0x2::coin::Coin<T7>, arg12: &mut 0x2::coin::Coin<T8>, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg0, arg1, arg2, arg3, arg4, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg0, arg1, arg2, arg3, arg5, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T2>(arg0, arg1, arg2, arg3, arg6, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T3>(arg0, arg1, arg2, arg3, arg7, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T4>(arg0, arg1, arg2, arg3, arg8, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T5>(arg0, arg1, arg2, arg3, arg9, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T6>(arg0, arg1, arg2, arg3, arg10, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T7>(arg0, arg1, arg2, arg3, arg11, arg13, arg14);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T8>(arg0, arg1, arg2, arg3, arg12, arg13, arg14);
    }

    // decompiled from Move bytecode v6
}

