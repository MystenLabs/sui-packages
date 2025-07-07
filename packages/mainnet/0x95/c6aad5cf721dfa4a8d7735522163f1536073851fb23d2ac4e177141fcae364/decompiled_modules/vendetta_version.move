module 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::role::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

