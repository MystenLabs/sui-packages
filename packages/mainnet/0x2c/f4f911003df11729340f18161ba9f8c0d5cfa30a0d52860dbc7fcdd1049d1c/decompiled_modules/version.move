module 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun admin_freeze(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &mut Version, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg2: u64) {
        assert!(arg2 > arg0.version, 1001);
        arg0.version = arg2;
    }

    public fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

