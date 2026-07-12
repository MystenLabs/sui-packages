module 0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site {
    struct Site has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        quilt_id: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_hash: vector<u8>,
        quilt_blob_object: 0x2::object::ID,
        manifest_blob_object: 0x2::object::ID,
        version: u64,
        size_bytes: u64,
        file_count: u64,
        paid_until_ms: u64,
        sealed: bool,
    }

    struct SiteAdminCap has store, key {
        id: 0x2::object::UID,
        site_id: 0x2::object::ID,
    }

    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SiteDigestRegistry has key {
        id: 0x2::object::UID,
        used: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct SiteCreated has copy, drop {
        site_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        size_bytes: u64,
        file_count: u64,
        paid_until_ms: u64,
        sealed: bool,
    }

    struct SiteExtended has copy, drop {
        site_id: 0x2::object::ID,
        paid_until_ms: u64,
    }

    public fun cap_site_id(arg0: &SiteAdminCap) : 0x2::object::ID {
        arg0.site_id
    }

    public fun create_site(arg0: &DeployerCap, arg1: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg2: &mut SiteDigestRegistry, arg3: vector<u8>, arg4: 0x1::string::String, arg5: address, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) : SiteAdminCap {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg1);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg2.used, arg3), 0);
        let v0 = Site{
            id                   : 0x2::object::new(arg15),
            owner                : arg5,
            name                 : arg4,
            quilt_id             : arg6,
            manifest_blob_id     : arg7,
            manifest_hash        : arg8,
            quilt_blob_object    : arg9,
            manifest_blob_object : arg10,
            version              : 1,
            size_bytes           : arg11,
            file_count           : arg12,
            paid_until_ms        : arg13,
            sealed               : arg14,
        };
        let v1 = 0x2::object::id<Site>(&v0);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg2.used, arg3, v1);
        let v2 = SiteCreated{
            site_id       : v1,
            owner         : arg5,
            name          : v0.name,
            size_bytes    : arg11,
            file_count    : arg12,
            paid_until_ms : arg13,
            sealed        : arg14,
        };
        0x2::event::emit<SiteCreated>(v2);
        0x2::transfer::share_object<Site>(v0);
        SiteAdminCap{
            id      : 0x2::object::new(arg15),
            site_id : v1,
        }
    }

    public fun version(arg0: &Site) : u64 {
        arg0.version
    }

    public fun digest_used(arg0: &SiteDigestRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.used, arg1)
    }

    public fun extend_site(arg0: &DeployerCap, arg1: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg2: &mut SiteDigestRegistry, arg3: vector<u8>, arg4: &mut Site, arg5: &0x2::clock::Clock, arg6: u64) {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg1);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg2.used, arg3), 0);
        assert!(arg6 > 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (arg4.paid_until_ms > v0) {
            arg4.paid_until_ms
        } else {
            v0
        };
        let v2 = v1 + arg6;
        let v3 = 0x2::object::id<Site>(arg4);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg2.used, arg3, v3);
        arg4.paid_until_ms = v2;
        let v4 = SiteExtended{
            site_id       : v3,
            paid_until_ms : v2,
        };
        0x2::event::emit<SiteExtended>(v4);
    }

    public fun file_count(arg0: &Site) : u64 {
        arg0.file_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SiteDigestRegistry{
            id   : 0x2::object::new(arg0),
            used : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SiteDigestRegistry>(v0);
        let v1 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun manifest_blob_id(arg0: &Site) : 0x1::string::String {
        arg0.manifest_blob_id
    }

    public fun manifest_blob_object(arg0: &Site) : 0x2::object::ID {
        arg0.manifest_blob_object
    }

    public fun manifest_hash(arg0: &Site) : vector<u8> {
        arg0.manifest_hash
    }

    public fun name(arg0: &Site) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Site) : address {
        arg0.owner
    }

    public fun paid_until_ms(arg0: &Site) : u64 {
        arg0.paid_until_ms
    }

    public fun quilt_blob_object(arg0: &Site) : 0x2::object::ID {
        arg0.quilt_blob_object
    }

    public fun quilt_id(arg0: &Site) : 0x1::string::String {
        arg0.quilt_id
    }

    public fun sealed(arg0: &Site) : bool {
        arg0.sealed
    }

    public fun site_for_digest(arg0: &SiteDigestRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.used, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.used, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun size_bytes(arg0: &Site) : u64 {
        arg0.size_bytes
    }

    // decompiled from Move bytecode v7
}

