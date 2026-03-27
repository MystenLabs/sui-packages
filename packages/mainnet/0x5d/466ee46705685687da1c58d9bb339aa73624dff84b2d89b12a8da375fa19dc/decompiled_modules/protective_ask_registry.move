module 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask_registry {
    struct ProtectiveAskKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtectiveAskRegistry has copy, drop, store {
        records: vector<ProtectiveAskRecord>,
    }

    struct ProtectiveAskRecord has copy, drop, store {
        ask_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun ask_count(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) : u64 {
        if (!has_registry(arg0)) {
            return 0
        };
        let v0 = ProtectiveAskKey{dummy_field: false};
        0x1::vector::length<ProtectiveAskRecord>(&0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_with_package_witness<ProtectiveAskKey, ProtectiveAskRegistry>(arg0, arg1, v0, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::markets_core_version::current()).records)
    }

    public fun ask_ids(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) : vector<0x2::object::ID> {
        if (!has_registry(arg0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = ProtectiveAskKey{dummy_field: false};
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_with_package_witness<ProtectiveAskKey, ProtectiveAskRegistry>(arg0, arg1, v0, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::markets_core_version::current());
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<ProtectiveAskRecord>(&v1.records)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x1::vector::borrow<ProtectiveAskRecord>(&v1.records, v3).ask_id);
            v3 = v3 + 1;
        };
        v2
    }

    fun clear_internal(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x2::object::ID) {
        if (!has_registry(arg0)) {
            return
        };
        let v0 = ProtectiveAskKey{dummy_field: false};
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut_with_package_witness<ProtectiveAskKey, ProtectiveAskRegistry>(arg0, arg1, v0, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::markets_core_version::current());
        let v2 = 0;
        while (v2 < 0x1::vector::length<ProtectiveAskRecord>(&v1.records)) {
            if (0x1::vector::borrow<ProtectiveAskRecord>(&v1.records, v2).ask_id == arg2) {
                0x1::vector::swap_remove<ProtectiveAskRecord>(&mut v1.records, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun clear_with_package_witness(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x2::object::ID) {
        clear_internal(arg0, arg1, arg2);
    }

    public fun has_registry(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account) : bool {
        let v0 = ProtectiveAskKey{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<ProtectiveAskKey>(arg0, v0)
    }

    public fun set_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::account<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg2)) == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg0), 2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::assert_current_action_witness<T0, T1>(arg2, arg1, arg3);
        set_internal(arg0, arg1, arg4, arg5);
    }

    fun set_internal(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        if (!has_registry(arg0)) {
            let v0 = ProtectiveAskRecord{
                ask_id  : arg2,
                pool_id : arg3,
            };
            let v1 = 0x1::vector::empty<ProtectiveAskRecord>();
            0x1::vector::push_back<ProtectiveAskRecord>(&mut v1, v0);
            let v2 = ProtectiveAskRegistry{records: v1};
            let v3 = ProtectiveAskKey{dummy_field: false};
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_data_with_package_witness<ProtectiveAskKey, ProtectiveAskRegistry>(arg0, arg1, v3, v2, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::markets_core_version::current());
        } else {
            let v4 = ProtectiveAskKey{dummy_field: false};
            let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::borrow_managed_data_mut_with_package_witness<ProtectiveAskKey, ProtectiveAskRegistry>(arg0, arg1, v4, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::markets_core_version::current());
            assert!(0x1::vector::length<ProtectiveAskRecord>(&v5.records) < 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_protective_asks_per_dao(), 1);
            let v6 = ProtectiveAskRecord{
                ask_id  : arg2,
                pool_id : arg3,
            };
            0x1::vector::push_back<ProtectiveAskRecord>(&mut v5.records, v6);
        };
    }

    // decompiled from Move bytecode v6
}

