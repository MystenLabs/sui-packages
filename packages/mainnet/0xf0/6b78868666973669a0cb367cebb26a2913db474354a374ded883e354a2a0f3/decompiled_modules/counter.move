module 0xf06b78868666973669a0cb367cebb26a2913db474354a374ded883e354a2a0f3::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
        owner: address,
    }

    struct CounterIncremented has copy, drop {
        counter_id: 0x2::object::ID,
        new_value: u64,
        by: address,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun destroy(arg0: Counter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let Counter {
            id    : v0,
            value : _,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun increment(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
            by         : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

