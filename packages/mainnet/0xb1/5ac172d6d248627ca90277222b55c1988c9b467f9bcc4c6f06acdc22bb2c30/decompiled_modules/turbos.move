module 0xb15ac172d6d248627ca90277222b55c1988c9b467f9bcc4c6f06acdc22bb2c30::turbos {
    public fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg8: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg9: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg10: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<address>, arg13: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg14: bool, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T0>(arg7, arg8, arg9, arg10, &mut arg1, 0x2::tx_context::sender(arg16), arg16);
        if (0x1::option::is_some<address>(&arg12)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(0x2::coin::value<T0>(&arg1), 0x1::option::extract<u64>(&mut arg11)), arg16), 0x1::option::extract<address>(&mut arg12));
        };
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T0, T1>(arg13, arg14, true, 0x2::coin::value<T0>(&arg1), arg15);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), arg2, arg3, true, 0x2::tx_context::sender(arg16), arg4, arg5, arg6, arg16);
    }

    public fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg8: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg9: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg10: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<address>, arg13: &mut 0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::SwapPotato, arg14: bool, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg7, arg8, arg9, arg10, &mut arg1, 0x2::tx_context::sender(arg16), arg16);
        if (0x1::option::is_some<address>(&arg12)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(0x2::coin::value<T1>(&arg1), 0x1::option::extract<u64>(&mut arg11)), arg16), 0x1::option::extract<address>(&mut arg12));
        };
        0x53a678e309ced39b38fe8a7675d99b55a0f09bdb09e453ad2b7637e36841beda::router_events::try_add_trade_to_potato<T1, T0>(arg13, arg14, true, 0x2::coin::value<T1>(&arg1), arg15);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg0, v0, 0x2::coin::value<T1>(&arg1), arg2, arg3, true, 0x2::tx_context::sender(arg16), arg4, arg5, arg6, arg16);
    }

    // decompiled from Move bytecode v6
}

