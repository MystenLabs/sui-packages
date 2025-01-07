module 0x63b8976c47c2b61b4f9aef39a59d44bf2952f93d441bf339a0841b3ff06572bf::deepbook {
    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg4: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg5: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg6: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg7: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg3, arg4, arg5, arg6, &mut arg1, 0x2::tx_context::sender(arg10), arg10);
        let (v0, v1, _) = 0xdee9::clob::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::value<T1>(&arg1), arg2, arg1, arg10);
        let v3 = v0;
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T1, T0>(arg7, arg8, arg9, 0x2::coin::value<T1>(&arg1), 0x2::coin::value<T0>(&v3));
        0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::deposit<T1>(arg4, v1);
        v3
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg4: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg5: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg6: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg7: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, _, _) = swap_exact_base_for_quote_inner<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10);
        let v4 = v1;
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T0, T1>(arg7, arg8, arg9, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&v4));
        0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::deposit<T0>(arg4, v0);
        v4
    }

    fun swap_exact_base_for_quote_inner<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg4: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg5: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg6: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg3, arg4, arg5, arg6, &mut arg1, 0x2::tx_context::sender(arg7), arg7);
        let (v0, v1) = 0xdee9::clob::place_market_order<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1), false, arg1, 0x2::coin::zero<T1>(arg7), arg2, arg7);
        let v2 = v1;
        let v3 = v0;
        (v3, v2, 0x2::coin::value<T0>(&arg1) - 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2))
    }

    // decompiled from Move bytecode v6
}

