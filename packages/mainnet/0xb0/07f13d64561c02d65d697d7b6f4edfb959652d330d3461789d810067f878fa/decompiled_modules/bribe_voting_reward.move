module 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::bribe_voting_reward {
    struct BribeVotingReward has store, key {
        id: 0x2::object::UID,
        gauge: 0x2::object::ID,
        reward: 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::Reward,
    }

    public fun borrow_reward(arg0: &BribeVotingReward) : &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : BribeVotingReward {
        BribeVotingReward{
            id     : 0x2::object::new(arg4),
            gauge  : arg2,
            reward : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::create(arg0, arg1, arg0, arg3, arg4),
        }
    }

    public fun deposit(arg0: &mut BribeVotingReward, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &BribeVotingReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &BribeVotingReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &BribeVotingReward, arg1: u64) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0, T1>(arg0: &mut BribeVotingReward, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::Lock>(arg2);
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::owner_of<T0>(arg1, v0);
        let v2 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::get_reward_internal<T1>(&mut arg0.reward, v1, v0, arg3, arg4);
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

    public fun notify_reward_amount<T0>(arg0: &mut BribeVotingReward, arg1: 0x1::option::Option<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_contains(&arg0.reward, v0)) {
            assert!(0x1::option::is_some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&arg1), 9223372431991767039);
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::validate<T0>(0x1::option::extract<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&mut arg1), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::voter(&arg0.reward));
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::add_reward_token(&mut arg0.reward, v0);
        };
        if (0x1::option::is_some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(&arg1)) {
            0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::validate<T0>(0x1::option::destroy_some<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(arg1), 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::voter(&arg0.reward));
        } else {
            0x1::option::destroy_none<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::whitelisted_tokens::WhitelistedToken>(arg1);
        };
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_list_length(arg0: &BribeVotingReward) : u64 {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::rewards_list_length(&arg0.reward)
    }

    public fun withdraw(arg0: &mut BribeVotingReward, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

