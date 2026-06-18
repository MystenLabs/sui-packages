module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        domain_pauses: vector<DomainPause>,
    }

    struct DomainPause has copy, drop, store {
        domain: u8,
        paused: bool,
    }

    struct GlobalConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct GlobalPauseUpdated has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct DomainPauseUpdated has copy, drop {
        config_id: 0x2::object::ID,
        domain: u8,
        paused: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : GlobalConfig {
        let v0 = GlobalConfig{
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            domain_pauses : 0x1::vector::empty<DomainPause>(),
        };
        let v1 = GlobalConfigCreated{
            config_id : 0x2::object::id<GlobalConfig>(&v0),
            version   : 1,
        };
        0x2::event::emit<GlobalConfigCreated>(v1);
        v0
    }

    public fun airdrop_domain() : u8 {
        5
    }

    public fun assert_current(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
    }

    public fun assert_domain_enabled(arg0: &GlobalConfig, arg1: u8) {
        assert_current(arg0);
        assert!(arg1 > 0, 3);
        assert!(!domain_paused(arg0, arg1), 2);
    }

    public fun current_version() : u64 {
        1
    }

    public fun domain_paused(arg0: &GlobalConfig, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPause>(&arg0.domain_pauses)) {
            let v1 = 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v0);
            if (v1.domain == arg1) {
                return v1.paused
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun orderbook_domain() : u8 {
        6
    }

    public fun paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun router_domain() : u8 {
        3
    }

    public fun scoreboard_domain() : u8 {
        2
    }

    public(friend) fun set_domain_paused(arg0: &mut GlobalConfig, arg1: u8, arg2: bool) {
        assert!(arg1 > 0, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPause>(&arg0.domain_pauses)) {
            let v1 = 0x1::vector::borrow_mut<DomainPause>(&mut arg0.domain_pauses, v0);
            if (v1.domain == arg1) {
                v1.paused = arg2;
                let v2 = DomainPauseUpdated{
                    config_id : 0x2::object::id<GlobalConfig>(arg0),
                    domain    : arg1,
                    paused    : arg2,
                };
                0x2::event::emit<DomainPauseUpdated>(v2);
                return
            };
            v0 = v0 + 1;
        };
        let v3 = DomainPause{
            domain : arg1,
            paused : arg2,
        };
        0x1::vector::push_back<DomainPause>(&mut arg0.domain_pauses, v3);
        let v4 = DomainPauseUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            domain    : arg1,
            paused    : arg2,
        };
        0x2::event::emit<DomainPauseUpdated>(v4);
    }

    public(friend) fun set_global_paused(arg0: &mut GlobalConfig, arg1: bool) {
        arg0.paused = arg1;
        let v0 = GlobalPauseUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            paused    : arg1,
        };
        0x2::event::emit<GlobalPauseUpdated>(v0);
    }

    public(friend) fun set_version(arg0: &mut GlobalConfig, arg1: u64) {
        arg0.version = arg1;
        let v0 = VersionUpdated{
            config_id   : 0x2::object::id<GlobalConfig>(arg0),
            old_version : arg0.version,
            new_version : arg1,
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public fun system_domain() : u8 {
        1
    }

    public fun token_domain() : u8 {
        4
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

