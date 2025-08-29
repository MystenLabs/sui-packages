module 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::free_managed_reward {
    struct FreeManagedReward has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        ve: 0x2::object::ID,
        reward: 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::Reward,
        reward_cap: 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_cap::RewardCap,
        bag: 0x2::bag::Bag,
    }

    public fun borrow_reward(arg0: &FreeManagedReward) : &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : FreeManagedReward {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, arg2);
        let v1 = 0x2::object::new(arg3);
        let (v2, v3) = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::create(0x2::object::uid_to_inner(&v1), v0, false, arg3);
        FreeManagedReward{
            id         : v1,
            voter      : arg0,
            ve         : arg1,
            reward     : v2,
            reward_cap : v3,
            bag        : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun deposit(arg0: &mut FreeManagedReward, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::deposit(&mut arg0.reward, &arg0.reward_cap, arg1, arg2, arg3, arg4);
    }

    public fun earned<T0>(arg0: &FreeManagedReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FreeManagedReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FreeManagedReward, arg1: u64) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public(friend) fun get_reward<T0>(arg0: &mut FreeManagedReward, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::get_reward_internal<T0>(&mut arg0.reward, &arg0.reward_cap, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut v0), arg4), arg1);
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
    }

    public fun notify_reward_amount<T0>(arg0: &mut FreeManagedReward, arg1: 0x1::option::Option<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::rewards_contains(&arg0.reward, v0)) {
            assert!(0x1::option::is_some<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>(&arg1), 9223372389042094079);
            0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::validate<T0>(0x1::option::extract<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>(&mut arg1), voter(arg0));
            0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::add_reward_token(&mut arg0.reward, &arg0.reward_cap, v0);
        };
        if (0x1::option::is_some<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>(&arg1)) {
            0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::validate<T0>(0x1::option::extract<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>(&mut arg1), voter(arg0));
        };
        0x1::option::destroy_none<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::whitelisted_tokens::WhitelistedToken>(arg1);
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_list(arg0: &FreeManagedReward) : vector<0x1::type_name::TypeName> {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::rewards_list(&arg0.reward)
    }

    public fun rewards_list_length(arg0: &FreeManagedReward) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::rewards_list_length(&arg0.reward)
    }

    public fun ve(arg0: &FreeManagedReward) : 0x2::object::ID {
        arg0.ve
    }

    public fun voter(arg0: &FreeManagedReward) : 0x2::object::ID {
        arg0.voter
    }

    public(friend) fun withdraw(arg0: &mut FreeManagedReward, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::withdraw(&mut arg0.reward, &arg0.reward_cap, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

