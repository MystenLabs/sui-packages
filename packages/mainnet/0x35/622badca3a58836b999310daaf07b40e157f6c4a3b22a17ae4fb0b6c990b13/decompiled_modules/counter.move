module 0x35622badca3a58836b999310daaf07b40e157f6c4a3b22a17ae4fb0b6c990b13::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u128,
        fib_value: u128,
    }

    public fun assert_value(arg0: &Counter, arg1: u128) {
        assert!(arg0.value == arg1, 0);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            value     : 0,
            fib_value : 1,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun fib(arg0: u128) : u128 {
        if (arg0 < 2) {
            1
        } else {
            fib(arg0 - 1) + fib(arg0 - 2)
        }
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
        arg0.fib_value = fib(arg0.value);
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public fun set_value(arg0: &mut Counter, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u128 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

