module 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_bid_registry {
    struct ProtectiveBidKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtectiveBidRegistry has copy, drop, store {
        records: vector<ProtectiveBidRecord>,
    }

    struct ProtectiveBidRecord has copy, drop, store {
        bid_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun bid_count(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) : u64 {
        if (!has_registry(arg0)) {
            return 0
        };
        let v0 = ProtectiveBidKey{dummy_field: false};
        0x1::vector::length<ProtectiveBidRecord>(&0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_with_package_witness<ProtectiveBidKey, ProtectiveBidRegistry>(arg0, arg1, v0, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::markets_core_version::current()).records)
    }

    public fun bid_ids(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) : vector<0x2::object::ID> {
        if (!has_registry(arg0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = ProtectiveBidKey{dummy_field: false};
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_with_package_witness<ProtectiveBidKey, ProtectiveBidRegistry>(arg0, arg1, v0, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::markets_core_version::current());
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<ProtectiveBidRecord>(&v1.records)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x1::vector::borrow<ProtectiveBidRecord>(&v1.records, v3).bid_id);
            v3 = v3 + 1;
        };
        v2
    }

    fun clear_internal(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID) {
        if (!has_registry(arg0)) {
            return
        };
        let v0 = ProtectiveBidKey{dummy_field: false};
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<ProtectiveBidKey, ProtectiveBidRegistry>(arg0, arg1, v0, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::markets_core_version::current());
        let v2 = 0;
        while (v2 < 0x1::vector::length<ProtectiveBidRecord>(&v1.records)) {
            if (0x1::vector::borrow<ProtectiveBidRecord>(&v1.records, v2).bid_id == arg2) {
                0x1::vector::swap_remove<ProtectiveBidRecord>(&mut v1.records, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun clear_with_package_witness(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID) {
        clear_internal(arg0, arg1, arg2);
    }

    public fun has_registry(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) : bool {
        let v0 = ProtectiveBidKey{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<ProtectiveBidKey>(arg0, v0)
    }

    public fun set_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::account<T0>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T0>(arg2)) == 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0), 2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::assert_current_action_witness<T0, T1>(arg2, arg1, arg3);
        set_internal(arg0, arg1, arg4, arg5);
    }

    fun set_internal(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        if (!has_registry(arg0)) {
            let v0 = ProtectiveBidRecord{
                bid_id  : arg2,
                pool_id : arg3,
            };
            let v1 = 0x1::vector::empty<ProtectiveBidRecord>();
            0x1::vector::push_back<ProtectiveBidRecord>(&mut v1, v0);
            let v2 = ProtectiveBidRegistry{records: v1};
            let v3 = ProtectiveBidKey{dummy_field: false};
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::add_managed_data_with_package_witness<ProtectiveBidKey, ProtectiveBidRegistry>(arg0, arg1, v3, v2, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::markets_core_version::current());
        } else {
            let v4 = ProtectiveBidKey{dummy_field: false};
            let v5 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<ProtectiveBidKey, ProtectiveBidRegistry>(arg0, arg1, v4, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::markets_core_version::current());
            assert!(0x1::vector::length<ProtectiveBidRecord>(&v5.records) < 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_protective_bids_per_dao(), 1);
            let v6 = ProtectiveBidRecord{
                bid_id  : arg2,
                pool_id : arg3,
            };
            0x1::vector::push_back<ProtectiveBidRecord>(&mut v5.records, v6);
        };
    }

    // decompiled from Move bytecode v6
}

