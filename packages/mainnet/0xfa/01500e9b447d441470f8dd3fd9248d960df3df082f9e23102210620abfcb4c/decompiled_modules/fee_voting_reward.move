module 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::fee_voting_reward {
    struct FeeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        reward: 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::Reward,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &FeeVotingReward) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::balance<T0>(&arg0.reward)
    }

    public fun borrow_reward(arg0: &FeeVotingReward) : &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : FeeVotingReward {
        FeeVotingReward{
            id     : 0x2::object::new(arg4),
            gauge  : arg2,
            reward : 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::create(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg0, arg3, true, arg4),
            bag    : 0x2::bag::new(arg4),
        }
    }

    public fun deposit(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FeeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::VotingEscrow<T0>, arg2: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::Lock>(arg2);
        let v1 = 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::owner_of<T0>(arg1, v0);
        let v2 = 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::get_reward_internal<T1>(&mut arg0.reward, v1, v0, arg3, arg4);
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

    public fun notify_reward_amount<T0>(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward_authorized_cap::RewardAuthorizedCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward_authorized_cap::validate(arg1, 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::authorized(&arg0.reward));
        assert!(0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::rewards_contains(&arg0.reward, 0x1::type_name::get<T0>()), 9223372427696799743);
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_at_epoch<T0>(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::rewards_at_epoch<T0>(&arg0.reward, arg1)
    }

    public fun rewards_list_length(arg0: &FeeVotingReward) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::rewards_list_length(&arg0.reward)
    }

    public fun rewards_this_epoch<T0>(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::rewards_this_epoch<T0>(&arg0.reward, arg1)
    }

    public fun total_supply(arg0: &FeeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::total_supply(&arg0.reward, arg1)
    }

    public fun total_supply_at(arg0: &FeeVotingReward, arg1: u64) : u64 {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::total_supply_at(&arg0.reward, arg1)
    }

    public fun update_balances(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward_authorized_cap::RewardAuthorizedCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::update_balances(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun voter_get_reward<T0, T1>(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voter_cap::VoterCap, arg2: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::VotingEscrow<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voter_cap::get_voter_id(arg1) == 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::voter(&arg0.reward), 9223372358977323007);
        let v0 = 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::get_reward_internal<T1>(&mut arg0.reward, 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::voting_escrow::owner_of<T0>(arg2, arg3), arg3, arg4, arg5);
        let v1 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v0)) {
            0x1::option::extract<0x2::balance::Balance<T1>>(&mut v0)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v0);
        v1
    }

    public fun withdraw(arg0: &mut FeeVotingReward, arg1: &0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

