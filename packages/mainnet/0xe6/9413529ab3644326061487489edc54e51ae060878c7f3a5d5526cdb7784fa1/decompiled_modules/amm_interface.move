module 0xe69413529ab3644326061487489edc54e51ae060878c7f3a5d5526cdb7784fa1::amm_interface {
    public entry fun all_coin_deposit_2_coins<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, arg8), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
    }

    public entry fun all_coin_deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, arg9), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
    }

    public entry fun all_coin_deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, arg10), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
    }

    public entry fun all_coin_deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, arg11), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
    }

    public entry fun all_coin_deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, arg12), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
    }

    public entry fun all_coin_deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, arg13), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
        transfer_if_nonzero<T7>(arg12, v0);
    }

    public entry fun all_coin_deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: 0x2::coin::Coin<T8>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::all_coin_deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, &mut arg13, arg14), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
        transfer_if_nonzero<T7>(arg12, v0);
        transfer_if_nonzero<T8>(arg13, v0);
    }

    public entry fun deposit_1_coins<T0, T1>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_1_coins<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun deposit_2_coins<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: u128, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: u128, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), 0x2::tx_context::sender(arg11));
    }

    public entry fun deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public entry fun deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: u128, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public entry fun deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: u128, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    public entry fun deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: u128, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), 0x2::tx_context::sender(arg15));
    }

    public entry fun deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: 0x2::coin::Coin<T8>, arg14: u128, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::deposit::deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16), 0x2::tx_context::sender(arg16));
    }

    public entry fun create_lp_coin<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::transfer_create_pool_cap<T0>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_lp_coin<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_pool_2_coins<T0, T1, T2>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg14));
    }

    public entry fun create_pool_3_coins<T0, T1, T2, T3>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg15));
    }

    public entry fun create_pool_4_coins<T0, T1, T2, T3, T4>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: 0x2::coin::Coin<T4>, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg16));
    }

    public entry fun create_pool_5_coins<T0, T1, T2, T3, T4, T5>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: 0x2::coin::Coin<T4>, arg16: 0x2::coin::Coin<T5>, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg17));
    }

    public entry fun create_pool_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: 0x2::coin::Coin<T4>, arg16: 0x2::coin::Coin<T5>, arg17: 0x2::coin::Coin<T6>, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg18));
    }

    public entry fun create_pool_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: 0x2::coin::Coin<T4>, arg16: 0x2::coin::Coin<T5>, arg17: 0x2::coin::Coin<T6>, arg18: 0x2::coin::Coin<T7>, arg19: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg19));
    }

    public entry fun create_pool_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: 0x2::coin::Coin<T1>, arg13: 0x2::coin::Coin<T2>, arg14: 0x2::coin::Coin<T3>, arg15: 0x2::coin::Coin<T4>, arg16: 0x2::coin::Coin<T5>, arg17: 0x2::coin::Coin<T6>, arg18: 0x2::coin::Coin<T7>, arg19: 0x2::coin::Coin<T8>, arg20: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_factory::create_pool_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg20));
    }

    public entry fun oracle_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x2::tx_context::TxContext) {
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::price::oracle_price<T0, T1, T2>(arg0, arg1);
    }

    public entry fun spot_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x2::tx_context::TxContext) {
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::price::spot_price<T0, T1, T2>(arg0, arg1);
    }

    public entry fun multi_swap_exact_in_1_to_1<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_1<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun multi_swap_exact_in_1_to_2<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_2<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v2);
    }

    public entry fun multi_swap_exact_in_1_to_3<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_3<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v3);
    }

    public entry fun multi_swap_exact_in_1_to_4<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_4<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v4);
    }

    public entry fun multi_swap_exact_in_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v5 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v5);
    }

    public entry fun multi_swap_exact_in_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v6 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v5, v6);
    }

    public entry fun multi_swap_exact_in_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_in_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v7 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T8>>(v6, v7);
    }

    public entry fun multi_swap_exact_out_1_to_1<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_1<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9), v0);
    }

    public entry fun multi_swap_exact_out_1_to_2<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_2<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v2);
    }

    public entry fun multi_swap_exact_out_1_to_3<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_3<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v3 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v3);
    }

    public entry fun multi_swap_exact_out_1_to_4<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_4<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v4);
    }

    public entry fun multi_swap_exact_out_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v5 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v5);
    }

    public entry fun multi_swap_exact_out_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v6 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v5, v6);
    }

    public entry fun multi_swap_exact_out_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::multi_swap_exact_out_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, arg7, arg8, arg9);
        let v7 = 0x2::tx_context::sender(arg9);
        transfer_if_nonzero<T1>(arg6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v2, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T8>>(v6, v7);
    }

    public entry fun swap_exact_in<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_out<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        transfer_if_nonzero<T1>(arg7, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap::swap_exact_out<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &mut arg7, arg8, arg9, arg10), v0);
    }

    public entry fun all_coin_withdraw_2_coins<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v2);
    }

    public entry fun all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v3);
    }

    public entry fun all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v4);
    }

    public entry fun all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v5);
    }

    public entry fun all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v5, v6);
    }

    public entry fun all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v7 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v6, v7);
    }

    public entry fun all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw::all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v8 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v5, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v6, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T8>>(v7, v8);
    }

    public fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

