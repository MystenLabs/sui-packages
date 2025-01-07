module 0x5013c865ff961a2ce7006e6a520b7336956419a43cf1b8d2d84837417e124dee::amm_interface {
    public entry fun all_coin_deposit_2_coins<T0, T1, T2>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, arg8), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
    }

    public entry fun all_coin_deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, arg9), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
    }

    public entry fun all_coin_deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, arg10), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
    }

    public entry fun all_coin_deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, arg11), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
    }

    public entry fun all_coin_deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, arg12), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
    }

    public entry fun all_coin_deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, arg13), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
        transfer_if_nonzero<T7>(arg12, v0);
    }

    public entry fun all_coin_deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: 0x2::coin::Coin<T8>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::all_coin_deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, &mut arg13, arg14), v0);
        transfer_if_nonzero<T1>(arg6, v0);
        transfer_if_nonzero<T2>(arg7, v0);
        transfer_if_nonzero<T3>(arg8, v0);
        transfer_if_nonzero<T4>(arg9, v0);
        transfer_if_nonzero<T5>(arg10, v0);
        transfer_if_nonzero<T6>(arg11, v0);
        transfer_if_nonzero<T7>(arg12, v0);
        transfer_if_nonzero<T8>(arg13, v0);
    }

    public entry fun all_coin_withdraw_2_coins<T0, T1, T2>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v2);
    }

    public entry fun all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v3);
    }

    public entry fun all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v4);
    }

    public entry fun all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v5);
    }

    public entry fun all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v5, v6);
    }

    public entry fun all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v7 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v2, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v3, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T7>>(v6, v7);
    }

    public entry fun all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::withdraw::all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
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

    public entry fun create_lp_coin<T0: drop>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::transfer_create_pool_cap<T0>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_lp_coin<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool_2_coins<T0, T1, T2>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x1::option::Option<vector<u8>>, arg16: bool, arg17: 0x1::option::Option<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg18));
    }

    public entry fun create_pool_3_coins<T0, T1, T2, T3>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x1::option::Option<vector<u8>>, arg17: bool, arg18: 0x1::option::Option<u8>, arg19: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg19));
    }

    public entry fun create_pool_4_coins<T0, T1, T2, T3, T4>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x1::option::Option<vector<u8>>, arg18: bool, arg19: 0x1::option::Option<u8>, arg20: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg20));
    }

    public entry fun create_pool_5_coins<T0, T1, T2, T3, T4, T5>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x1::option::Option<vector<u8>>, arg19: bool, arg20: 0x1::option::Option<u8>, arg21: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg21));
    }

    public entry fun create_pool_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x1::option::Option<vector<u8>>, arg20: bool, arg21: 0x1::option::Option<u8>, arg22: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg22));
    }

    public entry fun create_pool_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x2::coin::Coin<T7>, arg20: 0x1::option::Option<vector<u8>>, arg21: bool, arg22: 0x1::option::Option<u8>, arg23: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg23));
    }

    public entry fun create_pool_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x2::coin::Coin<T7>, arg20: 0x2::coin::Coin<T8>, arg21: 0x1::option::Option<vector<u8>>, arg22: bool, arg23: 0x1::option::Option<u8>, arg24: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory::create_pool_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::share<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg24));
    }

    public entry fun deposit_1_coins<T0, T1>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_1_coins<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun deposit_2_coins<T0, T1, T2>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: u128, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: u128, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_3_coins<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), 0x2::tx_context::sender(arg11));
    }

    public entry fun deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_4_coins<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public entry fun deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: u128, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public entry fun deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: u128, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    public entry fun deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: u128, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), 0x2::tx_context::sender(arg15));
    }

    public entry fun deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: 0x2::coin::Coin<T8>, arg14: u128, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::deposit::deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16), 0x2::tx_context::sender(arg16));
    }

    public entry fun oracle_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x2::tx_context::TxContext) {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::price::oracle_price<T0, T1, T2>(arg0, arg1);
    }

    public entry fun spot_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x2::tx_context::TxContext) {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::price::spot_price<T0, T1, T2>(arg0, arg1);
    }

    public entry fun swap_exact_in<T0, T1, T2>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::swap::swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_out<T0, T1, T2>(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        transfer_if_nonzero<T1>(arg7, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::swap::swap_exact_out<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &mut arg7, arg8, arg9, arg10), v0);
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

