module 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::collect {
    struct CollectFeesEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        sender: address,
    }

    struct CollectRewardEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    public fun fees<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::assert_supported_version(arg2);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::fee<T0, T1>(arg1, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = CollectFeesEvent{
            vault_id : 0x2::object::id<0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>>(arg0),
            amount_a : 0x2::balance::value<T0>(&v2),
            amount_b : 0x2::balance::value<T1>(&v3),
            sender   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectFeesEvent>(v4);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v2);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v3);
    }

    public fun rewards<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::assert_supported_version(arg2);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T4>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T4>(arg1, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T4>(),
            amount      : 0x2::balance::value<T4>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::add_reward<T0, T1, T2, T3, T4>(arg0, v0);
    }

    public fun rewards_x<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::assert_supported_version(arg2);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T0>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T0>(arg1, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T0>(),
            amount      : 0x2::balance::value<T0>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::add_reward_x<T0, T1, T2, T3>(arg0, v0);
    }

    public fun rewards_y<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::version::assert_supported_version(arg2);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T1>(arg1, 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T1>(),
            amount      : 0x2::balance::value<T1>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::vault::add_reward_y<T0, T1, T2, T3>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

