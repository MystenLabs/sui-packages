module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version {
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

    entry fun migrate(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version) {
        assert!(arg0.version == 3, 1001);
    }

    // decompiled from Move bytecode v6
}

