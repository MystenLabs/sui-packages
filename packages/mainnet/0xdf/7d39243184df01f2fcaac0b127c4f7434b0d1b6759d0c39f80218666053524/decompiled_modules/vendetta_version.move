module 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    entry fun admin_freeze(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun migrate(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1004);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1004);
    }

    // decompiled from Move bytecode v6
}

