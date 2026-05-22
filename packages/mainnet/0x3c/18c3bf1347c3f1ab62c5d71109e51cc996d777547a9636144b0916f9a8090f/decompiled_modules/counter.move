module 0x3c18c3bf1347c3f1ab62c5d71109e51cc996d777547a9636144b0916f9a8090f::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public fun delete(arg0: Counter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 13906834423451484159);
        let Counter {
            id    : v0,
            owner : _,
            value : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun assert_value(arg0: &Counter, arg1: u64) {
        assert!(arg0.value == arg1, 0);
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

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public fun set_value(arg0: &mut Counter, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 13906834376206843903);
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

