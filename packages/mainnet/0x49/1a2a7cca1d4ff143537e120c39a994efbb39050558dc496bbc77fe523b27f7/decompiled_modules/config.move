module 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_paused: bool,
    }

    public fun bump_version(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::acl::AclRegistry, arg2: &mut GlobalConfig) {
        assert!(0x2::tx_context::sender(arg0) == 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::acl::get_admin(arg1), 1);
        assert!(arg2.version < get_latest_version(), 1);
        arg2.version = get_latest_version();
    }

    public fun check_is_paused(arg0: &GlobalConfig) {
        assert!(!arg0.is_paused, 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_paused());
    }

    public fun check_version(arg0: &GlobalConfig) {
        assert!(arg0.version == get_latest_version(), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_version());
    }

    public fun get_is_paused(arg0: &GlobalConfig) : bool {
        arg0.is_paused
    }

    public fun get_latest_version() : u64 {
        1
    }

    public fun get_version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id        : 0x2::object::new(arg0),
            version   : 1,
            is_paused : false,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun set_is_paused(arg0: &mut GlobalConfig, arg1: &0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::acl::AclRegistry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::acl::get_admin(arg1), 1);
        arg0.is_paused = arg2;
    }

    // decompiled from Move bytecode v6
}

