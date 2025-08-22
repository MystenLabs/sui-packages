module 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::fee_voting_reward {
    struct FeeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        voter: 0x2::object::ID,
        reward: 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::Reward,
        reward_cap: 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward_cap::RewardCap,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &FeeVotingReward) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::balance<T0>(&arg0.reward)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : FeeVotingReward {
        let v0 = 0x2::object::new(arg3);
        let (v1, v2) = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::create(0x2::object::uid_to_inner(&v0), arg2, true, arg3);
        FeeVotingReward{
            id         : v0,
            gauge      : arg1,
            voter      : arg0,
            reward     : v1,
            reward_cap : v2,
            bag        : 0x2::bag::new(arg3),
        }
    }

    public fun deposit(arg0: &mut FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::deposit(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun rewards_at_epoch<T0>(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::rewards_at_epoch<T0>(&arg0.reward, arg1)
    }

    public fun rewards_list_length(arg0: &FeeVotingReward) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::rewards_list_length(&arg0.reward)
    }

    public fun rewards_this_epoch<T0>(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::rewards_this_epoch<T0>(&arg0.reward, arg1)
    }

    public fun total_supply(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::total_supply(&arg0.reward, arg1)
    }

    public fun total_supply_at(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::total_supply_at(&arg0.reward, arg1)
    }

    public fun update_balances(arg0: &mut FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::update_balances(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun withdraw(arg0: &mut FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::withdraw(&mut arg0.reward, &arg0.reward_cap, arg2, arg3, arg4, arg5);
    }

    public fun borrow_reward(arg0: &FeeVotingReward) : &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::Reward {
        &arg0.reward
    }

    public fun get_reward<T0, T1>(arg0: &mut FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap, arg2: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg3: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap(arg0, arg1);
        let v0 = 0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg3);
        let v1 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::owner_of<T0>(arg2, v0);
        let v2 = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::get_reward_internal<T1>(&mut arg0.reward, &arg0.reward_cap, v1, v0, arg4, arg5);
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

    public fun notify_reward_amount<T0>(arg0: &mut FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap(arg0, arg1);
        assert!(0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::rewards_contains(&arg0.reward, 0x1::type_name::get<T0>()), 9223372427696799743);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun validate_voter_cap(arg0: &FeeVotingReward, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::VoterCap) {
        assert!(0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter_cap::get_voter_id(arg1) == arg0.voter, 785091986893168000);
    }

    // decompiled from Move bytecode v6
}

