module 0xadb6ad661e0ba4327bd42c9079da96fc41989e93ab0914649c9d8102d1032669::immutable_counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct CounterIncremented has copy, drop {
        counter_id: 0x2::object::ID,
        new_value: u64,
    }

    struct CounterChanged has copy, drop {
        counter_id: 0x2::object::ID,
        new_value: u64,
        amount: u64,
    }

    public fun change_by(arg0: &mut Counter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.value = arg0.value + arg1;
        let v0 = CounterChanged{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
            amount     : arg1,
        };
        0x2::event::emit<CounterChanged>(v0);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun increment(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

