module 0xfad6acc479e56aab0f45264c175f6c86696798641221188aa14cacf280d90619::package_registry_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct AddPackage has drop {
        dummy_field: bool,
    }

    struct UpdatePackageMetadata has drop {
        dummy_field: bool,
    }

    struct AddPackageAction has copy, drop, store {
        name: 0x1::string::String,
        addr: address,
        version: u64,
        action_types: vector<0x1::string::String>,
        category: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct UpdatePackageMetadataAction has copy, drop, store {
        name: 0x1::string::String,
        new_action_types: vector<0x1::string::String>,
        new_category: 0x1::string::String,
        new_description: 0x1::string::String,
    }

    struct GovernancePackageAdded has copy, drop {
        account_id: 0x2::object::ID,
        name: 0x1::string::String,
        addr: address,
        version: u64,
    }

    struct GovernancePackageMetadataUpdated has copy, drop {
        account_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public(friend) fun add_package_marker() : AddPackage {
        AddPackage{dummy_field: false}
    }

    fun assert_execution_authority<T0: store>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
    }

    fun assert_metadata_string_len(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::constants::max_action_data_size(), 3);
    }

    public fun do_add_package<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: T1, arg3: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        assert_execution_authority<T0>(arg0, arg1, arg3);
        let v0 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T0>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T0>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T0>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<AddPackage>(v0);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v2);
        let v3 = 0x2::bcs::peel_address(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v5 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_package_registry_action_types(), 2);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < v5) {
            let v8 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
            assert_metadata_string_len(&v8);
            0x1::vector::push_back<0x1::string::String>(&mut v6, v8);
            v7 = v7 + 1;
        };
        let v9 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v9);
        let v10 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v10);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v1);
        let v11 = ExecutionProgressWitness{dummy_field: false};
        let (v12, v13) = 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::remove_cap<T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, arg0, v11);
        let v14 = ExecutionProgressWitness{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::return_cap<T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::add_package_with_cap(arg3, v12, v2, v3, v4, v6, v9, v10), v13, arg0, v14);
        let v15 = GovernancePackageAdded{
            account_id : 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1),
            name       : v2,
            addr       : v3,
            version    : v4,
        };
        0x2::event::emit<GovernancePackageAdded>(v15);
        let v16 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T0, AddPackage, ExecutionProgressWitness>(arg0, arg3, v16);
    }

    public fun do_update_package_metadata<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: T1, arg3: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        assert_execution_authority<T0>(arg0, arg1, arg3);
        let v0 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T0>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T0>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T0>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<UpdatePackageMetadata>(v0);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v2);
        let v3 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v3 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_package_registry_action_types(), 2);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
            assert_metadata_string_len(&v6);
            0x1::vector::push_back<0x1::string::String>(&mut v4, v6);
            v5 = v5 + 1;
        };
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v7);
        let v8 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        assert_metadata_string_len(&v8);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v1);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        let (v10, v11) = 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::remove_cap<T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, arg0, v9);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::return_cap<T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::update_package_metadata_with_cap(arg3, v10, v2, v4, v7, v8), v11, arg0, v12);
        let v13 = GovernancePackageMetadataUpdated{
            account_id : 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1),
            name       : v2,
        };
        0x2::event::emit<GovernancePackageMetadataUpdated>(v13);
        let v14 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T0, UpdatePackageMetadata, ExecutionProgressWitness>(arg0, arg3, v14);
    }

    public fun new_add_package_action(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: 0x1::string::String) : AddPackageAction {
        AddPackageAction{
            name         : arg0,
            addr         : arg1,
            version      : arg2,
            action_types : arg3,
            category     : arg4,
            description  : arg5,
        }
    }

    public fun new_update_package_metadata_action(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: 0x1::string::String) : UpdatePackageMetadataAction {
        UpdatePackageMetadataAction{
            name             : arg0,
            new_action_types : arg1,
            new_category     : arg2,
            new_description  : arg3,
        }
    }

    public(friend) fun update_package_metadata_marker() : UpdatePackageMetadata {
        UpdatePackageMetadata{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

