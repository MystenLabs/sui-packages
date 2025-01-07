module 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_config {
    struct IncentiveConfig has key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
    }

    public fun assert_enabled(arg0: &IncentiveConfig) {
        assert!(arg0.enabled, 1);
    }

    public fun assert_version(arg0: &IncentiveConfig) {
        assert!(arg0.version == 1, 2);
    }

    public fun assert_version_and_status(arg0: &IncentiveConfig) {
        assert_enabled(arg0);
        assert_version(arg0);
    }

    public(friend) fun disable(arg0: &mut IncentiveConfig) {
        arg0.enabled = false;
    }

    public(friend) fun enable(arg0: &mut IncentiveConfig) {
        arg0.enabled = true;
    }

    public fun enabled(arg0: &IncentiveConfig) : bool {
        arg0.enabled
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IncentiveConfig{
            id      : 0x2::object::new(arg0),
            version : 1,
            enabled : true,
        };
        0x2::transfer::share_object<IncentiveConfig>(v0);
    }

    public(friend) fun upgrade_version(arg0: &mut IncentiveConfig, arg1: u64) {
        assert!(arg1 > arg0.version, 3);
        arg0.version = arg1;
    }

    public fun version(arg0: &IncentiveConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

