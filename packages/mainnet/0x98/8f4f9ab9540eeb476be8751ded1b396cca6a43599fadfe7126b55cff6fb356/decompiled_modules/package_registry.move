module 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry {
    struct PackageAdded has copy, drop {
        name: 0x1::string::String,
        addr: address,
        version: u64,
        num_action_types: u64,
        category: 0x1::string::String,
    }

    struct PackageVersionAdded has copy, drop {
        name: 0x1::string::String,
        addr: address,
        version: u64,
    }

    struct PackageMetadataUpdated has copy, drop {
        name: 0x1::string::String,
        num_action_types: u64,
        category: 0x1::string::String,
    }

    struct PackageRegistry has key {
        id: 0x2::object::UID,
        packages: 0x2::table::Table<0x1::string::String, PackageMetadata>,
        by_addr: 0x2::table::Table<address, 0x1::string::String>,
        active_versions: 0x2::table::Table<address, u64>,
        action_to_package: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct PackageMetadata has store {
        versions: vector<PackageVersion>,
        action_types: vector<0x1::string::String>,
        category: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct PackageVersion has copy, drop, store {
        addr: address,
        version: u64,
    }

    struct PackageAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    fun add_package_impl(arg0: &mut PackageRegistry, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 1);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.by_addr, arg2), 1);
        assert_no_duplicate_action_types(&arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg4, v0);
            assert!(!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, *v1), 3);
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.action_to_package, *v1, arg1);
            v0 = v0 + 1;
        };
        let v2 = PackageVersion{
            addr    : arg2,
            version : arg3,
        };
        let v3 = 0x1::vector::empty<PackageVersion>();
        0x1::vector::push_back<PackageVersion>(&mut v3, v2);
        let v4 = PackageMetadata{
            versions     : v3,
            action_types : arg4,
            category     : arg5,
            description  : arg6,
        };
        0x2::table::add<0x1::string::String, PackageMetadata>(&mut arg0.packages, arg1, v4);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.by_addr, arg2, arg1);
        0x2::table::add<address, u64>(&mut arg0.active_versions, arg2, arg3);
        let v5 = PackageAdded{
            name             : arg1,
            addr             : arg2,
            version          : arg3,
            num_action_types : 0x1::vector::length<0x1::string::String>(&arg4),
            category         : arg5,
        };
        0x2::event::emit<PackageAdded>(v5);
    }

    public fun add_package_with_cap(arg0: &mut PackageRegistry, arg1: PackageAdminCap, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: 0x1::string::String) : PackageAdminCap {
        assert_admin_cap_for_registry(arg0, &arg1);
        add_package_impl(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        arg1
    }

    fun assert_admin_cap_for_registry(arg0: &PackageRegistry, arg1: &PackageAdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<PackageRegistry>(arg0), 7);
    }

    fun assert_no_duplicate_action_types(arg0: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
                assert!(*0x1::vector::borrow<0x1::string::String>(arg0, v0) != *0x1::vector::borrow<0x1::string::String>(arg0, v1), 6);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun contains_package_addr(arg0: &PackageRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x1::string::String>(&arg0.by_addr, arg1)
    }

    public fun get_action_types(arg0: &PackageRegistry, arg1: 0x1::string::String) : &vector<0x1::string::String> {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        &0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1).action_types
    }

    public fun get_category(arg0: &PackageRegistry, arg1: 0x1::string::String) : &0x1::string::String {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        &0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1).category
    }

    public fun get_category_by_addr(arg0: &PackageRegistry, arg1: address) : 0x1::string::String {
        *get_category(arg0, get_package_name(arg0, arg1))
    }

    public fun get_description(arg0: &PackageRegistry, arg1: 0x1::string::String) : &0x1::string::String {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        &0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1).description
    }

    public fun get_latest_version(arg0: &PackageRegistry, arg1: 0x1::string::String) : (address, u64) {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        let v0 = &0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1).versions;
        assert!(0x1::vector::length<PackageVersion>(v0) > 0, 5);
        let v1 = 0x1::vector::borrow<PackageVersion>(v0, 0x1::vector::length<PackageVersion>(v0) - 1);
        (v1.addr, v1.version)
    }

    public fun get_package_for_action(arg0: &PackageRegistry, arg1: 0x1::string::String) : 0x1::string::String {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, arg1), 2);
        *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, arg1)
    }

    public fun get_package_metadata(arg0: &PackageRegistry, arg1: 0x1::string::String) : &PackageMetadata {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1)
    }

    public fun get_package_name(arg0: &PackageRegistry, arg1: address) : 0x1::string::String {
        assert!(0x2::table::contains<address, 0x1::string::String>(&arg0.by_addr, arg1), 0);
        *0x2::table::borrow<address, 0x1::string::String>(&arg0.by_addr, arg1)
    }

    public fun get_versions(arg0: &PackageRegistry, arg1: 0x1::string::String) : &vector<PackageVersion> {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        &0x2::table::borrow<0x1::string::String, PackageMetadata>(&arg0.packages, arg1).versions
    }

    public fun has_action_type(arg0: &PackageRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, arg1)
    }

    public fun has_package(arg0: &PackageRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageRegistry{
            id                : 0x2::object::new(arg0),
            packages          : 0x2::table::new<0x1::string::String, PackageMetadata>(arg0),
            by_addr           : 0x2::table::new<address, 0x1::string::String>(arg0),
            active_versions   : 0x2::table::new<address, u64>(arg0),
            action_to_package : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
        };
        let v1 = PackageAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<PackageRegistry>(&v0),
        };
        0x2::transfer::transfer<PackageAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PackageRegistry>(v0);
    }

    public fun is_valid_package(arg0: &PackageRegistry, arg1: 0x1::string::String, arg2: address, arg3: u64) : bool {
        if (!0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1)) {
            return false
        };
        if (!0x2::table::contains<address, u64>(&arg0.active_versions, arg2)) {
            return false
        };
        if (!0x2::table::contains<address, 0x1::string::String>(&arg0.by_addr, arg2)) {
            return false
        };
        *0x2::table::borrow<address, 0x1::string::String>(&arg0.by_addr, arg2) == arg1 && *0x2::table::borrow<address, u64>(&arg0.active_versions, arg2) == arg3
    }

    public fun metadata_action_types(arg0: &PackageMetadata) : &vector<0x1::string::String> {
        &arg0.action_types
    }

    public fun metadata_category(arg0: &PackageMetadata) : &0x1::string::String {
        &arg0.category
    }

    public fun metadata_description(arg0: &PackageMetadata) : &0x1::string::String {
        &arg0.description
    }

    public fun metadata_versions(arg0: &PackageMetadata) : &vector<PackageVersion> {
        &arg0.versions
    }

    public(friend) fun new_package_version(arg0: address, arg1: u64) : PackageVersion {
        PackageVersion{
            addr    : arg0,
            version : arg1,
        }
    }

    public fun registry_id(arg0: &PackageRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun registry_id_mut(arg0: &mut PackageRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun update_package_metadata_impl(arg0: &mut PackageRegistry, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        assert_no_duplicate_action_types(&arg2);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, PackageMetadata>(&mut arg0.packages, arg1);
        let v1 = &v0.action_types;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(v1, v2);
            if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, *v3)) {
                0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.action_to_package, *v3);
            };
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v5 = 0x1::vector::borrow<0x1::string::String>(&arg2, v4);
            assert!(!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.action_to_package, *v5), 3);
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.action_to_package, *v5, arg1);
            v4 = v4 + 1;
        };
        v0.action_types = arg2;
        v0.category = arg3;
        v0.description = arg4;
        let v6 = PackageMetadataUpdated{
            name             : arg1,
            num_action_types : 0x1::vector::length<0x1::string::String>(&arg2),
            category         : arg3,
        };
        0x2::event::emit<PackageMetadataUpdated>(v6);
    }

    public fun update_package_metadata_with_cap(arg0: &mut PackageRegistry, arg1: PackageAdminCap, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: 0x1::string::String) : PackageAdminCap {
        assert_admin_cap_for_registry(arg0, &arg1);
        update_package_metadata_impl(arg0, arg2, arg3, arg4, arg5);
        arg1
    }

    fun update_package_version_impl(arg0: &mut PackageRegistry, arg1: 0x1::string::String, arg2: address, arg3: u64) {
        assert!(0x2::table::contains<0x1::string::String, PackageMetadata>(&arg0.packages, arg1), 0);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.by_addr, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, PackageMetadata>(&mut arg0.packages, arg1);
        assert!(0x1::vector::length<PackageVersion>(&v0.versions) > 0, 5);
        let v1 = 0x1::vector::borrow<PackageVersion>(&v0.versions, 0x1::vector::length<PackageVersion>(&v0.versions) - 1);
        assert!(arg3 > v1.version, 4);
        let v2 = v1.addr;
        let v3 = PackageVersion{
            addr    : arg2,
            version : arg3,
        };
        0x1::vector::push_back<PackageVersion>(&mut v0.versions, v3);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.by_addr, arg2, arg1);
        if (0x2::table::contains<address, u64>(&arg0.active_versions, v2)) {
            0x2::table::remove<address, u64>(&mut arg0.active_versions, v2);
        };
        0x2::table::add<address, u64>(&mut arg0.active_versions, arg2, arg3);
        let v4 = PackageVersionAdded{
            name    : arg1,
            addr    : arg2,
            version : arg3,
        };
        0x2::event::emit<PackageVersionAdded>(v4);
    }

    public fun update_package_version_with_cap(arg0: &mut PackageRegistry, arg1: PackageAdminCap, arg2: 0x1::string::String, arg3: address, arg4: u64) : PackageAdminCap {
        assert_admin_cap_for_registry(arg0, &arg1);
        update_package_version_impl(arg0, arg2, arg3, arg4);
        arg1
    }

    public fun version_addr(arg0: &PackageVersion) : address {
        arg0.addr
    }

    public fun version_number(arg0: &PackageVersion) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

