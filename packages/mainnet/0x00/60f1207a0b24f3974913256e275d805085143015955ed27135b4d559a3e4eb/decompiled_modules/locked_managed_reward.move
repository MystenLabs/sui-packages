module 0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::locked_managed_reward {
    struct LockedManagedReward has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        ve: 0x2::object::ID,
        reward: 0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::Reward,
        reward_cap: 0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward_cap::RewardCap,
        bag: 0x2::bag::Bag,
    }

    public fun borrow_reward(arg0: &LockedManagedReward) : &0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : LockedManagedReward {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, arg2);
        let v1 = 0x2::object::new(arg3);
        let (v2, v3) = 0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::create(0x2::object::uid_to_inner(&v1), v0, false, arg3);
        LockedManagedReward{
            id         : v1,
            voter      : arg0,
            ve         : arg1,
            reward     : v2,
            reward_cap : v3,
            bag        : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun deposit(arg0: &mut LockedManagedReward, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::deposit(&mut arg0.reward, &arg0.reward_cap, arg1, arg2, arg3, arg4);
    }

    public fun earned<T0>(arg0: &LockedManagedReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &LockedManagedReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &LockedManagedReward, arg1: u64) : u64 {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public(friend) fun get_reward<T0>(arg0: &mut LockedManagedReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = ve(arg0);
        let v1 = 0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::get_reward_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::object::id_to_address(&v0), arg1, arg2, arg3);
        let v2 = if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v1)) {
            0x1::option::extract<0x2::balance::Balance<T0>>(&mut v1)
        } else {
            0x2::balance::zero<T0>()
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v1);
        v2
    }

    public(friend) fun notify_reward_amount<T0>(arg0: &mut LockedManagedReward, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, &arg0.reward_cap, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
    }

    public fun rewards_list_length(arg0: &LockedManagedReward) : u64 {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::rewards_list_length(&arg0.reward)
    }

    public fun ve(arg0: &LockedManagedReward) : 0x2::object::ID {
        arg0.ve
    }

    public fun voter(arg0: &LockedManagedReward) : 0x2::object::ID {
        arg0.voter
    }

    public(friend) fun withdraw(arg0: &mut LockedManagedReward, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x60f1207a0b24f3974913256e275d805085143015955ed27135b4d559a3e4eb::reward::withdraw(&mut arg0.reward, &arg0.reward_cap, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

