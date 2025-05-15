module 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Version) {
        assert!(arg0.version == 2, 13906834273127628799);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun update_version(arg0: &0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::SuperAdminCap, arg1: &mut Version) {
        assert!(arg1.version < 2, 13906834290307497983);
        arg1.version = 2;
    }

    // decompiled from Move bytecode v6
}

