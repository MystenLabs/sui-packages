module 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::user_entry {
    public fun claim_early_redeem<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg2, arg0, arg3);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg2, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(arg1), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(arg1), arg4);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::claim_pre_unlock<T0>(arg0, arg1, arg3)
    }

    public fun entry_claim_early_redeem<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg2, arg0, arg3);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg2, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(arg1), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(arg1), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::claim_pre_unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun entry_mint<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun entry_redeem<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg2, arg0, arg3);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg2, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(arg1), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(arg1), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun extend_lock_period<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::extend_lock<T0>(arg0, arg1, arg2, arg3);
    }

    public fun merge_veToken<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut vector<0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0> {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::merge_veToken<T0>(arg0, arg1, arg2, arg3)
    }

    public fun mint<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg1, arg0, arg2);
        let v1 = if (arg6) {
            0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::lock_for_max_power<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg7)
        } else {
            0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::lock<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg4, arg7)
        };
        let v2 = v1;
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg1, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(&v2), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(&v2), arg7);
        v2
    }

    public fun redeem<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg2, arg0, arg3);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg2, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(arg1), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(arg1), arg4);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::unlock<T0>(arg0, arg1, arg3)
    }

    public fun start_early_redeem<T0>(arg0: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_reward_distributions<T0>(arg2, arg0, arg3);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::update_nft_reward(arg2, 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_id<T0>(arg1), 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::nft_locked_amount<T0>(arg1), arg5);
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::pre_unlock<T0>(arg0, arg1, arg3, arg4);
    }

    public fun switch_to_always_max_power<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::switch_to_always_max_power<T0>(arg0, arg1, arg2);
    }

    public fun switch_to_normal<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::switch_to_normal<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

