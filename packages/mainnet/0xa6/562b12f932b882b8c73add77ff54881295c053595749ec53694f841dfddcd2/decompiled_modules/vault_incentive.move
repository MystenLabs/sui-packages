module 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_incentive {
    public entry fun add_farming_reward_config<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg2: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::assert_version(arg0);
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::add_reward_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun claim_farming_reward<T0, T1>(arg0: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg1: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg2: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
        };
    }

    public entry fun create_vault_farming_pool<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T0, T1>, arg2: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::assert_version(arg0);
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::create_lend_pool<T1>(arg2, 0x2::object::id_address<0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T0, T1>>(arg1), arg3);
    }

    public entry fun fund_farming_reward_bank<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg2: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg3: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::RewardBank<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::assert_version(arg0);
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::fund_reward_bank<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_claimable_rewards<T0>(arg0: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::ClaimableReward> {
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::get_claimable_rewards<T0>(arg0, arg1, arg2)
    }

    public fun get_reward_bank_reserve<T0>(arg0: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::RewardBank<T0>) : u64 {
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::reward_bank_reserve<T0>(arg0)
    }

    public entry fun set_farming_boost<T0>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg2: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::assert_version(arg0);
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::set_boost<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_farming_reward_config<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg2: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg3: &0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::RewardBank<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::assert_version(arg0);
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::set_reward_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun stake_after_deposit<T0>(arg0: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg1: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_for_withdraw<T0>(arg0: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Farming, arg1: &mut 0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xee5740d428e21a1ac21757c5275e7a2400f6115927837e2b13defc9122138f97::farming::unstake<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

