module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::exercise_fee_reward {
    struct ExerciseFeeReward has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        reward: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::Reward,
        reward_cap: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap,
        bag: 0x2::bag::Bag,
    }

    struct EventExerciseFeeRewardCreated has copy, drop, store {
        voter: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    public fun borrow_reward(arg0: &ExerciseFeeReward) : &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) : ExerciseFeeReward {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = EventExerciseFeeRewardCreated{
            voter : arg0,
            id    : v1,
        };
        0x2::event::emit<EventExerciseFeeRewardCreated>(v2);
        let (v3, v4) = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::create(v1, arg1, true, arg2);
        ExerciseFeeReward{
            id         : v0,
            voter      : arg0,
            reward     : v3,
            reward_cap : v4,
            bag        : 0x2::bag::new(arg2),
        }
    }

    public fun deposit(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::deposit(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &ExerciseFeeReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &ExerciseFeeReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &ExerciseFeeReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg3: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap(arg0, arg1);
        validate_voting_escrow<T0>(arg0, arg2);
        let v0 = 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg3);
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::owner_of<T0>(arg2, v0, arg5);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T0>(), 44194154922425176);
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

    public fun get_reward_sail<T0>(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg3: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap(arg0, arg1);
        validate_voting_escrow<T0>(arg0, arg2);
        let v0 = 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg3);
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::get_reward_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::owner_of<T0>(arg2, v0, arg5), v0, arg4, arg5);
        let v2 = if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v1)) {
            let v3 = 0x2::coin::from_balance<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut v1), arg5);
            let (v4, _) = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::locked<T0>(arg2, v0);
            let v6 = v4;
            if (0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg4) >= 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::end(&v6) && !0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::is_permanent(&v6)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::owner_of<T0>(arg2, v0, arg5));
            } else {
                0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::deposit_for<T0>(arg2, arg3, v3, arg4, arg5);
            };
            0x2::coin::value<T0>(&v3)
        } else {
            0
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v1);
        v2
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun notify_reward_amount<T0>(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        if (!0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_contains(&arg0.reward, v0)) {
            0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::add_reward_token(&mut arg0.reward, &arg0.reward_cap, v0);
        };
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun reset_final(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::reset_final(&mut arg0.reward, &arg0.reward_cap, arg2, arg3);
    }

    public fun rewards_at_epoch<T0>(arg0: &ExerciseFeeReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_at_epoch<T0>(&arg0.reward, arg1)
    }

    public fun rewards_list_length(arg0: &ExerciseFeeReward) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_list_length(&arg0.reward)
    }

    public fun rewards_this_epoch<T0>(arg0: &ExerciseFeeReward, arg1: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::rewards_this_epoch<T0>(&arg0.reward, arg1)
    }

    public fun total_supply(arg0: &ExerciseFeeReward, arg1: &0x2::clock::Clock) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::total_supply(&arg0.reward, arg1)
    }

    public fun total_supply_at(arg0: &ExerciseFeeReward, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::total_supply_at(&arg0.reward, arg1)
    }

    public fun update_balances(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_balances(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_balances_ignore_supply(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_balances_ignore_supply(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_supply(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::update_supply(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun validate_voter_cap(arg0: &ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap) {
        assert!(0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::get_voter_id(arg1) == arg0.voter, 667556652936764400);
    }

    public fun validate_voting_escrow<T0>(arg0: &ExerciseFeeReward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>) {
        assert!(arg0.voter == 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::get_voter_id<T0>(arg1), 554217603666293400);
    }

    public fun voter(arg0: &ExerciseFeeReward) : 0x2::object::ID {
        arg0.voter
    }

    public fun withdraw(arg0: &mut ExerciseFeeReward, arg1: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward::withdraw(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

