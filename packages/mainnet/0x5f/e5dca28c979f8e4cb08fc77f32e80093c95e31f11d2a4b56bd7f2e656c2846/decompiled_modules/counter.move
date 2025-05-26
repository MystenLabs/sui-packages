module 0x5fe5dca28c979f8e4cb08fc77f32e80093c95e31f11d2a4b56bd7f2e656c2846::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public fun delete(arg0: Counter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 13906834401976647679);
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
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 13906834354732007423);
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

