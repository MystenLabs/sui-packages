module 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_config {
    struct SpoolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
    }

    public fun assert_enabled(arg0: &SpoolConfig) {
        assert!(arg0.enabled, 1);
    }

    public fun assert_version(arg0: &SpoolConfig) {
        assert!(arg0.version == 0, 2);
    }

    public fun assert_version_and_status(arg0: &SpoolConfig) {
        assert_enabled(arg0);
        assert_version(arg0);
    }

    public(friend) fun disable(arg0: &mut SpoolConfig) {
        arg0.enabled = false;
    }

    public(friend) fun enable(arg0: &mut SpoolConfig) {
        arg0.enabled = true;
    }

    public fun enabled(arg0: &SpoolConfig) : bool {
        arg0.enabled
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpoolConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            enabled : true,
        };
        0x2::transfer::share_object<SpoolConfig>(v0);
    }

    public(friend) fun upgrade_version(arg0: &mut SpoolConfig, arg1: u64) {
        assert!(arg1 > arg0.version, 3);
        arg0.version = arg1;
    }

    public fun version(arg0: &SpoolConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

