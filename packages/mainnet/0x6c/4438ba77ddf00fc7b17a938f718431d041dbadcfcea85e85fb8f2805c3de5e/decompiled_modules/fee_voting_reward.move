module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::fee_voting_reward {
    struct FeeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        voter: 0x2::object::ID,
        reward: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::Reward,
        reward_cap: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &FeeVotingReward) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::balance<T0>(&arg0.reward)
    }

    public fun borrow_reward(arg0: &FeeVotingReward) : &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : FeeVotingReward {
        let v0 = 0x2::object::new(arg3);
        let (v1, v2) = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::create(0x2::object::uid_to_inner(&v0), arg2, true, arg3);
        FeeVotingReward{
            id         : v0,
            gauge      : arg1,
            voter      : arg0,
            reward     : v1,
            reward_cap : v2,
            bag        : 0x2::bag::new(arg3),
        }
    }

    public fun deposit(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::deposit(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun earned_ignore_epoch_final<T0>(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::earned_ignore_epoch_final<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg3: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap(arg0, arg1);
        let v0 = 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg3);
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::owner_of<T0>(arg2, v0, arg5);
        let v2 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_reward_internal<T1>(&mut arg0.reward, &arg0.reward_cap, v1, v0, arg4, arg5);
        let v3 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v2)) {
            let v4 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg5), v1);
            0x2::balance::value<T1>(&v4)
        } else {
            0
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v2);
        v3
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun notify_reward_amount<T0>(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        assert!(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_contains(&arg0.reward, 0x1::type_name::get<T0>()), 9223372427696799743);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun reset_final(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::reset_final(&mut arg0.reward, &arg0.reward_cap, arg2, arg3);
    }

    public fun rewards_at_epoch<T0>(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_at_epoch<T0>(&arg0.reward, arg1)
    }

    public fun rewards_list_length(arg0: &FeeVotingReward) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_list_length(&arg0.reward)
    }

    public fun rewards_this_epoch<T0>(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_this_epoch<T0>(&arg0.reward, arg1)
    }

    public fun total_supply(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::total_supply(&arg0.reward, arg1)
    }

    public fun total_supply_at(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::total_supply_at(&arg0.reward, arg1)
    }

    public fun update_balances(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_balances(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_balances_ignore_supply(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_balances_ignore_supply(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_supply(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_supply(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun validate_voter_cap(arg0: &FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap) {
        assert!(0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::get_voter_id(arg1) == arg0.voter, 785091986893168000);
    }

    public fun withdraw(arg0: &mut FeeVotingReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::withdraw(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

