module 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version {
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

    public fun migrate(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version) {
        assert!(arg0.version == 1, 1001);
    }

    // decompiled from Move bytecode v6
}

