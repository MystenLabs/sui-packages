module 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::intent_janitor {
    struct IntentIndex has store {
        keys: vector<0x1::string::String>,
        expiration_times: 0x2::table::Table<0x1::string::String, u64>,
        scan_position: u64,
    }

    struct IntentIndexKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IntentsCleaned has copy, drop {
        dao_id: 0x2::object::ID,
        cleaner: address,
        count: u64,
        timestamp: u64,
    }

    struct MaintenanceNeeded has copy, drop {
        dao_id: 0x2::object::ID,
        expired_count: u64,
        timestamp: u64,
    }

    public fun check_maintenance_needed(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock) {
        let v0 = count_expired_intents(arg0, arg1, arg2);
        if (v0 > 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::maintenance_threshold()) {
            let v1 = MaintenanceNeeded{
                dao_id        : 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0),
                expired_count : v0,
                timestamp     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<MaintenanceNeeded>(v1);
        };
    }

    public fun cleanup_all_expired_intents(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_per_call()) {
            let v1 = find_and_remove_next_expired_intent(arg0, arg1, arg2, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call());
            if (0x1::option::is_none<0x1::string::String>(&v1)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, 0x1::option::extract<0x1::string::String>(&mut v1), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public fun cleanup_expired_futarchy_intents(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_per_call(), 2);
        let v0 = 0;
        let v1 = 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0);
        let v2 = 0x2::tx_context::sender(arg4);
        while (v0 < arg2) {
            let v3 = find_and_remove_next_expired_intent(arg0, arg1, arg3, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call());
            if (0x1::option::is_none<0x1::string::String>(&v3)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, 0x1::option::extract<0x1::string::String>(&mut v3), arg3, arg4);
            v0 = v0 + 1;
        };
        if (v0 > 0) {
            let v4 = IntentsCleaned{
                dao_id    : v1,
                cleaner   : v2,
                count     : v0,
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<IntentsCleaned>(v4);
        };
    }

    public(friend) fun cleanup_expired_intents_automatic(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_per_call(), 2);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = find_and_remove_next_expired_intent(arg0, arg1, arg3, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call());
            if (0x1::option::is_none<0x1::string::String>(&v1)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, 0x1::option::extract<0x1::string::String>(&mut v1), arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun count_expired_intents(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock) : u64 {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return 0
        };
        let v1 = IntentIndexKey{dummy_field: false};
        let (_, v3, _) = scan_expired_from_position(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v1, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current()), 0x2::clock::timestamp_ms(arg2), 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call());
        v3
    }

    fun find_and_remove_next_expired_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: u64) : 0x1::option::Option<0x1::string::String> {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v1 = IntentIndexKey{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v1, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current());
        let v3 = 0x1::vector::length<0x1::string::String>(&v2.keys);
        if (v3 == 0 || arg3 == 0) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v4 = 0;
        let v5 = v2.scan_position;
        while (v4 < v3 && v4 < arg3) {
            if (v5 >= v3) {
                v5 = 0;
            };
            let v6 = *0x1::vector::borrow<0x1::string::String>(&v2.keys, v5);
            if (0x2::table::contains<0x1::string::String, u64>(&v2.expiration_times, v6)) {
                if (0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<0x1::string::String, u64>(&v2.expiration_times, v6)) {
                    0x2::table::remove<0x1::string::String, u64>(&mut v2.expiration_times, v6);
                    0x1::vector::swap_remove<0x1::string::String>(&mut v2.keys, v5);
                    let v7 = 0x1::vector::length<0x1::string::String>(&v2.keys);
                    if (v7 == 0 || v5 >= v7) {
                        v2.scan_position = 0;
                    } else {
                        v2.scan_position = v5;
                    };
                    return 0x1::option::some<0x1::string::String>(v6)
                };
            };
            v5 = v5 + 1;
            v4 = v4 + 1;
        };
        if (v5 >= v3) {
            v5 = 0;
        };
        v2.scan_position = v5;
        0x1::option::none<0x1::string::String>()
    }

    fun get_or_init_intent_index(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) : &mut IntentIndex {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            let v1 = IntentIndex{
                keys             : 0x1::vector::empty<0x1::string::String>(),
                expiration_times : 0x2::table::new<0x1::string::String, u64>(arg2),
                scan_position    : 0,
            };
            let v2 = IntentIndexKey{dummy_field: false};
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::add_managed_data_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v2, v1, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current());
        };
        let v3 = IntentIndexKey{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v3, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current())
    }

    public fun janitor_cleanup_status(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0x2::clock::Clock) : (bool, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call();
        let v1 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v1)) {
            return (false, 0, 0, v0, 0, 0, 0)
        };
        let v2 = IntentIndexKey{dummy_field: false};
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v2, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current());
        let v4 = 0x1::vector::length<0x1::string::String>(&v3.keys);
        if (v4 == 0) {
            return (true, 0, 0, v0, 0, 0, 0)
        };
        let v5 = v3.scan_position;
        let v6 = v5;
        if (v5 >= v4) {
            v6 = 0;
        };
        let v7 = 0x2::clock::timestamp_ms(arg2);
        let (_, v9, _) = scan_expired_from_position(v3, v7, v0);
        let (_, v12, v13) = scan_expired_from_position(v3, v7, v0 * 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_per_call());
        (true, v4, v6, v0, v9, v12, v13)
    }

    public(friend) fun register_intent<T0>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyOutcome>(), 3);
        let v0 = get_or_init_intent_index(arg0, arg1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v0.keys, arg2);
        0x2::table::add<0x1::string::String, u64>(&mut v0.expiration_times, arg2, arg3);
    }

    fun remove_from_index(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String) {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return
        };
        let v1 = IntentIndexKey{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v1, 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::futarchy_governance_actions_version::current());
        if (0x2::table::contains<0x1::string::String, u64>(&v2.expiration_times, arg2)) {
            0x2::table::remove<0x1::string::String, u64>(&mut v2.expiration_times, arg2);
        };
        let v3 = &mut v2.keys;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(v3)) {
            if (*0x1::vector::borrow<0x1::string::String>(v3, v4) == arg2) {
                0x1::vector::swap_remove<0x1::string::String>(v3, v4);
                let v5 = 0x1::vector::length<0x1::string::String>(v3);
                if (v5 == 0 || v2.scan_position >= v5) {
                    v2.scan_position = 0;
                    break
                } else {
                    break
                };
            };
            v4 = v4 + 1;
        };
    }

    fun scan_expired_from_position(arg0: &IntentIndex, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0.keys);
        if (v0 == 0 || arg2 == 0) {
            return (0, 0, 0)
        };
        let v1 = arg2;
        if (arg2 > v0) {
            v1 = v0;
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = arg0.scan_position;
        while (v2 < v1) {
            if (v4 >= v0) {
                v4 = 0;
            };
            let v5 = 0x1::vector::borrow<0x1::string::String>(&arg0.keys, v4);
            if (0x2::table::contains<0x1::string::String, u64>(&arg0.expiration_times, *v5)) {
                if (arg1 >= *0x2::table::borrow<0x1::string::String, u64>(&arg0.expiration_times, *v5)) {
                    v3 = v3 + 1;
                };
            };
            v4 = v4 + 1;
            v2 = v2 + 1;
        };
        let v6 = if (v3 == 0) {
            0
        } else {
            0 / 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_cleanup_scan_per_call() + 1
        };
        (v2, v3, v6)
    }

    fun try_delete_expired_futarchy_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : bool {
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::contains(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0), arg1)) {
            return false
        };
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::delete_expired_intent(arg0, arg1, arg2, arg3));
        true
    }

    public(friend) fun unregister_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return
        };
        remove_from_index(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

