module 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 3,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun migrate(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version) {
        assert!(arg0.version == 3, 1001);
    }

    // decompiled from Move bytecode v6
}

