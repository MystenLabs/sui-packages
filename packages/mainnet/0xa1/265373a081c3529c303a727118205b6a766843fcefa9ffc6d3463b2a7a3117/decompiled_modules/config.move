module 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        is_long_pause: bool,
        is_short_pause: bool,
        package_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UpdatePackageVersionEvent has copy, drop {
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct SetGlobalLongPauseEvent has copy, drop {
        is_long_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct SetGlobalShortPauseEvent has copy, drop {
        is_short_pause: bool,
        sender: address,
        timestamp: u64,
    }

    public(friend) fun assert_global_long_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.is_long_pause, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_global_long_paused());
    }

    public(friend) fun assert_global_short_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.is_short_pause, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_global_short_paused());
    }

    public(friend) fun assert_package_version(arg0: &GlobalConfig) {
        assert!(check_package_version(arg0), 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_wrong_version());
    }

    public fun check_package_version(arg0: &GlobalConfig) : bool {
        arg0.package_version == 1
    }

    public fun get_package_version(arg0: &GlobalConfig) : u64 {
        arg0.package_version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            is_long_pause   : false,
            is_short_pause  : false,
            package_version : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_global_long_paused(arg0: &GlobalConfig) : bool {
        arg0.is_long_pause
    }

    public fun is_global_short_paused(arg0: &GlobalConfig) : bool {
        arg0.is_short_pause
    }

    public fun set_global_long_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_long_pause = arg2;
        let v0 = SetGlobalLongPauseEvent{
            is_long_pause : arg2,
            sender        : 0x2::tx_context::sender(arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetGlobalLongPauseEvent>(v0);
    }

    public fun set_global_short_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_short_pause = arg2;
        let v0 = SetGlobalShortPauseEvent{
            is_short_pause : arg2,
            sender         : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetGlobalShortPauseEvent>(v0);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.package_version = arg2;
        let v0 = UpdatePackageVersionEvent{
            old_version : arg1.package_version,
            new_version : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdatePackageVersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

