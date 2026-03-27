module 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account {
    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        metadata: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::metadata::Metadata,
        deps: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::Deps,
        intents: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intents,
        initialized: bool,
    }

    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ConfigTypeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ConfigWitnessTypeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Auth {
        account_addr: address,
    }

    public fun new<T0: store, T1: drop>(arg0: T0, arg1: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::metadata::Metadata, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::Deps, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) : Account {
        assert_is_config_module_static<T0, T1>();
        let v0 = 0x2::object::new(arg4);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::bind_account_id(&mut arg2, 0x2::object::uid_to_inner(&v0));
        let v1 = Account{
            id          : v0,
            metadata    : arg1,
            deps        : arg2,
            intents     : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::empty(arg4),
            initialized : false,
        };
        0x2::dynamic_field::add<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::AccountDepsKey, 0x2::table::Table<address, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepInfo>>(&mut v1.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::account_deps_key(), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::new_account_deps_table(arg4));
        0x2::dynamic_field::add<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepNamesKey, 0x2::vec_map::VecMap<0x1::string::String, address>>(&mut v1.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::dep_names_key(), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::new_dep_names_map());
        let v2 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey, T0>(&mut v1.id, v2, arg0);
        let v3 = ConfigTypeKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigTypeKey, 0x1::type_name::TypeName>(&mut v1.id, v3, 0x1::type_name::with_original_ids<T0>());
        let v4 = ConfigWitnessTypeKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigWitnessTypeKey, 0x1::type_name::TypeName>(&mut v1.id, v4, 0x1::type_name::with_original_ids<T1>());
        v1
    }

    public fun account_deps(arg0: &Account) : &0x2::table::Table<address, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepInfo> {
        0x2::dynamic_field::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::AccountDepsKey, 0x2::table::Table<address, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepInfo>>(&arg0.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::account_deps_key())
    }

    public fun deps(arg0: &Account) : &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::Deps {
        &arg0.deps
    }

    public(friend) fun account_deps_mut(arg0: &mut Account) : &mut 0x2::table::Table<address, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepInfo> {
        0x2::dynamic_field::borrow_mut<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::AccountDepsKey, 0x2::table::Table<address, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepInfo>>(&mut arg0.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::account_deps_key())
    }

    public fun add_managed_asset<T0: copy + drop + store, T1: store + key, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: T1, arg4: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg5: T3) {
        assert_not_reserved_key<T0>();
        assert!(!has_managed_asset<T0>(arg0, arg2), 9);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg4, arg5);
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public fun add_managed_asset_with_package_witness<T0: copy + drop + store, T1: store + key>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: T1, arg4: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) {
        assert_not_reserved_key<T0>();
        assert!(!has_managed_asset<T0>(arg0, arg2), 9);
        assert_package_witness_authorized(arg0, arg1, arg4);
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public fun add_managed_data<T0: copy + drop + store, T1: store, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: T1, arg4: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg5: T3) {
        assert_not_reserved_key<T0>();
        assert!(!has_managed_data<T0>(arg0, arg2), 7);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg4, arg5);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public fun add_managed_data_with_package_witness<T0: copy + drop + store, T1: store>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: T1, arg4: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) {
        assert_not_reserved_key<T0>();
        assert!(!has_managed_data<T0>(arg0, arg2), 7);
        assert_package_witness_authorized(arg0, arg1, arg4);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public fun addr(arg0: &Account) : address {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x2::object::id_to_address(&v0)
    }

    public fun assert_execution_authorized<T0: store, T1: drop>(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1) {
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::registry_id(&arg0.deps) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry>(arg1), 23);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg2), addr(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::assert_current_action_witness<T0, T1>(arg2, arg1, arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::assert_package_authorized(deps(arg0), arg1, account_deps(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_package_addr(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T0>(arg2)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T0>(arg2))), 0x2::object::id<Account>(arg0));
    }

    public(friend) fun assert_is_config_module<T0: store, T1: drop>(arg0: &Account, arg1: T1) {
        let v0 = ConfigTypeKey{dummy_field: false};
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(&v1 == 0x2::dynamic_field::borrow<ConfigTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0), 15);
        let v2 = ConfigWitnessTypeKey{dummy_field: false};
        let v3 = 0x1::type_name::with_original_ids<T1>();
        assert!(&v3 == 0x2::dynamic_field::borrow<ConfigWitnessTypeKey, 0x1::type_name::TypeName>(&arg0.id, v2), 16);
    }

    fun assert_is_config_module_static<T0, T1: drop>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1) && 0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1), 16);
    }

    public(friend) fun assert_is_config_module_witness<T0: drop>(arg0: &Account, arg1: T0) {
        let v0 = ConfigWitnessTypeKey{dummy_field: false};
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(&v1 == 0x2::dynamic_field::borrow<ConfigWitnessTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0), 16);
    }

    public fun assert_not_initialized(arg0: &Account) {
        assert!(!arg0.initialized, 21);
    }

    fun assert_not_reserved_key<T0: copy + drop + store>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(v0 != 0x1::type_name::with_original_ids<ConfigKey>(), 24);
        assert!(v0 != 0x1::type_name::with_original_ids<ConfigTypeKey>(), 24);
        assert!(v0 != 0x1::type_name::with_original_ids<ConfigWitnessTypeKey>(), 24);
        assert!(v0 != 0x1::type_name::with_original_ids<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::AccountDepsKey>(), 24);
        assert!(v0 != 0x1::type_name::with_original_ids<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepNamesKey>(), 24);
    }

    public fun assert_package_witness_authorized(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) {
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::registry_id(&arg0.deps) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry>(arg1), 23);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::check_strict(deps(arg0), arg2, arg1, account_deps(arg0), 0x2::object::id<Account>(arg0));
    }

    public fun auth_account_addr(arg0: &Auth) : address {
        arg0.account_addr
    }

    public fun borrow_managed_asset_mut<T0: copy + drop + store, T1: store + key, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg4: T3) : &mut T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_asset<T0>(arg0, arg2), 10);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg3, arg4);
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg2)
    }

    public fun borrow_managed_asset_mut_with_package_witness<T0: copy + drop + store, T1: store + key>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : &mut T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_asset<T0>(arg0, arg2), 10);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg2)
    }

    public fun borrow_managed_asset_with_package_witness<T0: copy + drop + store, T1: store + key>(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : &T1 {
        assert!(has_managed_asset<T0>(arg0, arg2), 10);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg2)
    }

    public fun borrow_managed_data_mut<T0: copy + drop + store, T1: store, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg4: T3) : &mut T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_data<T0>(arg0, arg2), 8);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg3, arg4);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg2)
    }

    public fun borrow_managed_data_mut_with_package_witness<T0: copy + drop + store, T1: store>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : &mut T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_data<T0>(arg0, arg2), 8);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg2)
    }

    public fun borrow_managed_data_with_package_witness<T0: copy + drop + store, T1: store>(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : &T1 {
        assert!(has_managed_data<T0>(arg0, arg2), 8);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg2)
    }

    public fun cancel_intent<T0: drop + store, T1: drop>(arg0: &mut Account, arg1: 0x1::string::String, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired {
        assert_is_config_module_witness<T1>(arg0, arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::destroy_intent<T0>(&mut arg0.intents, arg1, false)
    }

    public fun intents(arg0: &Account) : &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intents {
        &arg0.intents
    }

    public fun config<T0: store>(arg0: &Account) : &T0 {
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey, T0>(&arg0.id, v0)
    }

    public fun config_mut<T0: store, T1: drop>(arg0: &mut Account, arg1: T1) : &mut T0 {
        assert!(!arg0.initialized, 21);
        assert_is_config_module<T0, T1>(arg0, arg1);
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey, T0>(&mut arg0.id, v0)
    }

    public fun config_mut_authorized<T0: store>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : &mut T0 {
        assert_package_witness_authorized(arg0, arg1, arg2);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::contains_package_addr(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg2)), 20);
        let v0 = ConfigTypeKey{dummy_field: false};
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(&v1 == 0x2::dynamic_field::borrow<ConfigTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0), 15);
        let v2 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey, T0>(&mut arg0.id, v2)
    }

    public fun config_mut_from_execution<T0: store, T1: store, T2: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>, arg3: T2) : &mut T0 {
        assert_execution_authorized<T1, T2>(arg0, arg1, arg2, arg3);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::contains_package_addr(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_package_addr(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T1>(arg2)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T1>(arg2)))), 20);
        let v0 = ConfigTypeKey{dummy_field: false};
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(&v1 == 0x2::dynamic_field::borrow<ConfigTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0), 15);
        let v2 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey, T0>(&mut arg0.id, v2)
    }

    public fun config_type(arg0: &Account) : 0x1::type_name::TypeName {
        let v0 = ConfigTypeKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ConfigTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0)
    }

    public fun confirm_execution<T0: drop + store>(arg0: &mut Account, arg1: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>) {
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::is_complete<T0>(&arg1), 6);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable_resources::destroy_resources<T0>(&mut arg1);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::destroy_complete<T0>(arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(&v0, addr(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::add_intent<T0>(&mut arg0.intents, v0);
    }

    public fun create_executable<T0: store, T1: copy + store, T2: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: T2, arg5: &mut 0x2::tx_context::TxContext) : (T1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T1>) {
        assert_is_config_module<T0, T2>(arg0, arg4);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::remove_intent<T1>(&mut arg0.intents, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::pop_front_execution_time<T1>(&mut v0), 3);
        assert!(0x2::clock::timestamp_ms(arg3) < 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::expiration_time<T1>(&v0), 25);
        if (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::authorization_level(deps(arg0)) != 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::auth_level_permissive()) {
            let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T1>(&v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v1)) {
                assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::is_package_authorized(deps(arg0), arg1, account_deps(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_package_addr(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v1, v2)), 0x2::object::id<Account>(arg0)), 20);
                v2 = v2 + 1;
            };
        };
        (*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::outcome<T1>(&v0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::new<T1>(v0, arg5))
    }

    public fun create_intent<T0: drop + store, T1: drop>(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Params, arg3: T0, arg4: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg5: T1, arg6: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intent<T0> {
        assert_package_witness_authorized(arg0, arg1, arg4);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_intent<T0, T1>(arg2, arg3, addr(arg0), arg5, arg6)
    }

    public fun delete_expired_intent<T0: drop + store, T1: drop>(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired {
        assert_is_config_module_witness<T1>(arg0, arg3);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::get<T0>(&arg0.intents, arg1);
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::expiration_time<T0>(v0);
        assert!(v1 > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 2);
        let v2 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::execution_times<T0>(v0);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::destroy_intent<T0>(&mut arg0.intents, arg1, 0x1::vector::is_empty<u64>(&v2))
    }

    public(friend) fun dep_names_mut(arg0: &mut Account) : &mut 0x2::vec_map::VecMap<0x1::string::String, address> {
        assert!(0x2::dynamic_field::exists_<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepNamesKey>(&arg0.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::dep_names_key()), 26);
        0x2::dynamic_field::borrow_mut<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepNamesKey, 0x2::vec_map::VecMap<0x1::string::String, address>>(&mut arg0.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::dep_names_key())
    }

    public(friend) fun deps_mut<T0: store, T1: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1) : &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::Deps {
        assert_execution_authorized<T0, T1>(arg0, arg1, arg2, arg3);
        &mut arg0.deps
    }

    public fun destroy_empty_intent<T0: drop + store, T1: drop>(arg0: &mut Account, arg1: 0x1::string::String, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired {
        assert_is_config_module_witness<T1>(arg0, arg2);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::execution_times<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::get<T0>(&arg0.intents, arg1));
        assert!(0x1::vector::is_empty<u64>(&v0), 1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::destroy_intent<T0>(&mut arg0.intents, arg1, true)
    }

    public(friend) fun has_dep_names(arg0: &Account) : bool {
        0x2::dynamic_field::exists_<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::DepNamesKey>(&arg0.id, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::dep_names_key())
    }

    public fun has_managed_asset<T0: copy + drop + store>(arg0: &Account, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun has_managed_data<T0: copy + drop + store>(arg0: &Account, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    fun init(arg0: ACCOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ACCOUNT>(arg0, arg1);
    }

    public fun insert_intent<T0: store, T1: drop + store, T2: drop, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intent<T1>, arg3: T2, arg4: T3) {
        assert_is_config_module<T0, T2>(arg0, arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T1>(&arg2, addr(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_witness<T1, T3>(&arg2, arg4);
        validate_action_packages_at_staging<T1>(arg0, arg1, &arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::add_intent<T1>(&mut arg0.intents, arg2);
    }

    public fun insert_intent_unshared<T0: drop + store, T1: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intent<T0>, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: T1) {
        assert!(!arg0.initialized, 21);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<T0>(&arg2, addr(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_witness<T0, T1>(&arg2, arg4);
        validate_action_packages_at_staging<T0>(arg0, arg1, &arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::add_intent<T0>(&mut arg0.intents, arg2);
    }

    public fun intents_mut<T0: store, T1: drop>(arg0: &mut Account, arg1: T1) : &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intents {
        assert_is_config_module<T0, T1>(arg0, arg1);
        &mut arg0.intents
    }

    public fun is_initialized(arg0: &Account) : bool {
        arg0.initialized
    }

    public fun keep<T0: store + key>(arg0: &Account, arg1: T0) {
        0x2::transfer::public_transfer<T0>(arg1, addr(arg0));
    }

    public fun mark_initialized<T0: drop>(arg0: &mut Account, arg1: T0) {
        assert_is_config_module_witness<T0>(arg0, arg1);
        arg0.initialized = true;
    }

    public fun metadata(arg0: &Account) : &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::metadata::Metadata {
        &arg0.metadata
    }

    public(friend) fun metadata_mut<T0: store, T1: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1) : &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::metadata::Metadata {
        assert_execution_authorized<T0, T1>(arg0, arg1, arg2, arg3);
        &mut arg0.metadata
    }

    public fun migrate_config<T0: store, T1: drop, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T1, arg3: T2) : T0 {
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::registry_id(&arg0.deps) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry>(arg1), 23);
        assert_is_config_module_witness<T1>(arg0, arg2);
        assert_is_config_module_static<T2, T3>();
        let v0 = ConfigTypeKey{dummy_field: false};
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(&v1 == 0x2::dynamic_field::borrow<ConfigTypeKey, 0x1::type_name::TypeName>(&arg0.id, v0), 15);
        let v2 = ConfigKey{dummy_field: false};
        let v3 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey, T2>(&mut arg0.id, v3, arg3);
        let v4 = ConfigTypeKey{dummy_field: false};
        0x2::dynamic_field::remove<ConfigTypeKey, 0x1::type_name::TypeName>(&mut arg0.id, v4);
        let v5 = ConfigTypeKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigTypeKey, 0x1::type_name::TypeName>(&mut arg0.id, v5, 0x1::type_name::with_original_ids<T2>());
        let v6 = ConfigWitnessTypeKey{dummy_field: false};
        0x2::dynamic_field::remove<ConfigWitnessTypeKey, 0x1::type_name::TypeName>(&mut arg0.id, v6);
        let v7 = ConfigWitnessTypeKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigWitnessTypeKey, 0x1::type_name::TypeName>(&mut arg0.id, v7, 0x1::type_name::with_original_ids<T3>());
        0x2::dynamic_field::remove<ConfigKey, T0>(&mut arg0.id, v2)
    }

    public fun new_auth<T0: store, T1: drop>(arg0: &Account, arg1: T1) : Auth {
        assert_is_config_module<T0, T1>(arg0, arg1);
        Auth{account_addr: addr(arg0)}
    }

    public(friend) fun receive<T0: store + key>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun remove_managed_asset<T0: copy + drop + store, T1: store + key, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg4: T3) : T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_asset<T0>(arg0, arg2), 10);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg3, arg4);
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg2)
    }

    public fun remove_managed_asset_with_package_witness<T0: copy + drop + store, T1: store + key>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_asset<T0>(arg0, arg2), 10);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg2)
    }

    public fun remove_managed_data<T0: copy + drop + store, T1: store, T2: store, T3: drop>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg4: T3) : T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_data<T0>(arg0, arg2), 8);
        assert_execution_authorized<T2, T3>(arg0, arg1, arg3, arg4);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg2)
    }

    public fun remove_managed_data_with_package_witness<T0: copy + drop + store, T1: store>(arg0: &mut Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: T0, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) : T1 {
        assert_not_reserved_key<T0>();
        assert!(has_managed_data<T0>(arg0, arg2), 8);
        assert_package_witness_authorized(arg0, arg1, arg3);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg2)
    }

    public fun share_account(arg0: Account) {
        arg0.initialized = true;
        0x2::transfer::share_object<Account>(arg0);
    }

    fun validate_action_packages_at_staging<T0: store>(arg0: &Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intent<T0>) {
        if (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::authorization_level(deps(arg0)) == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::auth_level_global_only()) {
            let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T0>(arg2);
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v0)) {
                assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::contains_package_addr(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_package_addr(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v0, v1))), 20);
                v1 = v1 + 1;
            };
        };
    }

    public fun verify(arg0: &Account, arg1: Auth) {
        let Auth { account_addr: v0 } = arg1;
        assert!(addr(arg0) == v0, 4);
    }

    // decompiled from Move bytecode v6
}

