module 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::scallop {
    public fun new_spool_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg1, arg2)
    }

    public fun deposit<T0>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::withdraw_all<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()));
        let v2 = 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut v0, v1);
        let v3 = 0x2::balance::withdraw_all<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()));
        let v4 = 0x2::balance::value<T0>(&v3);
        0x2::balance::join<T0>(&mut v0, v3);
        if (v2 + v4 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return 0x1::vector::empty<u64>()
        };
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), arg5, arg6);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg3, arg4, v5, arg5, arg6);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, v2);
        0x1::vector::push_back<u64>(v7, v4);
        0x1::vector::push_back<u64>(v7, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5));
        v6
    }

    public fun deposit_basic_lending<T0>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, vector<u64>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::withdraw_all<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()));
        let v2 = 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut v0, v1);
        let v3 = 0x2::balance::withdraw_all<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg0, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()));
        let v4 = 0x2::balance::value<T0>(&v3);
        0x2::balance::join<T0>(&mut v0, v3);
        if (v2 + v4 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return (0x2::coin::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg4), vector[0, 0, 0])
        };
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg4), arg3, arg4);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, v2);
        0x1::vector::push_back<u64>(v7, v4);
        0x1::vector::push_back<u64>(v7, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5));
        (v5, v6)
    }

    public fun withdraw_basic_lending<T0>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::balance_pool::BalancePool, arg1: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        if (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg5) == 0) {
            0x2::coin::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5);
            let v0 = 0x1::vector::empty<u64>();
            let v1 = &mut v0;
            0x1::vector::push_back<u64>(v1, 0);
            0x1::vector::push_back<u64>(v1, 0);
            0x1::vector::push_back<u64>(v1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1));
            0x1::vector::push_back<u64>(v1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1));
            return v0
        };
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, arg5, arg6, arg7));
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1);
        let v5 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
        if (v3 < v4 + v5) {
            assert!(v4 + v5 - v3 == 1, 0);
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(arg2, 1));
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v2, v4));
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v2, v5));
        if (v3 > v4 + v5) {
            let v6 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
            let v7 = 0x2::balance::value<T0>(&v2);
            let v8 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_shares(arg1);
            let v9 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::length<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v8);
            let v10 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_size<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v8);
            let v11 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v8, 1);
            let v12 = 0;
            while (v12 < v9) {
                let v13 = 0x1::vector::borrow_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11, v12 % v10);
                let v14 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v13, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v13, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag());
                if (v14 > 0) {
                    if (v7 > 0) {
                        let v15 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v13, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag());
                        let v16 = (((v7 as u128) * (v14 as u128) / (v6 as u128)) as u64);
                        v7 = v7 - v16;
                        *v15 = *v15 + v16;
                    };
                    v6 = v6 - v14;
                };
                if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                    v11 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v8, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_id<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v8, v12 + 1));
                };
                v12 = v12 + 1;
            };
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag()), v2);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_active_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_balance<T0>(arg1);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deactivating_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_balance<T0>(arg1);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_premium_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_balance<T0>(arg1);
        let v17 = 0x1::vector::empty<u64>();
        let v18 = &mut v17;
        0x1::vector::push_back<u64>(v18, v3);
        0x1::vector::push_back<u64>(v18, 0x2::balance::value<T0>(&v2));
        0x1::vector::push_back<u64>(v18, v4);
        0x1::vector::push_back<u64>(v18, v5);
        v17
    }

    public fun withdraw_xxx<T0>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::balance_pool::BalancePool, arg1: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg7);
        if (v0 == 0) {
            return 0x1::vector::empty<u64>()
        };
        let v1 = 0x2::coin::into_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg5, arg6, arg7, arg8, arg9));
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, arg7, v0, arg8, arg9), arg8, arg9));
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x2::balance::value<T0>(&v1);
        let v5 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1);
        let v6 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
        if (v3 < v5 + v6) {
            assert!(v5 + v6 - v3 == 1, 0);
            if (v4 >= 1) {
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut v1, 1));
            } else {
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(arg2, 1));
            };
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v2, v5));
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v2, v6));
        0x2::balance::join<T0>(&mut v1, v2);
        if (v3 > v5 + v6 || 0x2::balance::value<T0>(&v1) != 0) {
            let v7 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
            let v8 = 0x2::balance::value<T0>(&v1);
            let v9 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_shares(arg1);
            let v10 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::length<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v9);
            let v11 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_size<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v9);
            let v12 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v9, 1);
            let v13 = 0;
            while (v13 < v10) {
                let v14 = 0x1::vector::borrow_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v12, v13 % v11);
                let v15 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v14, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v14, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag());
                if (v15 > 0) {
                    if (v8 > 0) {
                        let v16 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v14, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag());
                        let v17 = (((v8 as u128) * (v15 as u128) / (v7 as u128)) as u64);
                        v8 = v8 - v17;
                        *v16 = *v16 + v17;
                    };
                    v7 = v7 - v15;
                };
                if (v13 + 1 < v10 && (v13 + 1) % v11 == 0) {
                    v12 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v9, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_id<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v9, v13 + 1));
                };
                v13 = v13 + 1;
            };
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag()), v1);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_premium_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_balance<T0>(arg1);
        let v18 = 0x1::vector::empty<u64>();
        let v19 = &mut v18;
        0x1::vector::push_back<u64>(v19, v3);
        0x1::vector::push_back<u64>(v19, v4);
        0x1::vector::push_back<u64>(v19, v5);
        0x1::vector::push_back<u64>(v19, v6);
        v18
    }

    public fun withdraw_xyx<T0>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::balance_pool::BalancePool, arg1: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg7);
        if (v0 == 0) {
            return 0x1::vector::empty<u64>()
        };
        let v1 = 0x2::coin::into_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg5, arg6, arg7, arg8, arg9));
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, arg7, v0, arg8, arg9), arg8, arg9));
        0x2::balance::join<T0>(&mut v2, v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1);
        let v5 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
        if (v3 < v4 + v5) {
            assert!(v4 + v5 - v3 == 1, 0);
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(arg2, 1));
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v2, v4));
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v2, v5));
        let (v6, v7) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::charge_fee<T0>(arg0, arg1, &mut v2);
        if (v3 > v4 + v5) {
            let v8 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
            let v9 = 0x2::balance::value<T0>(&v2);
            let v10 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_shares(arg1);
            let v11 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::length<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v10);
            let v12 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_size<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v10);
            let v13 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v10, 1);
            let v14 = 0;
            while (v14 < v11) {
                let v15 = 0x1::vector::borrow_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13, v14 % v12);
                let v16 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v15, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v15, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag());
                if (v16 > 0) {
                    if (v9 > 0) {
                        let v17 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v15, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_share_tag());
                        let v18 = (((v9 as u128) * (v16 as u128) / (v8 as u128)) as u64);
                        v9 = v9 - v18;
                        *v17 = *v17 + v18;
                    };
                    v8 = v8 - v16;
                };
                if (v14 + 1 < v11 && (v14 + 1) % v12 == 0) {
                    v13 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v10, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_id<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v10, v14 + 1));
                };
                v14 = v14 + 1;
            };
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_share_tag()), v2);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_warmup_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_balance<T0>(arg1);
        let v19 = 0x1::vector::empty<u64>();
        let v20 = &mut v19;
        0x1::vector::push_back<u64>(v20, v3);
        0x1::vector::push_back<u64>(v20, 0x2::balance::value<T0>(&v1));
        0x1::vector::push_back<u64>(v20, v4);
        0x1::vector::push_back<u64>(v20, v5);
        0x1::vector::push_back<u64>(v20, v6);
        0x1::vector::push_back<u64>(v20, v7);
        v19
    }

    public fun withdraw_xyy<T0, T1>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::balance_pool::BalancePool, arg1: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg7);
        if (v0 == 0) {
            return 0x1::vector::empty<u64>()
        };
        let v1 = 0x2::coin::into_balance<T1>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg5, arg6, arg7, arg8, arg9));
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, arg7, v0, arg8, arg9), arg8, arg9));
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1);
        let v5 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
        if (v3 < v4 + v5) {
            assert!(v4 + v5 - v3 == 1, 0);
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(arg2, 1));
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v2, v4));
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v2, v5));
        let (v6, v7) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::charge_fee<T0>(arg0, arg1, &mut v2);
        if (v3 > v4 + v5 || 0x2::balance::value<T1>(&v1) != 0) {
            let v8 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
            let v9 = 0x2::balance::value<T0>(&v2);
            let v10 = 0x2::balance::value<T1>(&v1);
            let v11 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_shares(arg1);
            let v12 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::length<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11);
            let v13 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_size<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11);
            let v14 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11, 1);
            let v15 = 0;
            while (v15 < v12) {
                let v16 = 0x1::vector::borrow_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v14, v15 % v13);
                let v17 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v16, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v16, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag());
                if (v17 > 0) {
                    if (v9 > 0) {
                        let v18 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v16, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_share_tag());
                        let v19 = (((v9 as u128) * (v17 as u128) / (v8 as u128)) as u64);
                        v9 = v9 - v19;
                        *v18 = *v18 + v19;
                    };
                    if (v10 > 0) {
                        let v20 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v16, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag());
                        let v21 = (((v10 as u128) * (v17 as u128) / (v8 as u128)) as u64);
                        v10 = v10 - v21;
                        *v20 = *v20 + v21;
                    };
                    v8 = v8 - v17;
                };
                if (v15 + 1 < v12 && (v15 + 1) % v13 == 0) {
                    v14 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_id<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v11, v15 + 1));
                };
                v15 = v15 + 1;
            };
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_share_tag()), v2);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_warmup_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::warmup_balance<T0>(arg1);
        0x2::balance::join<T1>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T1>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag()), v1);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_premium_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_balance<T1>(arg1);
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, v3);
        0x1::vector::push_back<u64>(v23, 0x2::balance::value<T1>(&v1));
        0x1::vector::push_back<u64>(v23, v4);
        0x1::vector::push_back<u64>(v23, v5);
        0x1::vector::push_back<u64>(v23, v6);
        0x1::vector::push_back<u64>(v23, v7);
        v22
    }

    public fun withdraw_xyz<T0, T1>(arg0: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::balance_pool::BalancePool, arg1: &mut 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositVault, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg7: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<u64> {
        0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::update_deposit_vault_incentive_token<T1>(arg1);
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg7);
        if (v0 == 0) {
            return 0x1::vector::empty<u64>()
        };
        let v1 = 0x2::coin::into_balance<T1>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg5, arg6, arg7, arg8, arg9));
        let v2 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, arg7, v0, arg8, arg9), arg8, arg9));
        let (v3, v4) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_vault_token_types(arg1);
        let v5 = 0x2::balance::value<T0>(&v2);
        let v6 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1);
        let v7 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
        if (v5 < v6 + v7) {
            assert!(v6 + v7 - v5 == 1, 0);
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(arg2, 1));
        };
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()), 0x2::balance::split<T0>(&mut v2, v6));
        0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag()), 0x2::balance::split<T0>(&mut v2, v7));
        let (v8, v9) = if (v3 != v4) {
            0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::charge_fee<T0>(arg0, arg1, &mut v2)
        } else {
            (0, 0)
        };
        if (v5 > v6 + v7 || 0x2::balance::value<T1>(&v1) != 0) {
            let v10 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_supply(arg1) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_supply(arg1);
            let v11 = 0x2::balance::value<T0>(&v2);
            let v12 = 0x2::balance::value<T1>(&v1);
            let v13 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_shares(arg1);
            let v14 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::length<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13);
            let v15 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_size<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13);
            let v16 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13, 1);
            let v17 = 0;
            while (v17 < v14) {
                let v18 = 0x1::vector::borrow_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v16, v17 % v15);
                let v19 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v18, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::active_share_tag()) + 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_deposit_share_inner(v18, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::deactivating_share_tag());
                if (v19 > 0) {
                    if (v11 > 0) {
                        let v20 = (((v11 as u128) * (v19 as u128) / (v10 as u128)) as u64);
                        if (v3 != v4) {
                            let v21 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v18, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::inactive_share_tag());
                            *v21 = *v21 + v20;
                        } else {
                            let v22 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v18, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag());
                            *v22 = *v22 + v20;
                        };
                        v11 = v11 - v20;
                    };
                    if (v12 > 0) {
                        let v23 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_share_inner(v18, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::incentive_share_tag());
                        let v24 = (((v12 as u128) * (v19 as u128) / (v10 as u128)) as u64);
                        v12 = v12 - v24;
                        *v23 = *v23 + v24;
                    };
                    v10 = v10 - v19;
                };
                if (v17 + 1 < v14 && (v17 + 1) % v15 == 0) {
                    v16 = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::borrow_slice_mut<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::big_vector::slice_id<0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::DepositShare>(v13, v17 + 1));
                };
                v17 = v17 + 1;
            };
        };
        if (v3 != v4) {
            0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::inactive_share_tag()), v2);
            *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_inactive_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::inactive_balance<T0>(arg1);
        } else {
            0x2::balance::join<T0>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T0>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_share_tag()), v2);
            *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_premium_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::premium_balance<T0>(arg1);
        };
        0x2::balance::join<T1>(0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_deposit_vault_balance<T1>(arg1, 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::incentive_share_tag()), v1);
        *0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::get_mut_incentive_share_supply(arg1) = 0xf627ebfc54fdb5aea42086eeb47eb7834ccece191a05fd6c111328949fcbc392::vault::incentive_balance<T1>(arg1);
        let v25 = 0x1::vector::empty<u64>();
        let v26 = &mut v25;
        0x1::vector::push_back<u64>(v26, v5);
        0x1::vector::push_back<u64>(v26, 0x2::balance::value<T1>(&v1));
        0x1::vector::push_back<u64>(v26, v6);
        0x1::vector::push_back<u64>(v26, v7);
        0x1::vector::push_back<u64>(v26, v8);
        0x1::vector::push_back<u64>(v26, v9);
        v25
    }

    // decompiled from Move bytecode v6
}

