module 0x69987b9b7d0aa32d4d057b782a076fc206e8784d7244f35c3ec8f5c808b93e34::counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct CounterIncremented has copy, drop {
        counter_id: 0x2::object::ID,
        old_value: u64,
        new_value: u64,
    }

    struct CounterDecremented has copy, drop {
        counter_id: 0x2::object::ID,
        old_value: u64,
        new_value: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_with_value(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun decrement(arg0: &mut Counter) {
        assert!(arg0.value > 0, 0);
        arg0.value = arg0.value - 1;
        let v0 = CounterDecremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            old_value  : arg0.value,
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterDecremented>(v0);
    }

    public entry fun destroy(arg0: Counter) {
        let Counter {
            id    : v0,
            value : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            old_value  : arg0.value,
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public entry fun increment_by(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + arg1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            old_value  : arg0.value,
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public entry fun reset(arg0: &mut Counter) {
        arg0.value = 0;
    }

    public entry fun set_value(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

