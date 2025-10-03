module 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::version {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun migrate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 914);
        arg0.version = arg1;
    }

    public fun verify_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 0, 512);
    }

    // decompiled from Move bytecode v6
}

