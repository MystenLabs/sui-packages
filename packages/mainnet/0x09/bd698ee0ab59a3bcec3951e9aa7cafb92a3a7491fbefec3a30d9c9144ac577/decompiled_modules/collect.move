module 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::collect {
    struct CollectFeesEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        sender: address,
        protocol_fee_a: u64,
        protocol_fee_b: u64,
    }

    struct CollectRewardEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
        fee: u64,
    }

    public fun fees<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::assert_supported_version(arg2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::fee<T0, T1>(arg1, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T0>(&v2));
        let v5 = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T1>(&v3));
        if (v4 > 0) {
            0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::balance::split<T0>(&mut v2, v4));
        };
        if (v5 > 0) {
            0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::balance::split<T1>(&mut v3, v5));
        };
        let v6 = CollectFeesEvent{
            vault_id       : 0x2::object::id<0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>>(arg0),
            amount_a       : 0x2::balance::value<T0>(&v2),
            amount_b       : 0x2::balance::value<T1>(&v3),
            sender         : 0x2::tx_context::sender(arg5),
            protocol_fee_a : v4,
            protocol_fee_b : v5,
        };
        0x2::event::emit<CollectFeesEvent>(v6);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v3);
    }

    public fun rewards<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::assert_supported_version(arg2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T4>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T4>(arg1, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T4>(&v0));
        if (v1 > 0) {
            0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_fee<T0, T1, T2, T3, T4>(arg0, 0x2::balance::split<T4>(&mut v0, v1));
        };
        let v2 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T4>(),
            amount      : 0x2::balance::value<T4>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
            fee         : v1,
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_reward<T0, T1, T2, T3, T4>(arg0, v0);
    }

    public fun rewards_x<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::assert_supported_version(arg2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T0>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T0>(arg1, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T0>(&v0));
        if (v1 > 0) {
            0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::balance::split<T0>(&mut v0, v1));
        };
        let v2 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T0>(),
            amount      : 0x2::balance::value<T0>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
            fee         : v1,
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_reward_x<T0, T1, T2, T3>(arg0, v0);
    }

    public fun rewards_y<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::version::assert_supported_version(arg2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::collect::reward<T0, T1, T1>(arg1, 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T1>(&v0));
        if (v1 > 0) {
            0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::balance::split<T1>(&mut v0, v1));
        };
        let v2 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T1>(),
            amount      : 0x2::balance::value<T1>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
            fee         : v1,
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vault::add_reward_y<T0, T1, T2, T3>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

