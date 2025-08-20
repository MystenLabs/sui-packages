module 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::user_entry {
    public fun claim_reward<T0, T1>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::claim_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun claim_early_redeem<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::claim_pre_unlock<T0>(arg0, arg1, arg3)
    }

    entry fun entry_claim_early_redeem<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::claim_pre_unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun entry_claim_reward<T0, T1>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg2: &0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::claim_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun entry_merge_veToken<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg2: vector<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_veToken<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(v0, 0x2::tx_context::sender(arg4));
        let v2 = v1;
        0x1::vector::reverse<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(&v2)) {
            0x2::transfer::public_transfer<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(0x1::vector::pop_back<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(&mut v2), 0x2::tx_context::sender(arg4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(v2);
    }

    entry fun entry_mint<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    entry fun entry_redeem<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::unlock<T0>(arg0, arg1, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun extend_lock_period<T0>(arg0: &0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::extend_lock<T0>(arg0, arg1, arg2, arg3);
    }

    public fun merge_veToken<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg2: vector<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, vector<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>) {
        let v0 = &arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(v0)) {
            0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg1, 0x1::vector::borrow<0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>>(v0, v1), arg0, arg3, arg4);
            v1 = v1 + 1;
        };
        let (v2, v3) = 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::merge_veToken<T0>(arg0, arg2, arg3, arg4);
        let v4 = v2;
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::init_update_nft_reward<T0>(arg1, &v4, arg0, arg3, arg4);
        (v4, v3)
    }

    public fun mint<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_reward_distributions<T0>(arg1, arg0, arg2);
        let v1 = if (arg6) {
            0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::lock_for_max_power<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg7)
        } else {
            0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::lock<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut v0, arg3), arg4, arg7)
        };
        let v2 = v1;
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::init_update_nft_reward<T0>(arg1, &v2, arg0, arg2, arg7);
        v2
    }

    public fun redeem<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg4);
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::unlock<T0>(arg0, arg1, arg3)
    }

    public fun start_early_redeem<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::RewardManager, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::reward::update_nft_reward<T0>(arg2, arg1, arg0, arg3, arg5);
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::pre_unlock<T0>(arg0, arg1, arg3, arg4);
    }

    public fun switch_to_always_max_power<T0>(arg0: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::switch_to_always_max_power<T0>(arg0, arg1, arg2);
    }

    public fun switch_to_normal<T0>(arg0: &0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VeTokenVault<T0>, arg1: &mut 0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5c8e7a3ea036014fbafba89d6b62bd9e6659308fafc1d1ef68f8c3fe5bf1b5c::vault::switch_to_normal<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

