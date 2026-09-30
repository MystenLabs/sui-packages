module 0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::anchor_config {
    struct Config has key {
        id: 0x2::object::UID,
        revision: u64,
        sui_pool: Entry,
        usdc_pool: Entry,
    }

    struct Entry has copy, drop, store {
        anchor: u64,
        source_version: u64,
        enabled: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct Updated has copy, drop {
        config: 0x2::object::ID,
        pool: 0x2::object::ID,
        revision: u64,
        anchor: u64,
        source_version: u64,
        enabled: bool,
    }

    public fun anchor(arg0: &Config, arg1: 0x2::object::ID) : u64 {
        let v0 = entry(arg0, arg1);
        assert!(v0.enabled, 1102);
        v0.anchor
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, AdminCap) {
        let v0 = Entry{
            anchor         : 0,
            source_version : 0,
            enabled        : false,
        };
        let v1 = Config{
            id        : 0x2::object::new(arg0),
            revision  : 0,
            sui_pool  : v0,
            usdc_pool : v0,
        };
        let v2 = AdminCap{
            id     : 0x2::object::new(arg0),
            config : 0x2::object::id<Config>(&v1),
        };
        (v1, v2)
    }

    fun entry(arg0: &Config, arg1: 0x2::object::ID) : &Entry {
        let v0 = 0x2::object::id_to_address(&arg1);
        if (v0 == @0x21167b2e981e2c0a693afcfe882a3a827d663118e19afcb92e45bfe43fe56278) {
            &arg0.sui_pool
        } else {
            assert!(v0 == @0x34fcaa553f1185e1c3a05de37b6a4d10c39535d19f9c8581eeae826434602b58, 1101);
            &arg0.usdc_pool
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0);
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun revision(arg0: &Config) : u64 {
        arg0.revision
    }

    public fun status(arg0: &Config, arg1: 0x2::object::ID) : (u64, u64, bool) {
        let v0 = entry(arg0, arg1);
        (v0.anchor, v0.source_version, v0.enabled)
    }

    public fun update(arg0: &mut Config, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 1100);
        assert!(arg6 == arg0.revision, 1103);
        let v0 = *entry(arg0, arg2);
        assert!(arg4 > 0 && arg4 >= v0.source_version, 1104);
        if (arg4 == v0.source_version) {
            assert!(arg3 == v0.anchor, 1105);
            if (arg5 == v0.enabled) {
                return
            };
        };
        let v1 = Entry{
            anchor         : arg3,
            source_version : arg4,
            enabled        : arg5,
        };
        if (0x2::object::id_to_address(&arg2) == @0x21167b2e981e2c0a693afcfe882a3a827d663118e19afcb92e45bfe43fe56278) {
            arg0.sui_pool = v1;
        } else {
            arg0.usdc_pool = v1;
        };
        arg0.revision = arg0.revision + 1;
        let v2 = Updated{
            config         : 0x2::object::id<Config>(arg0),
            pool           : arg2,
            revision       : arg0.revision,
            anchor         : arg3,
            source_version : arg4,
            enabled        : arg5,
        };
        0x2::event::emit<Updated>(v2);
    }

    // decompiled from Move bytecode v7
}

