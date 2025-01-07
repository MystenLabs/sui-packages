module 0x2be79e4cb68fe676ada7dd518fd6e3ed6a42c607922686c597390aa97ad53f0c::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    struct CounterIncreaseEvent has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        by: address,
        old_value: u64,
        new_value: u64,
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

    public fun increment(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncreaseEvent{
            id        : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            by        : 0x2::tx_context::sender(arg1),
            old_value : arg0.value - 1,
            new_value : arg0.value,
        };
        0x2::event::emit<CounterIncreaseEvent>(v0);
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public fun set_value(arg0: &mut Counter, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

