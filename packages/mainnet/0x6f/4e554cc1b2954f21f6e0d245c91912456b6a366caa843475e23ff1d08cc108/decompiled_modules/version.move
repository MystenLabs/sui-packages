module 0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct VAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public entry fun migrate(arg0: &VAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

