module 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::locked_managed_reward {
    struct LockedManagedReward has store, key {
        id: 0x2::object::UID,
        reward: 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::Reward,
    }

    public fun borrow_reward(arg0: &LockedManagedReward) : &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::Reward {
        &arg0.reward
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : LockedManagedReward {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, arg2);
        LockedManagedReward{
            id     : 0x2::object::new(arg3),
            reward : 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::create(arg0, arg1, arg1, v0, arg3),
        }
    }

    public fun deposit(arg0: &mut LockedManagedReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::deposit(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    public fun earned<T0>(arg0: &LockedManagedReward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::earned<T0>(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_balance_index(arg0: &LockedManagedReward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_prior_balance_index(&arg0.reward, arg1, arg2)
    }

    public fun get_prior_supply_index(arg0: &LockedManagedReward, arg1: u64) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_prior_supply_index(&arg0.reward, arg1)
    }

    public fun get_reward<T0>(arg0: &mut LockedManagedReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::validate(arg1, 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::ve(&arg0.reward));
        let v0 = 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::ve(&arg0.reward);
        let v1 = 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::get_reward_internal<T0>(&mut arg0.reward, 0x2::object::id_to_address(&v0), arg2, arg3, arg4);
        let v2 = if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v1)) {
            0x1::option::extract<0x2::balance::Balance<T0>>(&mut v1)
        } else {
            0x2::balance::zero<T0>()
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v1);
        v2
    }

    public fun notify_reward_amount<T0>(arg0: &mut LockedManagedReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::validate(arg1, 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::ve(&arg0.reward));
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::notify_reward_amount_internal<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
    }

    public fun rewards_list_length(arg0: &LockedManagedReward) : u64 {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::rewards_list_length(&arg0.reward)
    }

    public fun withdraw(arg0: &mut LockedManagedReward, arg1: &0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward::withdraw(&mut arg0.reward, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

