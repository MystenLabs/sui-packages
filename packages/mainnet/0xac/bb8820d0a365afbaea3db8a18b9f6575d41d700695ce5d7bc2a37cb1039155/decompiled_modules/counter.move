module 0xacbb8820d0a365afbaea3db8a18b9f6575d41d700695ce5d7bc2a37cb1039155::counter {
    struct CounterIncremented has copy, drop {
        new_value: u64,
        by: address,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
        owner: address,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
            owner : 0x2::tx_context::sender(arg0),
        }
    }

    public fun increment(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 0);
        arg0.value = arg0.value + 1;
        let v1 = CounterIncremented{
            new_value : arg0.value,
            by        : v0,
        };
        0x2::event::emit<CounterIncremented>(v1);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

