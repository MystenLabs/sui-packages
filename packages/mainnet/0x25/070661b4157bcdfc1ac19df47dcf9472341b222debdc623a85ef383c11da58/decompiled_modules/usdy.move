module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::usdy {
    struct UsdyPoolKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdyVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdyPoolPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdyVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdyPosition has store {
        deposited_value: u64,
    }

    struct UsdyInvestReceipt {
        bound_id: 0x2::object::ID,
        amount: u64,
        token_name: 0x1::string::String,
    }

    struct UsdyWithdrawReceipt {
        bound_id: 0x2::object::ID,
        principal_slice: u64,
        token_name: 0x1::string::String,
    }

    struct UsdyInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct UsdyReturned has copy, drop {
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
            abort 13906836004000432144
        };
    }

    public fun pool_invest_usdy_deposit<T0, T1>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg2: 0x2::coin::Coin<T1>, arg3: UsdyInvestReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg1, &v0), 13906834805703901190);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg4), 13906834809998606338);
        let UsdyInvestReceipt {
            bound_id   : v1,
            amount     : v2,
            token_name : _,
        } = arg3;
        assert!(v1 == 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)), 13906834822884163596);
        let v4 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg4);
        let v5 = UsdyPoolKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<UsdyPoolKey>(v4, v5)) {
            let v6 = UsdyPoolKey{dummy_field: false};
            0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<UsdyPoolKey, 0x2::coin::Coin<T1>>(v4, v6), arg2);
        } else {
            let v7 = UsdyPoolKey{dummy_field: false};
            0x2::dynamic_object_field::add<UsdyPoolKey, 0x2::coin::Coin<T1>>(v4, v7, arg2);
        };
        let v8 = UsdyPoolPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<UsdyPoolPositionKey>(v4, v8)) {
            let v9 = UsdyPoolPositionKey{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow_mut<UsdyPoolPositionKey, UsdyPosition>(v4, v9);
            v10.deposited_value = v10.deposited_value + v2;
        } else {
            let v11 = UsdyPoolPositionKey{dummy_field: false};
            let v12 = UsdyPosition{deposited_value: v2};
            0x2::dynamic_field::add<UsdyPoolPositionKey, UsdyPosition>(v4, v11, v12);
        };
        let v13 = UsdyInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount    : v2,
        };
        0x2::event::emit<UsdyInvested>(v13);
    }

    public fun pool_invest_usdy_extract<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, UsdyInvestReceipt) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg1, &v0), 13906834711214620678);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg3), 13906834715509325826);
        let v1 = UsdyInvestReceipt{
            bound_id   : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount     : arg2,
            token_name : 0x1::string::utf8(b""),
        };
        (0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg2, arg3), arg3), v1)
    }

    public fun pool_withdraw_usdy_deposit<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: 0x2::coin::Coin<T0>, arg4: UsdyWithdrawReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906835183661023238);
        let UsdyWithdrawReceipt {
            bound_id        : v1,
            principal_slice : v2,
            token_name      : _,
        } = arg4;
        assert!(v1 == 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)), 13906835196546318348);
        let v4 = 0x2::coin::value<T0>(&arg3);
        let v5 = compute_yield_fee(v4, v2, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::org_yield_fee_bps(arg1));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v5, arg5), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg1));
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg2);
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::merge_balance_from_yield<T0>(arg0, 0x2::coin::into_balance<T0>(arg3));
        let v6 = UsdyReturned{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            gross     : v4,
            yield_fee : v5,
            net       : v4 - v5,
        };
        0x2::event::emit<UsdyReturned>(v6);
    }

    public fun pool_withdraw_usdy_extract<T0, T1>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, UsdyWithdrawReceipt) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg1, &v0), 13906834964617691142);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg3), 13906834968912396290);
        let v1 = UsdyPoolKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<UsdyPoolKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834973207756808);
        let v2 = UsdyPoolKey{dummy_field: false};
        let v3 = 0x2::coin::value<T1>(0x2::dynamic_object_field::borrow<UsdyPoolKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v2));
        assert!(arg2 <= v3, 13906834990388019214);
        let v4 = UsdyPoolPositionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow<UsdyPoolPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v4).deposited_value;
        let v6 = arg2 == v3;
        let v7 = pro_rate_principal(v5, arg2, v3, v6);
        let v8 = if (v6) {
            let v9 = UsdyPoolKey{dummy_field: false};
            0x2::dynamic_object_field::remove<UsdyPoolKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg3), v9)
        } else {
            let v10 = UsdyPoolKey{dummy_field: false};
            0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<UsdyPoolKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg3), v10), arg2, arg3)
        };
        if (v6) {
            let v11 = UsdyPoolPositionKey{dummy_field: false};
            let UsdyPosition {  } = 0x2::dynamic_field::remove<UsdyPoolPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg3), v11);
        } else {
            let v12 = UsdyPoolPositionKey{dummy_field: false};
            let v13 = if (v5 > v7) {
                v5 - v7
            } else {
                0
            };
            0x2::dynamic_field::borrow_mut<UsdyPoolPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg3), v12).deposited_value = v13;
        };
        let v14 = UsdyWithdrawReceipt{
            bound_id        : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            principal_slice : v7,
            token_name      : 0x1::string::utf8(b""),
        };
        (v8, v14)
    }

    public(friend) fun pro_rate_principal(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        if (arg3) {
            return arg0
        };
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
        if (0x1::option::is_some<u128>(&v0)) {
            return (0x1::option::destroy_some<u128>(v0) as u64)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 13906835973935661072
        };
    }

    public fun vault_invest_usdy_deposit<T0, T1>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg2: 0x2::coin::Coin<T1>, arg3: UsdyInvestReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg1, &v0), 13906835428474159110);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg4), 13906835432768995332);
        let UsdyInvestReceipt {
            bound_id   : v1,
            amount     : v2,
            token_name : v3,
        } = arg3;
        let v4 = 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg4));
        assert!(v1 == v4, 13906835449949388812);
        let v5 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, v3), arg1);
        let v6 = UsdyVaultKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<UsdyVaultKey>(v5, v6)) {
            let v7 = UsdyVaultKey{dummy_field: false};
            0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<UsdyVaultKey, 0x2::coin::Coin<T1>>(v5, v7), arg2);
        } else {
            let v8 = UsdyVaultKey{dummy_field: false};
            0x2::dynamic_object_field::add<UsdyVaultKey, 0x2::coin::Coin<T1>>(v5, v8, arg2);
        };
        let v9 = UsdyVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<UsdyVaultPositionKey>(v5, v9)) {
            let v10 = UsdyVaultPositionKey{dummy_field: false};
            let v11 = 0x2::dynamic_field::borrow_mut<UsdyVaultPositionKey, UsdyPosition>(v5, v10);
            v11.deposited_value = v11.deposited_value + v2;
        } else {
            let v12 = UsdyVaultPositionKey{dummy_field: false};
            let v13 = UsdyPosition{deposited_value: v2};
            0x2::dynamic_field::add<UsdyVaultPositionKey, UsdyPosition>(v5, v12, v13);
        };
        let v14 = UsdyInvested{
            object_id : v4,
            amount    : v2,
        };
        0x2::event::emit<UsdyInvested>(v14);
    }

    public fun vault_invest_usdy_extract<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, UsdyInvestReceipt) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906835342574813190);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg4), 13906835346869649412);
        let v1 = UsdyInvestReceipt{
            bound_id   : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg4)),
            amount     : arg3,
            token_name : arg1,
        };
        (0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1), arg3), arg4), v1)
    }

    public fun vault_withdraw_usdy_deposit<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: 0x2::coin::Coin<T0>, arg4: UsdyWithdrawReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906835815021215750);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg5), 13906835819316051972);
        let UsdyWithdrawReceipt {
            bound_id        : v1,
            principal_slice : v2,
            token_name      : v3,
        } = arg4;
        let v4 = 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg5));
        assert!(v1 == v4, 13906835836496445452);
        let v5 = 0x2::coin::value<T0>(&arg3);
        let v6 = compute_yield_fee(v5, v2, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg1));
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v6, arg5), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg1));
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, v3), 0x2::coin::into_balance<T0>(arg3));
        let v7 = UsdyReturned{
            object_id : v4,
            gross     : v5,
            yield_fee : v6,
            net       : v5 - v6,
        };
        0x2::event::emit<UsdyReturned>(v7);
    }

    public fun vault_withdraw_usdy_extract<T0, T1>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, UsdyWithdrawReceipt) {
        let v0 = 0x1::string::utf8(b"usdy");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906835587387949062);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg4), 13906835591682785284);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = UsdyVaultKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<UsdyVaultKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v2), 13906835608863047690);
        let v3 = UsdyVaultKey{dummy_field: false};
        let v4 = 0x2::coin::value<T1>(0x2::dynamic_object_field::borrow<UsdyVaultKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v3));
        assert!(arg3 <= v4, 13906835630338146318);
        let v5 = UsdyVaultPositionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<UsdyVaultPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v5).deposited_value;
        let v7 = arg3 == v4;
        let v8 = pro_rate_principal(v6, arg3, v4, v7);
        let v9 = if (v7) {
            let v10 = UsdyVaultKey{dummy_field: false};
            0x2::dynamic_object_field::remove<UsdyVaultKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v10)
        } else {
            let v11 = UsdyVaultKey{dummy_field: false};
            0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<UsdyVaultKey, 0x2::coin::Coin<T1>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v11), arg3, arg4)
        };
        if (v7) {
            let v12 = UsdyVaultPositionKey{dummy_field: false};
            let UsdyPosition {  } = 0x2::dynamic_field::remove<UsdyVaultPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v12);
        } else {
            let v13 = UsdyVaultPositionKey{dummy_field: false};
            let v14 = if (v6 > v8) {
                v6 - v8
            } else {
                0
            };
            0x2::dynamic_field::borrow_mut<UsdyVaultPositionKey, UsdyPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg2), v13).deposited_value = v14;
        };
        let v15 = UsdyWithdrawReceipt{
            bound_id        : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg4)),
            principal_slice : v8,
            token_name      : arg1,
        };
        (v9, v15)
    }

    // decompiled from Move bytecode v7
}

