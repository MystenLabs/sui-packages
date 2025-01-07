module 0x76f32acdf4ebcff9ce6fefa677384d940238ac5317128b3cb7886fdad5c2df7::rebalancing_counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public entry fun assert_value(arg0: &Counter, arg1: u64) : bool {
        arg0.value == arg1
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::public_transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun increment(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.value = arg0.value + 1;
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public entry fun reset(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.value = 0;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

