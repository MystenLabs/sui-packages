module 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::user_entry {
    public fun claim_early_redeem<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::claim_pre_unlock<T0>(arg0, arg1, arg3)
    }

    public fun entry_claim_early_redeem<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::claim_pre_unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun entry_mint<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun entry_redeem<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun extend_lock_period<T0>(arg0: &0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::extend_lock<T0>(arg0, arg1, arg2, arg3);
    }

    public fun merge_veToken<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg2: &mut vector<0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>>(arg2)) {
            0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg1, 0x1::vector::borrow<0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>>(arg2, v0), arg0, arg3, arg4);
            v0 = v0 + 1;
        };
        let v1 = 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::merge_veToken<T0>(arg0, arg2, arg3, arg4);
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::init_update_nft_reward<T0>(arg1, &v1, arg0, arg3, arg4);
        v1
    }

    public fun mint<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_reward_distributions<T0>(arg1, arg0, arg2);
        let v1 = if (arg6) {
            0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::lock_for_max_power<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg7)
        } else {
            0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::lock<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg4, arg7)
        };
        let v2 = v1;
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::init_update_nft_reward<T0>(arg1, &v2, arg0, arg2, arg7);
        v2
    }

    public fun redeem<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::unlock<T0>(arg0, arg1, arg3)
    }

    public fun start_early_redeem<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg5);
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::pre_unlock<T0>(arg0, arg1, arg3, arg4);
    }

    public fun switch_to_always_max_power<T0>(arg0: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::switch_to_always_max_power<T0>(arg0, arg1, arg2);
    }

    public fun switch_to_normal<T0>(arg0: &0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VeTokenVault<T0>, arg1: &mut 0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x31f5ad6351ed7a02fa0de61ef6d5edb4696fae59247bcee6cd0dd21714a67dd2::vault::switch_to_normal<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

