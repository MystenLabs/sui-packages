module 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::version {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_version(arg0: &Version) {
        assert!(arg0.value == 1, 702);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public(friend) fun set_version(arg0: &mut Version, arg1: u64) {
        assert!(arg1 > arg0.value, 701);
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

