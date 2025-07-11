module 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::collect {
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
    }

    public fun fees<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::Version, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::assert_supported_version(arg2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T0>(&v2));
        let v5 = 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T1>(&v3));
        if (v4 > 0) {
            0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::balance::split<T0>(&mut v2, v4));
        };
        if (v5 > 0) {
            0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::balance::split<T1>(&mut v3, v5));
        };
        let v6 = CollectFeesEvent{
            vault_id       : 0x2::object::id<0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>>(arg0),
            amount_a       : 0x2::balance::value<T0>(&v2),
            amount_b       : 0x2::balance::value<T1>(&v3),
            sender         : 0x2::tx_context::sender(arg5),
            protocol_fee_a : v4,
            protocol_fee_b : v5,
        };
        0x2::event::emit<CollectFeesEvent>(v6);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v3);
    }

    public fun rewards<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault_acl::VaultAcl, arg3: &0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::RouterAcl, arg4: &0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::Version, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt {
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::assert_supported_version(arg4);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T4>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T4>(arg1, 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg6, arg5, arg7));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T4>(),
            amount      : 0x2::balance::value<T4>(&v0),
            sender      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::route::issue_receipt<T0, T1, T2, T3, T4>(v0, arg0, arg2, arg3, arg7)
    }

    public fun rewards_x<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::Version, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::assert_supported_version(arg2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg1, 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T0>(&v0));
        if (v1 > 0) {
            0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::balance::split<T0>(&mut v0, v1));
        };
        let v2 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T0>(),
            amount      : 0x2::balance::value<T0>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v0);
    }

    public fun rewards_y<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::Version, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::version::assert_supported_version(arg2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg1, 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), arg4, arg3, arg5));
        let v1 = 0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::calc_fee<T0, T1, T2, T3>(arg0, 0x2::balance::value<T1>(&v0));
        if (v1 > 0) {
            0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::balance::split<T1>(&mut v0, v1));
        };
        let v2 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type : 0x1::type_name::get<T1>(),
            amount      : 0x2::balance::value<T1>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v2);
        0xb2a475cb72669cb98a6f67a54299ed362f92963d016d6853532cb2fc9af1cc91::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

