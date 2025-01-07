module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::bucket {
    struct BucketStakeProof has copy, drop, store {
        dummy_field: bool,
    }

    public fun check_exist_stake_proof<T0, T1>(arg0: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>) : bool {
        let v0 = BucketStakeProof{dummy_field: false};
        0x2::bag::contains<BucketStakeProof>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets<T0, T1>(arg0), v0)
    }

    public fun close<T0, T1>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_withdraw_time<T0, T1>(arg0, arg4);
        if (check_exist_stake_proof<T0, T1>(arg0)) {
            let v0 = BucketStakeProof{dummy_field: false};
            let (v1, v2) = withdraw_(0x2::bag::remove<BucketStakeProof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0), arg1, arg2, arg3, arg4);
            0x2::balance::join<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0x2::sui::SUI>(arg0)), v2);
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0)), v1);
        };
    }

    public fun deposit<T0, T1>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg6);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0);
        };
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, 0x2::sui::SUI>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, 0x2::sui::SUI>(arg0);
        };
        let v0 = BucketStakeProof{dummy_field: false};
        let v1 = if (check_exist_stake_proof<T0, T1>(arg0)) {
            let (v2, v3) = withdraw_(0x2::bag::remove<BucketStakeProof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0), arg3, arg4, arg5, arg6);
            0x2::balance::join<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0x2::sui::SUI>(arg0)), v3);
            v2
        } else {
            0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>()
        };
        let v4 = 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0)), arg2);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v4, v1);
        0x2::bag::add<BucketStakeProof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0, deposit_(v4, arg3, arg4, arg5, arg6, arg7));
    }

    fun deposit_(arg0: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI> {
        let (_, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg3);
        0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::buck_to_sbuck(arg1, arg2, arg4, arg0), v1, arg5)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AlphaVault<T0, T1>, arg1: &0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::AdminCap<T1>, arg2: u64, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assert_locked_period<T0, T1>(arg0, arg6);
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0);
        };
        if (!0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::is_token_exists<T0, T1, 0x2::sui::SUI>(arg0)) {
            0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::add_new_token<T0, T1, 0x2::sui::SUI>(arg0);
        };
        let v0 = BucketStakeProof{dummy_field: false};
        let (v1, v2) = withdraw_(0x2::bag::remove<BucketStakeProof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0), arg3, arg4, arg5, arg6);
        let v3 = v1;
        0x2::balance::join<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0x2::sui::SUI>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0x2::sui::SUI>(arg0)), v2);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::balance_mut<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::token_infos_mut<T0, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0)), 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v3, arg2));
        0x2::bag::add<BucketStakeProof, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault::assets_mut<T0, T1>(arg0), v0, deposit_(v3, arg3, arg4, arg5, arg6, arg7));
    }

    fun withdraw_(arg0: 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let (v0, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg3, arg0);
        (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::sbuck_to_buck(arg1, arg2, arg4, v0), v1)
    }

    // decompiled from Move bytecode v6
}

