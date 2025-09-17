module 0x4206c25ab7d1afaf9b789c89ae68ade13ba7d0dd9c9982b23452bd375c69109b::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VAdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<VAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public fun migrate(arg0: &VAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    // decompiled from Move bytecode v6
}

