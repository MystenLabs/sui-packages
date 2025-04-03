module 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::fee_voting_reward {
    struct FeeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        reward: 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::Reward,
    }

    public fun balance<T0>(arg0: &FeeVotingReward) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::balance<T0>(&arg0.reward)
    }

    public fun borrow_reward(arg0: &FeeVotingReward) : &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : FeeVotingReward {
        FeeVotingReward{
            id     : 0x2::object::new(arg4),
            gauge  : arg2,
            reward : 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::create(arg0, arg1, arg0, arg3, arg4),
        }
    }

    public fun deposit(arg0: &mut FeeVotingReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut FeeVotingReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::voting_escrow::VotingEscrow<T0>, arg2: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::voting_escrow::Lock>(arg2);
        let v1 = 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::voting_escrow::owner_of<T0>(arg1, v0);
        let v2 = 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_reward_internal<T1>(&mut arg0.reward, v1, v0, arg3, arg4);
        let v3 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v2)) {
            let v4 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg4), v1);
            0x2::balance::value<T1>(&v4)
        } else {
            0
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v2);
        v3
    }

    public fun notify_reward_amount<T0>(arg0: &mut FeeVotingReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::validate(arg1, 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::authorized(&arg0.reward));
        assert!(0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::rewards_contains(&arg0.reward, 0x1::type_name::get<T0>()), 9223372449171636225);
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_list_length(arg0: &FeeVotingReward) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::rewards_list_length(&arg0.reward)
    }

    public fun withdraw(arg0: &mut FeeVotingReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

