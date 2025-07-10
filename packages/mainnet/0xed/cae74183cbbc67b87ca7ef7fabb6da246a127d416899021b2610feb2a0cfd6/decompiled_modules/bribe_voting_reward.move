module 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::bribe_voting_reward {
    struct BribeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        reward: 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::Reward,
    }

    struct EventBribeVotingRewardCreated has copy, drop, store {
        id: 0x2::object::ID,
        gauge_id: 0x2::object::ID,
    }

    public fun borrow_reward(arg0: &BribeVotingReward) : &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : BribeVotingReward {
        let v0 = 0x2::object::new(arg4);
        let v1 = EventBribeVotingRewardCreated{
            id       : 0x2::object::uid_to_inner(&v0),
            gauge_id : arg2,
        };
        0x2::event::emit<EventBribeVotingRewardCreated>(v1);
        BribeVotingReward{
            id     : v0,
            gauge  : arg2,
            reward : 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::create(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg0, arg3, true, arg4),
        }
    }

    public fun deposit(arg0: &mut BribeVotingReward, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &BribeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &BribeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &BribeVotingReward, arg1: u64) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut BribeVotingReward, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::VotingEscrow<T0>, arg2: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::Lock>(arg2);
        let v1 = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::owner_of<T0>(arg1, v0);
        let v2 = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::get_reward_internal<T1>(&mut arg0.reward, v1, v0, arg3, arg4);
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

    public fun notify_reward_amount<T0>(arg0: &mut BribeVotingReward, arg1: 0x1::option::Option<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::rewards_contains(&arg0.reward, v0)) {
            assert!(0x1::option::is_some<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>(&arg1), 9223372410516930559);
            0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::validate<T0>(0x1::option::extract<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>(&mut arg1), 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::voter(&arg0.reward));
            0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::add_reward_token(&mut arg0.reward, v0);
        };
        if (0x1::option::is_some<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>(&arg1)) {
            0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::validate<T0>(0x1::option::destroy_some<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>(arg1), 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::voter(&arg0.reward));
        } else {
            0x1::option::destroy_none<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::whitelisted_tokens::WhitelistedToken>(arg1);
        };
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_at_epoch<T0>(arg0: &BribeVotingReward, arg1: u64) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::rewards_at_epoch<T0>(&arg0.reward, arg1)
    }

    public fun rewards_list_length(arg0: &BribeVotingReward) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::rewards_list_length(&arg0.reward)
    }

    public fun rewards_this_epoch<T0>(arg0: &BribeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::rewards_this_epoch<T0>(&arg0.reward, arg1)
    }

    public fun total_supply(arg0: &BribeVotingReward, arg1: &0x2::clock::Clock) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::total_supply(&arg0.reward, arg1)
    }

    public fun total_supply_at(arg0: &BribeVotingReward, arg1: u64) : u64 {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::total_supply_at(&arg0.reward, arg1)
    }

    public fun update_balances(arg0: &mut BribeVotingReward, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_authorized_cap::RewardAuthorizedCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::update_balances(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun voter_get_reward<T0, T1>(arg0: &mut BribeVotingReward, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_authorized_cap::RewardAuthorizedCap, arg2: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::VotingEscrow<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_authorized_cap::validate(arg1, 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::authorized(&arg0.reward));
        let v0 = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::get_reward_internal<T1>(&mut arg0.reward, 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::owner_of<T0>(arg2, arg3), arg3, arg4, arg5);
        let v1 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v0)) {
            0x1::option::extract<0x2::balance::Balance<T1>>(&mut v0)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v0);
        v1
    }

    public fun withdraw(arg0: &mut BribeVotingReward, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

