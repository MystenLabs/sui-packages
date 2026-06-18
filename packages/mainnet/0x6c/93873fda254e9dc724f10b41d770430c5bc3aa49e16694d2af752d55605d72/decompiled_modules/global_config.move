module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        global_paused: bool,
        domain_pauses: vector<DomainPause>,
    }

    struct DomainPause has copy, drop, store {
        domain: vector<u8>,
        target: 0x2::object::ID,
        has_target: bool,
        paused: bool,
    }

    struct GlobalConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        allowed_versions: vector<u64>,
    }

    struct GlobalConfigVersionUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        version: u64,
        allowed: bool,
    }

    struct GlobalPauseUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct DomainPauseUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        domain: vector<u8>,
        target: 0x1::option::Option<0x2::object::ID>,
        paused: bool,
    }

    public fun id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<GlobalConfig>(arg0)
    }

    public fun allow_version_by_admin(arg0: &mut GlobalConfig, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
        };
        let v0 = GlobalConfigVersionUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg2,
            allowed   : true,
        };
        0x2::event::emit<GlobalConfigVersionUpdatedEvent>(v0);
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u64> {
        0x2::vec_set::into_keys<u64>(arg0.allowed_versions)
    }

    public fun assert_current(arg0: &GlobalConfig) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 3300);
        assert!(!arg0.global_paused, 3301);
    }

    public fun assert_domain_active(arg0: &GlobalConfig, arg1: vector<u8>, arg2: u64) {
        assert_current(arg0);
        assert!(!domain_paused(arg0, arg1), arg2);
    }

    public fun assert_orderbook_active(arg0: &GlobalConfig, arg1: 0x2::object::ID) {
        assert_current(arg0);
        assert!(!paused(arg0, b"orderbook", arg1), 3304);
    }

    public fun assert_pool_active(arg0: &GlobalConfig, arg1: 0x2::object::ID) {
        assert_current(arg0);
        assert!(!paused(arg0, b"pool", arg1), 3302);
    }

    public fun assert_py_state_active(arg0: &GlobalConfig, arg1: 0x2::object::ID) {
        assert_current(arg0);
        assert!(!paused(arg0, b"py_state", arg1), 3303);
    }

    public fun assert_target_active(arg0: &GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64) {
        assert_current(arg0);
        assert!(!paused(arg0, arg1, arg2), arg3);
    }

    public fun current_version() : u64 {
        1
    }

    public fun disallow_version_by_admin(arg0: &mut GlobalConfig, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
        };
        let v0 = GlobalConfigVersionUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg2,
            allowed   : false,
        };
        0x2::event::emit<GlobalConfigVersionUpdatedEvent>(v0);
    }

    public fun domain_paused(arg0: &GlobalConfig, arg1: vector<u8>) : bool {
        let (v0, v1) = find_pause(arg0, &arg1, none_id(), false);
        if (!v0) {
            return false
        };
        0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v1).paused
    }

    fun find_pause(arg0: &GlobalConfig, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: bool) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPause>(&arg0.domain_pauses)) {
            let v1 = 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v0);
            let v2 = if (&v1.domain == arg1) {
                if (v1.has_target == arg3) {
                    !arg3 || v1.target == arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun global_paused(arg0: &GlobalConfig) : bool {
        arg0.global_paused
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GlobalConfig>(new_config(arg0));
    }

    fun new_config(arg0: &mut 0x2::tx_context::TxContext) : GlobalConfig {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            allowed_versions : v0,
            global_paused    : false,
            domain_pauses    : 0x1::vector::empty<DomainPause>(),
        };
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 1);
        let v3 = GlobalConfigCreatedEvent{
            config_id        : 0x2::object::id<GlobalConfig>(&v1),
            allowed_versions : v2,
        };
        0x2::event::emit<GlobalConfigCreatedEvent>(v3);
        v1
    }

    fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun orderbook_paused(arg0: &GlobalConfig) : bool {
        domain_paused(arg0, b"orderbook")
    }

    public fun paused(arg0: &GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        domain_paused(arg0, arg1) || target_paused(arg0, arg1, arg2)
    }

    public fun pool_paused(arg0: &GlobalConfig) : bool {
        domain_paused(arg0, b"pool")
    }

    public fun py_state_paused(arg0: &GlobalConfig) : bool {
        domain_paused(arg0, b"py_state")
    }

    fun set_domain_pause(arg0: &mut GlobalConfig, arg1: vector<u8>, arg2: bool) {
        set_pause(arg0, arg1, none_id(), false, arg2);
    }

    public fun set_domain_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg2: vector<u8>, arg3: bool) {
        set_domain_pause(arg0, arg2, arg3);
    }

    public fun set_global_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg2: bool) {
        arg0.global_paused = arg2;
        let v0 = GlobalPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<GlobalPauseUpdatedEvent>(v0);
    }

    fun set_pause(arg0: &mut GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: bool, arg4: bool) {
        let (v0, v1) = find_pause(arg0, &arg1, arg2, arg3);
        if (v0) {
            0x1::vector::borrow_mut<DomainPause>(&mut arg0.domain_pauses, v1).paused = arg4;
        } else {
            let v2 = DomainPause{
                domain     : arg1,
                target     : arg2,
                has_target : arg3,
                paused     : arg4,
            };
            0x1::vector::push_back<DomainPause>(&mut arg0.domain_pauses, v2);
        };
        let v3 = if (arg3) {
            0x1::option::some<0x2::object::ID>(arg2)
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v4 = DomainPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            domain    : arg1,
            target    : v3,
            paused    : arg4,
        };
        0x2::event::emit<DomainPauseUpdatedEvent>(v4);
    }

    fun set_target_pause(arg0: &mut GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: bool) {
        set_pause(arg0, arg1, arg2, true, arg3);
    }

    public fun set_target_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: bool) {
        set_target_pause(arg0, arg2, arg3, arg4);
    }

    public fun target_paused(arg0: &GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        let (v0, v1) = find_pause(arg0, &arg1, arg2, true);
        if (!v0) {
            return false
        };
        0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v1).paused
    }

    public fun version_allowed(arg0: &GlobalConfig, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1)
    }

    // decompiled from Move bytecode v7
}

