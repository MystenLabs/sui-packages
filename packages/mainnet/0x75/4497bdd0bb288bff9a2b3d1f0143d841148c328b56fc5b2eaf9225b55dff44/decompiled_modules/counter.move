module 0x754497bdd0bb288bff9a2b3d1f0143d841148c328b56fc5b2eaf9225b55dff44::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun set_value(arg0: &mut Counter, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

