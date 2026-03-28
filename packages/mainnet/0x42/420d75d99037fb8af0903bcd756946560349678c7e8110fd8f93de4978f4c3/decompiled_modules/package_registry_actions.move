module 0x42420d75d99037fb8af0903bcd756946560349678c7e8110fd8f93de4978f4c3::package_registry_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct AddPackage has drop {
        dummy_field: bool,
    }

    struct UpdatePackageVersion has drop {
        dummy_field: bool,
    }

    struct UpdatePackageMetadata has drop {
        dummy_field: bool,
    }

    struct AddPackageAction has drop, store {
        name: 0x1::string::String,
        addr: address,
        version: u64,
        action_types: vector<0x1::string::String>,
        category: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct UpdatePackageVersionAction has drop, store {
        name: 0x1::string::String,
        addr: address,
        version: u64,
    }

    struct UpdatePackageMetadataAction has drop, store {
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

    struct GovernancePackageVersionUpdated has copy, drop {
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

    fun assert_execution_authority<T0: store>(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T0>, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
    }

    public fun do_add_package<T0: store, T1: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T0>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: T1, arg3: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        assert_execution_authority<T0>(arg0, arg1, arg3);
        let v0 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T0>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T0>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T0>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<AddPackage>(v0);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x2::bcs::peel_address(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x2::bcs::peel_vec_length(&mut v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
            v6 = v6 + 1;
        };
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v1);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::return_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::add_package_with_cap(arg3, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::remove_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, arg0, v7), v2, v3, v4, v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1))), arg0, v8);
        let v9 = GovernancePackageAdded{
            account_id : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            name       : v2,
            addr       : v3,
            version    : v4,
        };
        0x2::event::emit<GovernancePackageAdded>(v9);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T0, AddPackage, ExecutionProgressWitness>(arg0, arg3, v10);
    }

    public fun do_update_package_metadata<T0: store, T1: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T0>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: T1, arg3: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        assert_execution_authority<T0>(arg0, arg1, arg3);
        let v0 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T0>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T0>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T0>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<UpdatePackageMetadata>(v0);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x2::bcs::peel_vec_length(&mut v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
            v4 = v4 + 1;
        };
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v1);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::return_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::update_package_metadata_with_cap(arg3, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::remove_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, arg0, v5), v2, v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1))), arg0, v6);
        let v7 = GovernancePackageMetadataUpdated{
            account_id : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            name       : v2,
        };
        0x2::event::emit<GovernancePackageMetadataUpdated>(v7);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T0, UpdatePackageMetadata, ExecutionProgressWitness>(arg0, arg3, v8);
    }

    public fun do_update_package_version<T0: store, T1: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T0>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: T1, arg3: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        assert_execution_authority<T0>(arg0, arg1, arg3);
        let v0 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T0>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T0>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T0>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<UpdatePackageVersion>(v0);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x2::bcs::peel_address(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v1);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::return_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::update_package_version_with_cap(arg3, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::access_control::remove_cap<T0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageAdminCap, ExecutionProgressWitness>(arg1, arg3, arg0, v5), v2, v3, v4), arg0, v6);
        let v7 = GovernancePackageVersionUpdated{
            account_id : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            name       : v2,
            addr       : v3,
            version    : v4,
        };
        0x2::event::emit<GovernancePackageVersionUpdated>(v7);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T0, UpdatePackageVersion, ExecutionProgressWitness>(arg0, arg3, v8);
    }

    public fun new_add_package(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: 0x1::string::String) : AddPackageAction {
        AddPackageAction{
            name         : arg0,
            addr         : arg1,
            version      : arg2,
            action_types : arg3,
            category     : arg4,
            description  : arg5,
        }
    }

    public fun new_update_package_metadata(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: 0x1::string::String) : UpdatePackageMetadataAction {
        UpdatePackageMetadataAction{
            name             : arg0,
            new_action_types : arg1,
            new_category     : arg2,
            new_description  : arg3,
        }
    }

    public fun new_update_package_version(arg0: 0x1::string::String, arg1: address, arg2: u64) : UpdatePackageVersionAction {
        UpdatePackageVersionAction{
            name    : arg0,
            addr    : arg1,
            version : arg2,
        }
    }

    public(friend) fun update_package_metadata_marker() : UpdatePackageMetadata {
        UpdatePackageMetadata{dummy_field: false}
    }

    public(friend) fun update_package_version_marker() : UpdatePackageVersion {
        UpdatePackageVersion{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

