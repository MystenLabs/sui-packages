module 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::deps {
    struct Deps has copy, drop, store {
        registry_id: 0x2::object::ID,
        authorization_level: u8,
        account_id: 0x2::object::ID,
    }

    struct AccountDepsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DepNamesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DepInfo has copy, drop, store {
        name: 0x1::string::String,
        version: u64,
    }

    public fun new(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) : Deps {
        Deps{
            registry_id         : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg0),
            authorization_level : 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only(),
            account_id          : 0x2::object::id_from_address(@0x0),
        }
    }

    public fun auth_level_global_only() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only()
    }

    public fun auth_level_permissive() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_permissive()
    }

    public fun auth_level_whitelist() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_whitelist()
    }

    public fun account_deps_key() : AccountDepsKey {
        AccountDepsKey{dummy_field: false}
    }

    public fun account_id(arg0: &Deps) : 0x2::object::ID {
        arg0.account_id
    }

    public fun add_dep(arg0: &Deps, arg1: &mut 0x2::table::Table<address, DepInfo>, arg2: &mut 0x2::vec_map::VecMap<0x1::string::String, address>, arg3: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg4: address, arg5: 0x1::string::String, arg6: u64, arg7: 0x2::object::ID) {
        assert!(arg0.account_id == arg7, 12);
        assert!(arg0.registry_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg3), 7);
        assert!(!0x2::table::contains<address, DepInfo>(arg1, arg4), 8);
        assert!(!0x2::vec_map::contains<0x1::string::String, address>(arg2, &arg5), 14);
        if (arg0.authorization_level == 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only()) {
            assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::contains_package_addr(arg3, arg4), 2);
        };
        let v0 = DepInfo{
            name    : arg5,
            version : arg6,
        };
        0x2::table::add<address, DepInfo>(arg1, arg4, v0);
        0x2::vec_map::insert<0x1::string::String, address>(arg2, arg5, arg4);
    }

    public(friend) fun add_dep_no_auth_check(arg0: &mut 0x2::table::Table<address, DepInfo>, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        assert!(!0x2::table::contains<address, DepInfo>(arg0, arg1), 8);
        let v0 = DepInfo{
            name    : arg2,
            version : arg3,
        };
        0x2::table::add<address, DepInfo>(arg0, arg1, v0);
    }

    public fun assert_package_authorized(arg0: &Deps, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &0x2::table::Table<address, DepInfo>, arg3: address, arg4: 0x2::object::ID) {
        assert!(arg0.account_id == arg4, 12);
        assert!(arg0.registry_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg1), 7);
        assert!(is_package_authorized(arg0, arg1, arg2, arg3, arg4), 2);
    }

    public fun authorization_level(arg0: &Deps) : u8 {
        arg0.authorization_level
    }

    public(friend) fun bind_account_id(arg0: &mut Deps, arg1: 0x2::object::ID) {
        assert!(arg0.account_id == 0x2::object::id_from_address(@0x0), 13);
        arg0.account_id = arg1;
    }

    public fun check(arg0: &Deps, arg1: 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::version_witness::VersionWitness, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x2::table::Table<address, DepInfo>, arg4: 0x2::object::ID) {
        assert!(arg0.account_id == arg4, 12);
        assert!(arg0.registry_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg2), 7);
        if (arg0.authorization_level == 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_permissive()) {
            return
        };
        check_strict(arg0, arg1, arg2, arg3, arg4);
    }

    public fun check_strict(arg0: &Deps, arg1: 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::version_witness::VersionWitness, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x2::table::Table<address, DepInfo>, arg4: 0x2::object::ID) {
        assert!(arg0.account_id == arg4, 12);
        assert!(arg0.registry_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg2), 7);
        let v0 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::version_witness::package_addr(&arg1);
        if (0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::contains_package_addr(arg2, v0)) {
            return
        };
        if (arg0.authorization_level == 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only()) {
            abort 2
        };
        assert!(0x2::table::contains<address, DepInfo>(arg3, v0), 2);
    }

    public fun contains_dep(arg0: &0x2::table::Table<address, DepInfo>, arg1: address) : bool {
        0x2::table::contains<address, DepInfo>(arg0, arg1)
    }

    public fun dep_name(arg0: &DepInfo) : 0x1::string::String {
        arg0.name
    }

    public fun dep_names_key() : DepNamesKey {
        DepNamesKey{dummy_field: false}
    }

    public fun dep_version(arg0: &DepInfo) : u64 {
        arg0.version
    }

    public fun e_dep_name_already_exists() : u64 {
        14
    }

    public fun get_dep(arg0: &0x2::table::Table<address, DepInfo>, arg1: address) : &DepInfo {
        assert!(0x2::table::contains<address, DepInfo>(arg0, arg1), 9);
        0x2::table::borrow<address, DepInfo>(arg0, arg1)
    }

    public fun is_package_authorized(arg0: &Deps, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &0x2::table::Table<address, DepInfo>, arg3: address, arg4: 0x2::object::ID) : bool {
        if (arg0.account_id != arg4) {
            return false
        };
        if (arg0.registry_id != 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg1)) {
            return false
        };
        if (arg0.authorization_level == 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_permissive()) {
            return true
        };
        if (0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::contains_package_addr(arg1, arg3)) {
            return true
        };
        if (arg0.authorization_level == 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_global_only()) {
            return false
        };
        if (0x2::table::contains<address, DepInfo>(arg2, arg3)) {
            return true
        };
        false
    }

    public fun new_account_deps_table(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<address, DepInfo> {
        0x2::table::new<address, DepInfo>(arg0)
    }

    public fun new_dep_names_map() : 0x2::vec_map::VecMap<0x1::string::String, address> {
        0x2::vec_map::empty<0x1::string::String, address>()
    }

    public fun new_with_level(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg1: u8) : Deps {
        assert!(arg1 <= 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_permissive(), 10);
        Deps{
            registry_id         : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg0),
            authorization_level : arg1,
            account_id          : 0x2::object::id_from_address(@0x0),
        }
    }

    public fun registry_id(arg0: &Deps) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun remove_dep(arg0: &mut 0x2::table::Table<address, DepInfo>, arg1: address) : DepInfo {
        assert!(0x2::table::contains<address, DepInfo>(arg0, arg1), 9);
        0x2::table::remove<address, DepInfo>(arg0, arg1)
    }

    public(friend) fun set_authorization_level(arg0: &mut Deps, arg1: u8) {
        assert!(arg1 <= 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::auth_level_permissive(), 10);
        arg0.authorization_level = arg1;
    }

    // decompiled from Move bytecode v6
}

