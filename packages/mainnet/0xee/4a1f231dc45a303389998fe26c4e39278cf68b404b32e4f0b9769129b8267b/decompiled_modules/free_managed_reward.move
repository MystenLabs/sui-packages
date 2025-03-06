module 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::free_managed_reward {
    struct FreeManagedReward has store, key {
        id: 0x2::object::UID,
        reward: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::Reward,
    }

    public fun borrow_reward(arg0: &FreeManagedReward) : &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : FreeManagedReward {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, arg2);
        FreeManagedReward{
            id     : 0x2::object::new(arg3),
            reward : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::create(arg0, arg1, arg1, v0, arg3),
        }
    }

    public fun deposit(arg0: &mut FreeManagedReward, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &FreeManagedReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &FreeManagedReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &FreeManagedReward, arg1: u64) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0>(arg0: &mut FreeManagedReward, arg1: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::lock_owner::OwnerProof, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::lock_owner::consume(arg1);
        assert!(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::ve(&arg0.reward) == v0, 9223372350387519491);
        let v3 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_reward_internal<T0>(&mut arg0.reward, 0x2::tx_context::sender(arg3), v1, arg2, arg3);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut v3), arg3), v2);
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v3);
    }

    public fun notify_reward_amount<T0>(arg0: &mut FreeManagedReward, arg1: 0x1::option::Option<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_contains(&arg0.reward, v0)) {
            assert!(0x1::option::is_some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&arg1), 9223372401927258117);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::validate<T0>(0x1::option::extract<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&mut arg1), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::voter(&arg0.reward));
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::add_reward_token(&mut arg0.reward, v0);
        };
        if (0x1::option::is_some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&arg1)) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::validate<T0>(0x1::option::extract<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&mut arg1), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::voter(&arg0.reward));
        };
        0x1::option::destroy_none<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(arg1);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_list(arg0: &FreeManagedReward) : vector<0x1::type_name::TypeName> {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list(&arg0.reward)
    }

    public fun rewards_list_length(arg0: &FreeManagedReward) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list_length(&arg0.reward)
    }

    public fun withdraw(arg0: &mut FreeManagedReward, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

