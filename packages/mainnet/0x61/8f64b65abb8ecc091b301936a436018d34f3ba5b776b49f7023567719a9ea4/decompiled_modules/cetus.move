module 0x618f64b65abb8ecc091b301936a436018d34f3ba5b776b49f7023567719a9ea4::cetus {
    fun cetus_swap_why_is_this_not_in_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    public fun swap_a_to_b_by_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg6: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg7: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg8: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg9: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg10: bool, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::zero<T1>(arg12);
        let (v2, v3) = cetus_swap_why_is_this_not_in_cetus<T0, T1>(arg0, arg1, arg2, v1, true, true, v0, arg3, arg4, arg12);
        let v4 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg5, arg6, arg7, arg8, &mut v4, 0x2::tx_context::sender(arg12), arg12);
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T0, T1>(arg9, arg10, arg11, v0, 0x2::coin::value<T1>(&v4));
        v4
    }

    public fun swap_a_to_b_by_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg7: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg8: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg9: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg10: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg11: bool, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg13);
        let (v1, v2) = cetus_swap_why_is_this_not_in_cetus<T0, T1>(arg0, arg1, arg2, v0, true, false, arg3, arg4, arg5, arg13);
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg13));
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg6, arg7, arg8, arg9, &mut v3, 0x2::tx_context::sender(arg13), arg13);
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T0, T1>(arg10, arg11, arg12, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&v3));
        v3
    }

    public fun swap_b_to_a_by_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg7: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg8: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg9: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg10: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg11: bool, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg13);
        let (v1, v2) = cetus_swap_why_is_this_not_in_cetus<T0, T1>(arg0, arg1, v0, arg2, false, false, arg3, arg4, arg5, arg13);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg13));
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg6, arg7, arg8, arg9, &mut v3, 0x2::tx_context::sender(arg13), arg13);
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T1, T0>(arg10, arg11, arg12, 0x2::coin::value<T1>(&arg2), 0x2::coin::value<T0>(&v3));
        v3
    }

    public fun swap_b_to_a_by_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg6: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg7: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg8: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg9: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg10: bool, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::coin::zero<T0>(arg12);
        let (v2, v3) = cetus_swap_why_is_this_not_in_cetus<T0, T1>(arg0, arg1, v1, arg2, false, true, v0, arg3, arg4, arg12);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg12));
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg5, arg6, arg7, arg8, &mut v4, 0x2::tx_context::sender(arg12), arg12);
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T1, T0>(arg9, arg10, arg11, v0, 0x2::coin::value<T0>(&v4));
        v4
    }

    // decompiled from Move bytecode v6
}

