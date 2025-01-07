module 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::scallop {
    public fun deposit<T0>(arg0: &mut 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_share_tag())));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_share_tag())));
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg3, arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), arg5, arg6), arg5, arg6);
        0x1::vector::empty<u64>()
    }

    public fun new_spool_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg1, arg2)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::balance_pool::BalancePool, arg1: &mut 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositVault, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::coin::into_balance<T1>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg4, arg5, arg6, arg7, arg8));
        let v1 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg4, arg6, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg6), arg7, arg8), arg7, arg8));
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_share_supply(arg1);
        let v4 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_share_supply(arg1);
        assert!(v2 >= v3 + v4, 0);
        0x2::balance::join<T0>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v1, v3));
        0x2::balance::join<T0>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v1, v4));
        let (_, _) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::charge_fee<T0>(arg0, arg1, &mut v1);
        if (v2 != v3 + v4 || 0x2::balance::value<T1>(&v0) != 0) {
            let v7 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_share_supply(arg1) + 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_share_supply(arg1);
            let v8 = 0x2::balance::value<T0>(&v1);
            let v9 = 0x2::balance::value<T1>(&v0);
            let v10 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_shares(arg1);
            let v11 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::length<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v10);
            let v12 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::slice_size<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v10);
            let v13 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::borrow_slice_mut<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v10, 1);
            let v14 = 0;
            while (v14 < v11) {
                let v15 = 0x1::vector::borrow_mut<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v13, v14 % v12);
                let v16 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_deposit_share_inner(v15, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_share_tag()) + 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_deposit_share_inner(v15, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_share_tag());
                if (v16 > 0) {
                    if (v8 > 0) {
                        let v17 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_share_inner(v15, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::warmup_share_tag());
                        let v18 = (((v8 as u128) * (v16 as u128) / (v7 as u128)) as u64);
                        v8 = v8 - v18;
                        *v17 = *v17 + v18;
                    };
                    if (v9 > 0) {
                        let v19 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_share_inner(v15, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::premium_share_tag());
                        let v20 = (((v9 as u128) * (v16 as u128) / (v7 as u128)) as u64);
                        v9 = v9 - v20;
                        *v19 = *v19 + v20;
                    };
                    v7 = v7 - v16;
                };
                if (v14 + 1 < v11 && (v14 + 1) % v12 == 0) {
                    v13 = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::borrow_slice_mut<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v10, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::big_vector::slice_id<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::DepositShare>(v10, v14 + 1));
                };
                v14 = v14 + 1;
            };
        };
        0x2::balance::join<T0>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::warmup_share_tag()), v1);
        0x2::balance::join<T1>(0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deposit_vault_balance<T1>(arg1, 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::premium_share_tag()), v0);
        *0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_active_share_supply(arg1) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::active_balance<T0>(arg1);
        *0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_deactivating_share_supply(arg1) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::deactivating_balance<T0>(arg1);
        *0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_warmup_share_supply(arg1) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::warmup_balance<T0>(arg1);
        *0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::get_mut_premium_share_supply(arg1) = 0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::premium_balance<T0>(arg1);
        0x1::vector::empty<u64>()
    }

    // decompiled from Move bytecode v6
}

