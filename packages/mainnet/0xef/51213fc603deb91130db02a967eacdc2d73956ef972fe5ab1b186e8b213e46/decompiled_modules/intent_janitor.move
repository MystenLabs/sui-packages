module 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::intent_janitor {
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

    public fun check_maintenance_needed(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x2::clock::Clock) {
        let v0 = count_expired_intents(arg0, arg1, arg2);
        if (v0 > 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::maintenance_threshold()) {
            let v1 = MaintenanceNeeded{
                dao_id        : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg0),
                expired_count : v0,
                timestamp     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<MaintenanceNeeded>(v1);
        };
    }

    public fun cleanup_all_expired_intents(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_cleanup_per_call()) {
            let v1 = find_next_expired_intent(arg0, arg1, arg2, arg3);
            if (0x1::option::is_none<0x1::string::String>(&v1)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, arg1, 0x1::option::extract<0x1::string::String>(&mut v1), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public fun cleanup_expired_futarchy_intents(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_cleanup_per_call(), 2);
        let v0 = 0;
        let v1 = 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg0);
        let v2 = 0x2::tx_context::sender(arg4);
        while (v0 < arg2) {
            let v3 = find_next_expired_intent(arg0, arg1, arg3, arg4);
            if (0x1::option::is_none<0x1::string::String>(&v3)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, arg1, 0x1::option::extract<0x1::string::String>(&mut v3), arg3, arg4);
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

    public(friend) fun cleanup_expired_intents_automatic(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = find_next_expired_intent(arg0, arg1, arg3, arg4);
            if (0x1::option::is_none<0x1::string::String>(&v1)) {
                break
            };
            try_delete_expired_futarchy_intent(arg0, arg1, 0x1::option::extract<0x1::string::String>(&mut v1), arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun count_expired_intents(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x2::clock::Clock) : u64 {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return 0
        };
        let v1 = IntentIndexKey{dummy_field: false};
        let v2 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v1, 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::futarchy_governance_actions_version::current());
        let v3 = 0;
        let v4 = &v2.keys;
        let v5 = &v2.expiration_times;
        let v6 = 0x1::vector::length<0x1::string::String>(v4);
        if (v6 == 0) {
            return 0
        };
        let v7 = 0;
        let v8 = v2.scan_position;
        while (v7 < v6 && v7 < 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_cleanup_per_call()) {
            if (v8 >= v6) {
                v8 = 0;
            };
            let v9 = 0x1::vector::borrow<0x1::string::String>(v4, v8);
            if (0x2::table::contains<0x1::string::String, u64>(v5, *v9)) {
                if (0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<0x1::string::String, u64>(v5, *v9)) {
                    v3 = v3 + 1;
                };
            };
            v8 = v8 + 1;
            v7 = v7 + 1;
        };
        v3
    }

    fun find_next_expired_intent(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x1::string::String> {
        let v0 = get_or_init_intent_index(arg0, arg1, arg3);
        let v1 = &v0.keys;
        let v2 = &v0.expiration_times;
        let v3 = 0x1::vector::length<0x1::string::String>(v1);
        if (v3 == 0) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v4 = 0;
        let v5 = v0.scan_position;
        while (v4 < v3) {
            if (v5 >= v3) {
                v5 = 0;
            };
            let v6 = 0x1::vector::borrow<0x1::string::String>(v1, v5);
            if (0x2::table::contains<0x1::string::String, u64>(v2, *v6)) {
                if (0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<0x1::string::String, u64>(v2, *v6)) {
                    v0.scan_position = v5 + 1;
                    return 0x1::option::some<0x1::string::String>(*v6)
                };
            };
            v5 = v5 + 1;
            v4 = v4 + 1;
        };
        0x1::option::none<0x1::string::String>()
    }

    fun get_or_init_intent_index(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) : &mut IntentIndex {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            let v1 = IntentIndex{
                keys             : 0x1::vector::empty<0x1::string::String>(),
                expiration_times : 0x2::table::new<0x1::string::String, u64>(arg2),
                scan_position    : 0,
            };
            let v2 = IntentIndexKey{dummy_field: false};
            0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::add_managed_data_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v2, v1, 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::futarchy_governance_actions_version::current());
        };
        let v3 = IntentIndexKey{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::borrow_managed_data_mut_with_package_witness<IntentIndexKey, IntentIndex>(arg0, arg1, v3, 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::futarchy_governance_actions_version::current())
    }

    public(friend) fun register_intent<T0>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(), 3);
        let v0 = get_or_init_intent_index(arg0, arg1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v0.keys, arg2);
        0x2::table::add<0x1::string::String, u64>(&mut v0.expiration_times, arg2, arg3);
    }

    fun remove_from_index(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_init_intent_index(arg0, arg1, arg3);
        if (0x2::table::contains<0x1::string::String, u64>(&v0.expiration_times, arg2)) {
            0x2::table::remove<0x1::string::String, u64>(&mut v0.expiration_times, arg2);
        };
        let v1 = &mut v0.keys;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(v1)) {
            if (*0x1::vector::borrow<0x1::string::String>(v1, v2) == arg2) {
                0x1::vector::swap_remove<0x1::string::String>(v1, v2);
                let v3 = 0x1::vector::length<0x1::string::String>(v1);
                if (v3 == 0 || v0.scan_position >= v3) {
                    v0.scan_position = 0;
                    break
                } else {
                    break
                };
            };
            v2 = v2 + 1;
        };
    }

    fun try_delete_expired_futarchy_intent(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::contains(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::intents(arg0), arg2)) {
            remove_from_index(arg0, arg1, arg2, arg4);
            return false
        };
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::drain_and_destroy_expired(0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::delete_expired_intent(arg0, arg2, arg3, arg4));
        remove_from_index(arg0, arg1, arg2, arg4);
        true
    }

    public(friend) fun unregister_intent(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = IntentIndexKey{dummy_field: false};
        if (!0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_data<IntentIndexKey>(arg0, v0)) {
            return
        };
        remove_from_index(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

