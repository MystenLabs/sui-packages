module 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        is_open_pause: bool,
        is_close_pause: bool,
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

    struct SetGlobalOpenPauseEvent has copy, drop {
        is_open_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct SetGlobalClosePauseEvent has copy, drop {
        is_close_pause: bool,
        sender: address,
        timestamp: u64,
    }

    public(friend) fun assert_global_close_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.is_close_pause, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_global_close_paused());
    }

    public(friend) fun assert_global_open_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.is_open_pause, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_global_open_paused());
    }

    public(friend) fun assert_package_version(arg0: &GlobalConfig) {
        assert!(check_package_version(arg0), 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_wrong_version());
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
            is_open_pause   : false,
            is_close_pause  : false,
            package_version : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_global_close_paused(arg0: &GlobalConfig) : bool {
        arg0.is_close_pause
    }

    public fun is_global_open_paused(arg0: &GlobalConfig) : bool {
        arg0.is_open_pause
    }

    public fun set_global_close_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_close_pause = arg2;
        let v0 = SetGlobalClosePauseEvent{
            is_close_pause : arg2,
            sender         : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetGlobalClosePauseEvent>(v0);
    }

    public fun set_global_open_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_open_pause = arg2;
        let v0 = SetGlobalOpenPauseEvent{
            is_open_pause : arg2,
            sender        : 0x2::tx_context::sender(arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetGlobalOpenPauseEvent>(v0);
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

