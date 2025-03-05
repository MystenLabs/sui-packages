module 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Version) {
        assert!(arg0.version == 1, 9223372135639023615);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun update_version(arg0: &0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::SuperAdminCap, arg1: &mut Version) {
        assert!(arg1.version < 1, 9223372152818892799);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

