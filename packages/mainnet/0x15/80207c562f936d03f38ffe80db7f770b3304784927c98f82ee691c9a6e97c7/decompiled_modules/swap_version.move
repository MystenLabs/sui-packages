module 0x1580207c562f936d03f38ffe80db7f770b3304784927c98f82ee691c9a6e97c7::swap_version {
    struct SwapVersion has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun admin_freeze(arg0: &AdminCap, arg1: &mut SwapVersion) {
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapVersion{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<SwapVersion>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut SwapVersion, arg2: u64) {
        assert!(arg2 > arg1.version, 1004);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &SwapVersion) {
        assert!(1 == arg0.version, 1004);
    }

    // decompiled from Move bytecode v6
}

