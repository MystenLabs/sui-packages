module 0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    entry fun admin_freeze(arg0: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_role::AdminCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun migrate(arg0: &mut Version, arg1: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_role::AdminCap, arg2: u64) {
        assert!(arg2 > arg0.version, 1001);
        arg0.version = arg2;
    }

    public(friend) fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

