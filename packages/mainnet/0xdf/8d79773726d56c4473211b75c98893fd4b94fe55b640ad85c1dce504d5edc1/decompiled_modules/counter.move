module 0xdf8d79773726d56c4473211b75c98893fd4b94fe55b640ad85c1dce504d5edc1::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
        last_incrementer: address,
    }

    struct Incremented has copy, drop {
        new_value: u64,
        who: address,
    }

    entry fun increment(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
        arg0.last_incrementer = 0x2::tx_context::sender(arg1);
        let v0 = Incremented{
            new_value : arg0.value,
            who       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Incremented>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id               : 0x2::object::new(arg0),
            value            : 0,
            last_incrementer : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

