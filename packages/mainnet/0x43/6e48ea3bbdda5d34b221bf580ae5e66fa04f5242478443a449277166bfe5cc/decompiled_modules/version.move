module 0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun admin_freeze(arg0: &0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::authority::OperatorCap, arg1: &mut Version) {
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &mut Version, arg1: &0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::authority::OperatorCap, arg2: u64) {
        assert!(arg2 > arg0.version, 1001);
        arg0.version = arg2;
    }

    public fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

