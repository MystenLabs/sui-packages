module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_is_valid(arg0: &Version) {
        assert!(arg0.version == 1, 13835058179836215297);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public(friend) fun migrate(arg0: &mut Version) {
        arg0.version = 1;
    }

    // decompiled from Move bytecode v7
}

