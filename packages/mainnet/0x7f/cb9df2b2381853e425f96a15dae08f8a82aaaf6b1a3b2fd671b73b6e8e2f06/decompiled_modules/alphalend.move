module 0x7fcb9df2b2381853e425f96a15dae08f8a82aaaf6b1a3b2fd671b73b6e8e2f06::alphalend {
    struct AlphalendPoolCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AlphalendVaultCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AlphalendPoolPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AlphalendVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AlphalendPosition has store {
        deposited_value: u64,
    }

    struct AlphalendInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct AlphalendReturned has copy, drop {
        object_id: 0x2::object::ID,
        gross: u64,
        yield_fee: u64,
        net: u64,
    }

    public(friend) fun compute_yield_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v0, arg2, 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v1)) {
            return 0x1::option::destroy_some<u64>(v1)
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 13906835686172590092
        };
    }

    public fun cover_claim_from_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x2::clock::Clock, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg7), arg3);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0);
        if (v1 < v0) {
            let v2 = v0 - v1;
            let v3 = if (v2 < arg6) {
                v2
            } else {
                arg6
            };
            if (v3 > 0) {
                pool_withdraw_alphalend<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v3, arg7);
            };
        };
    }

    public fun org_withdraw_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x2::clock::Clock, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg7), 13906835634632327170);
        pool_withdraw_alphalend<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun pool_invest_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"alphalend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906834775639130118);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg6), 13906834779933835266);
        let v1 = AlphalendPoolCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AlphalendPoolCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834784229195784);
        let v2 = AlphalendPoolCapKey{dummy_field: false};
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, 0x2::dynamic_object_field::borrow<AlphalendPoolCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v2), arg4, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg5, arg6), arg6), arg3, arg6);
        let v3 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg6);
        let v4 = AlphalendPoolPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AlphalendPoolPositionKey>(v3, v4)) {
            let v5 = AlphalendPoolPositionKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::borrow_mut<AlphalendPoolPositionKey, AlphalendPosition>(v3, v5);
            v6.deposited_value = v6.deposited_value + arg5;
        } else {
            let v7 = AlphalendPoolPositionKey{dummy_field: false};
            let v8 = AlphalendPosition{deposited_value: arg5};
            0x2::dynamic_field::add<AlphalendPoolPositionKey, AlphalendPosition>(v3, v7, v8);
        };
        let v9 = AlphalendInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount    : arg5,
        };
        0x2::event::emit<AlphalendInvested>(v9);
    }

    public(friend) fun pool_withdraw_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x2::clock::Clock, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"alphalend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg4, &v0), 13906834938847887366);
        let v1 = AlphalendPoolCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AlphalendPoolCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834943142985736);
        let v2 = AlphalendPoolCapKey{dummy_field: false};
        let v3 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, 0x2::dynamic_object_field::borrow<AlphalendPoolCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v2), arg5, arg6, arg3), arg3, arg7);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = AlphalendPoolPositionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<AlphalendPoolPositionKey, AlphalendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v5).deposited_value;
        let v7 = if (arg6 <= v6) {
            arg6
        } else {
            v6
        };
        let v8 = compute_yield_fee(v4, v7, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::org_yield_fee_bps(arg2));
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v8, arg7), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg2));
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::merge_balance_from_yield<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        let v9 = AlphalendPoolPositionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AlphalendPoolPositionKey, AlphalendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v9).deposited_value = v6 - v7;
        let v10 = AlphalendReturned{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            gross     : v4,
            yield_fee : v8,
            net       : v4 - v8,
        };
        0x2::event::emit<AlphalendReturned>(v10);
    }

    public fun store_pool_position_cap<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg2), 13906834651084816386);
        let v0 = AlphalendPoolCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AlphalendPoolCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg2), v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg1, arg2));
    }

    public fun store_vault_position_cap(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg2), 13906834702624555012);
        let v0 = AlphalendVaultCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AlphalendVaultCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg2), v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg1, arg2));
    }

    public fun vault_invest_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"alphalend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg3, &v0), 13906835136416382982);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg7), 13906835140711219204);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = AlphalendVaultCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AlphalendVaultCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg3), v2), 13906835157891481610);
        let v3 = AlphalendVaultCapKey{dummy_field: false};
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg2, 0x2::dynamic_object_field::borrow<AlphalendVaultCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg3), v3), arg5, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg6), arg7), arg4, arg7);
        let v4 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg3);
        let v5 = AlphalendVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AlphalendVaultPositionKey>(v4, v5)) {
            let v6 = AlphalendVaultPositionKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<AlphalendVaultPositionKey, AlphalendPosition>(v4, v6);
            v7.deposited_value = v7.deposited_value + arg6;
        } else {
            let v8 = AlphalendVaultPositionKey{dummy_field: false};
            let v9 = AlphalendPosition{deposited_value: arg6};
            0x2::dynamic_field::add<AlphalendVaultPositionKey, AlphalendPosition>(v4, v8, v9);
        };
        let v10 = AlphalendInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg7)),
            amount    : arg6,
        };
        0x2::event::emit<AlphalendInvested>(v10);
    }

    public fun vault_withdraw_alphalend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg4: &0x2::clock::Clock, arg5: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"alphalend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg5, &v0), 13906835295330172934);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg8), 13906835299625009156);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = AlphalendVaultCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<AlphalendVaultCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v2), 13906835316805271562);
        let v3 = AlphalendVaultCapKey{dummy_field: false};
        let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg2, 0x2::dynamic_object_field::borrow<AlphalendVaultCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v3), arg6, arg7, arg4), arg4, arg8);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = AlphalendVaultPositionKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow<AlphalendVaultPositionKey, AlphalendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v6).deposited_value;
        let v8 = if (arg7 <= v7) {
            arg7
        } else {
            v7
        };
        let v9 = compute_yield_fee(v5, v8, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg3));
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v9, arg8), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg3));
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<T0>(v1, 0x2::coin::into_balance<T0>(v4));
        let v10 = AlphalendVaultPositionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AlphalendVaultPositionKey, AlphalendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v10).deposited_value = v7 - v8;
        let v11 = AlphalendReturned{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg8)),
            gross     : v5,
            yield_fee : v9,
            net       : v5 - v9,
        };
        0x2::event::emit<AlphalendReturned>(v11);
    }

    // decompiled from Move bytecode v7
}

