module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        paused: bool,
        domain_pauses: vector<DomainPause>,
    }

    struct DomainPause has copy, drop, store {
        domain: u8,
        paused: bool,
    }

    struct GlobalConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        allowed_versions: vector<u64>,
    }

    struct VersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        version: u64,
        allowed: bool,
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
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            allowed_versions : v0,
            paused           : false,
            domain_pauses    : 0x1::vector::empty<DomainPause>(),
        };
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 1);
        let v3 = GlobalConfigCreated{
            config_id        : 0x2::object::id<GlobalConfig>(&v1),
            allowed_versions : v2,
        };
        0x2::event::emit<GlobalConfigCreated>(v3);
        v1
    }

    public fun airdrop_domain() : u8 {
        5
    }

    public(friend) fun allow_version(arg0: &mut GlobalConfig, arg1: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1)) {
            0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg1);
        };
        let v0 = VersionUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg1,
            allowed   : true,
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u64> {
        0x2::vec_set::into_keys<u64>(arg0.allowed_versions)
    }

    public fun assert_current(arg0: &GlobalConfig) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 0);
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

    public(friend) fun disallow_version(arg0: &mut GlobalConfig, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg1);
        };
        let v0 = VersionUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg1,
            allowed   : false,
        };
        0x2::event::emit<VersionUpdated>(v0);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GlobalConfig>(new(arg0));
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

    public fun system_domain() : u8 {
        1
    }

    public fun token_domain() : u8 {
        4
    }

    public fun version_allowed(arg0: &GlobalConfig, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1)
    }

    // decompiled from Move bytecode v7
}

