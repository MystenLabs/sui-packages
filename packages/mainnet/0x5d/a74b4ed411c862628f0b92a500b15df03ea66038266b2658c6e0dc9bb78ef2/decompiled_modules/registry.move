module 0x5da74b4ed411c862628f0b92a500b15df03ea66038266b2658c6e0dc9bb78ef2::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        namespace_count: u64,
        package_count: u64,
        version_count: u64,
        admin_cap: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Namespace has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        package_count: u64,
        created_at: u64,
        display_name: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        avatar_url: 0x1::option::Option<0x1::string::String>,
        website: 0x1::option::Option<0x1::string::String>,
    }

    struct Package has store, key {
        id: 0x2::object::UID,
        full_name: 0x1::string::String,
        name: 0x1::string::String,
        namespace: 0x1::string::String,
        latest_version: Version,
        package_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        downloads: u64,
        created_at: u64,
        updated_at: u64,
        deprecated: bool,
        deprecation_message: 0x1::option::Option<0x1::string::String>,
        metadata: PackageMetadata,
    }

    struct PackageMetadata has copy, drop, store {
        description: 0x1::string::String,
        repository: 0x1::option::Option<0x1::string::String>,
        documentation: 0x1::option::Option<0x1::string::String>,
        homepage: 0x1::option::Option<0x1::string::String>,
        license: 0x1::option::Option<0x1::string::String>,
        keywords: vector<0x1::string::String>,
        icon_url: 0x1::option::Option<0x1::string::String>,
    }

    struct Version has copy, drop, store {
        major: u64,
        minor: u64,
        patch: u64,
    }

    struct VersionEntry has copy, drop, store {
        version: Version,
        package_id: 0x2::object::ID,
        published_at: u64,
        changelog: 0x1::option::Option<0x1::string::String>,
        git_ref: 0x1::option::Option<0x1::string::String>,
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
        namespace: 0x1::string::String,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct NamespaceCreated has copy, drop {
        namespace: 0x1::string::String,
        owner: address,
        created_at: u64,
    }

    struct PackagePublished has copy, drop {
        full_name: 0x1::string::String,
        namespace: 0x1::string::String,
        package_name: 0x1::string::String,
        package_id: 0x2::object::ID,
        version: Version,
        published_at: u64,
    }

    struct VersionPublished has copy, drop {
        full_name: 0x1::string::String,
        version: Version,
        package_id: 0x2::object::ID,
        published_at: u64,
    }

    struct PackageDeprecated has copy, drop {
        full_name: 0x1::string::String,
        message: 0x1::string::String,
    }

    struct OwnershipTransferred has copy, drop {
        namespace: 0x1::string::String,
        from: address,
        to: address,
    }

    fun build_full_name(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"@");
        0x1::string::append(&mut v0, *arg0);
        0x1::string::append_utf8(&mut v0, b"/");
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public entry fun claim_namespace(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_name(&arg1), 5);
        let v0 = *0x1::string::bytes(&arg1);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 7);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = Namespace{
            id            : 0x2::object::new(arg3),
            name          : arg1,
            owner         : v1,
            package_count : 0,
            created_at    : v2,
            display_name  : 0x1::option::none<0x1::string::String>(),
            description   : 0x1::option::none<0x1::string::String>(),
            avatar_url    : 0x1::option::none<0x1::string::String>(),
            website       : 0x1::option::none<0x1::string::String>(),
        };
        let v4 = PublisherCap{
            id        : 0x2::object::new(arg3),
            namespace : arg1,
        };
        let v5 = NamespaceCreated{
            namespace  : arg1,
            owner      : v1,
            created_at : v2,
        };
        0x2::event::emit<NamespaceCreated>(v5);
        0x2::dynamic_field::add<vector<u8>, Namespace>(&mut arg0.id, v0, v3);
        arg0.namespace_count = arg0.namespace_count + 1;
        0x2::transfer::transfer<PublisherCap>(v4, v1);
    }

    public entry fun deprecate_package(arg0: &mut Registry, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = arg1.namespace;
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Package>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&v0)).id, *0x1::string::bytes(&arg2));
        v1.deprecated = true;
        v1.deprecation_message = 0x1::option::some<0x1::string::String>(arg3);
        let v2 = PackageDeprecated{
            full_name : v1.full_name,
            message   : arg3,
        };
        0x2::event::emit<PackageDeprecated>(v2);
    }

    public fun get_namespace(arg0: &Registry, arg1: &0x1::string::String) : &Namespace {
        0x2::dynamic_field::borrow<vector<u8>, Namespace>(&arg0.id, *0x1::string::bytes(arg1))
    }

    public fun get_package(arg0: &Registry, arg1: &0x1::string::String, arg2: &0x1::string::String) : &Package {
        0x2::dynamic_object_field::borrow<vector<u8>, Package>(&get_namespace(arg0, arg1).id, *0x1::string::bytes(arg2))
    }

    public fun get_stats(arg0: &Registry) : (u64, u64, u64) {
        (arg0.namespace_count, arg0.package_count, arg0.version_count)
    }

    public fun get_version(arg0: &Package, arg1: &Version) : &VersionEntry {
        0x2::dynamic_field::borrow<vector<u8>, VersionEntry>(&arg0.id, version_to_key(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        let v2 = Registry{
            id              : 0x2::object::new(arg0),
            namespace_count : 0,
            package_count   : 0,
            version_count   : 0,
            admin_cap       : v1,
        };
        let v3 = RegistryCreated{
            registry_id  : 0x2::object::id<Registry>(&v2),
            admin_cap_id : v1,
        };
        0x2::event::emit<RegistryCreated>(v3);
        0x2::transfer::share_object<Registry>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 64) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v3 >= 97 && v3 <= 122;
            let v5 = v3 >= 48 && v3 <= 57;
            let v6 = v3 == 45;
            let v7 = if (!v4) {
                if (!v5) {
                    !v6
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                return false
            };
            if (v6 && (v2 == 0 || v2 == v1 - 1)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_version_greater(arg0: &Version, arg1: &Version) : bool {
        if (arg0.major > arg1.major) {
            return true
        };
        if (arg0.major < arg1.major) {
            return false
        };
        if (arg0.minor > arg1.minor) {
            return true
        };
        if (arg0.minor < arg1.minor) {
            return false
        };
        arg0.patch > arg1.patch
    }

    public fun metadata_description(arg0: &PackageMetadata) : &0x1::string::String {
        &arg0.description
    }

    public fun metadata_documentation(arg0: &PackageMetadata) : &0x1::option::Option<0x1::string::String> {
        &arg0.documentation
    }

    public fun metadata_homepage(arg0: &PackageMetadata) : &0x1::option::Option<0x1::string::String> {
        &arg0.homepage
    }

    public fun metadata_icon_url(arg0: &PackageMetadata) : &0x1::option::Option<0x1::string::String> {
        &arg0.icon_url
    }

    public fun metadata_license(arg0: &PackageMetadata) : &0x1::option::Option<0x1::string::String> {
        &arg0.license
    }

    public fun metadata_repository(arg0: &PackageMetadata) : &0x1::option::Option<0x1::string::String> {
        &arg0.repository
    }

    public fun namespace_name(arg0: &Namespace) : 0x1::string::String {
        arg0.name
    }

    public fun namespace_owner(arg0: &Namespace) : address {
        arg0.owner
    }

    public fun namespace_package_count(arg0: &Namespace) : u64 {
        arg0.package_count
    }

    public fun package_deprecated(arg0: &Package) : bool {
        arg0.deprecated
    }

    public fun package_downloads(arg0: &Package) : u64 {
        arg0.downloads
    }

    public fun package_full_name(arg0: &Package) : 0x1::string::String {
        arg0.full_name
    }

    public fun package_id(arg0: &Package) : 0x2::object::ID {
        arg0.package_id
    }

    public fun package_metadata(arg0: &Package) : &PackageMetadata {
        &arg0.metadata
    }

    public fun package_name(arg0: &Package) : 0x1::string::String {
        arg0.name
    }

    public fun package_namespace(arg0: &Package) : 0x1::string::String {
        arg0.namespace
    }

    public fun package_version(arg0: &Package) : Version {
        arg0.latest_version
    }

    public entry fun publish_package(arg0: &mut Registry, arg1: &PublisherCap, arg2: &0x2::package::UpgradeCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_name(&arg3), 5);
        let v0 = arg1.namespace;
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&v0));
        let v2 = build_full_name(&v0, &arg3);
        let v3 = *0x1::string::bytes(&arg3);
        assert!(!0x2::dynamic_object_field::exists_<vector<u8>>(&v1.id, v3), 1);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = 0x2::package::upgrade_package(arg2);
        let v6 = Version{
            major : 1,
            minor : 0,
            patch : 0,
        };
        let v7 = PackageMetadata{
            description   : arg4,
            repository    : 0x1::option::none<0x1::string::String>(),
            documentation : 0x1::option::none<0x1::string::String>(),
            homepage      : 0x1::option::none<0x1::string::String>(),
            license       : 0x1::option::none<0x1::string::String>(),
            keywords      : 0x1::vector::empty<0x1::string::String>(),
            icon_url      : 0x1::option::none<0x1::string::String>(),
        };
        let v8 = Package{
            id                  : 0x2::object::new(arg6),
            full_name           : v2,
            name                : arg3,
            namespace           : v0,
            latest_version      : v6,
            package_id          : v5,
            upgrade_cap_id      : 0x2::object::id<0x2::package::UpgradeCap>(arg2),
            downloads           : 0,
            created_at          : v4,
            updated_at          : v4,
            deprecated          : false,
            deprecation_message : 0x1::option::none<0x1::string::String>(),
            metadata            : v7,
        };
        let v9 = VersionEntry{
            version      : v6,
            package_id   : v5,
            published_at : v4,
            changelog    : 0x1::option::none<0x1::string::String>(),
            git_ref      : 0x1::option::none<0x1::string::String>(),
        };
        0x2::dynamic_field::add<vector<u8>, VersionEntry>(&mut v8.id, version_to_key(&v6), v9);
        let v10 = PackagePublished{
            full_name    : v2,
            namespace    : v0,
            package_name : arg3,
            package_id   : v5,
            version      : v6,
            published_at : v4,
        };
        0x2::event::emit<PackagePublished>(v10);
        0x2::dynamic_object_field::add<vector<u8>, Package>(&mut v1.id, v3, v8);
        v1.package_count = v1.package_count + 1;
        arg0.package_count = arg0.package_count + 1;
        arg0.version_count = arg0.version_count + 1;
    }

    public entry fun publish_version(arg0: &mut Registry, arg1: &PublisherCap, arg2: &0x2::package::UpgradeCap, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: &0x2::clock::Clock) {
        let v0 = arg1.namespace;
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Package>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&v0)).id, *0x1::string::bytes(&arg3));
        assert!(0x2::object::id<0x2::package::UpgradeCap>(arg2) == v1.upgrade_cap_id, 10);
        let v2 = Version{
            major : arg4,
            minor : arg5,
            patch : arg6,
        };
        assert!(is_version_greater(&v2, &v1.latest_version), 6);
        let v3 = version_to_key(&v2);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&v1.id, v3), 3);
        let v4 = 0x2::clock::timestamp_ms(arg9);
        let v5 = 0x2::package::upgrade_package(arg2);
        let v6 = VersionEntry{
            version      : v2,
            package_id   : v5,
            published_at : v4,
            changelog    : arg7,
            git_ref      : arg8,
        };
        let v7 = VersionPublished{
            full_name    : v1.full_name,
            version      : v2,
            package_id   : v5,
            published_at : v4,
        };
        0x2::event::emit<VersionPublished>(v7);
        0x2::dynamic_field::add<vector<u8>, VersionEntry>(&mut v1.id, v3, v6);
        v1.latest_version = v2;
        v1.package_id = v5;
        v1.updated_at = v4;
        arg0.version_count = arg0.version_count + 1;
    }

    public entry fun transfer_namespace(arg0: &mut Registry, arg1: PublisherCap, arg2: address) {
        let v0 = arg1.namespace;
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&v0));
        v1.owner = arg2;
        let v2 = OwnershipTransferred{
            namespace : v0,
            from      : v1.owner,
            to        : arg2,
        };
        0x2::event::emit<OwnershipTransferred>(v2);
        0x2::transfer::transfer<PublisherCap>(arg1, arg2);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_metadata(arg0: &mut Registry, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: &0x2::clock::Clock) {
        let v0 = arg1.namespace;
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Package>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&v0)).id, *0x1::string::bytes(&arg2));
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            v1.metadata.description = 0x1::option::destroy_some<0x1::string::String>(arg3);
        };
        v1.metadata.repository = arg4;
        v1.metadata.documentation = arg5;
        v1.metadata.homepage = arg6;
        v1.metadata.license = arg7;
        v1.metadata.icon_url = arg8;
        v1.updated_at = 0x2::clock::timestamp_ms(arg9);
    }

    public entry fun update_namespace(arg0: &mut Registry, arg1: &PublisherCap, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Namespace>(&mut arg0.id, *0x1::string::bytes(&arg1.namespace));
        v0.display_name = arg2;
        v0.description = arg3;
        v0.avatar_url = arg4;
        v0.website = arg5;
    }

    public fun version_major(arg0: &Version) : u64 {
        arg0.major
    }

    public fun version_minor(arg0: &Version) : u64 {
        arg0.minor
    }

    public fun version_patch(arg0: &Version) : u64 {
        arg0.patch
    }

    fun version_to_key(arg0: &Version) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.major));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.minor));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.patch));
        v0
    }

    public fun version_to_string(arg0: &Version) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, u64_to_string(arg0.major));
        0x1::string::append_utf8(&mut v0, b".");
        0x1::string::append(&mut v0, u64_to_string(arg0.minor));
        0x1::string::append_utf8(&mut v0, b".");
        0x1::string::append(&mut v0, u64_to_string(arg0.patch));
        v0
    }

    // decompiled from Move bytecode v6
}

