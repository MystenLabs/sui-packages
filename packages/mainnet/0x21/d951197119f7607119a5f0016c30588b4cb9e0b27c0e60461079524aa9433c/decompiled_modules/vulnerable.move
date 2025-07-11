module 0x21d951197119f7607119a5f0016c30588b4cb9e0b27c0e60461079524aa9433c::vulnerable {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun add_unchecked(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun batch_increment(arg0: &mut Counter, arg1: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            arg0.value = arg0.value + *0x1::vector::borrow<u64>(&arg1, v0);
            v0 = v0 + 1;
        };
    }

    public fun create_counter(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun decrement_counter_unchecked(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value - arg1;
    }

    public fun divide_unchecked(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun get_counter_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment_counter_unchecked(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + arg1;
    }

    public fun multiply_unchecked(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    public fun transfer_counter(arg0: Counter, arg1: address) {
        0x2::transfer::transfer<Counter>(arg0, arg1);
    }

    public fun truncate_value(arg0: u128) : u64 {
        (arg0 as u64)
    }

    public fun unsafe_access(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            return 0
        };
        arg0 * 2
    }

    // decompiled from Move bytecode v6
}

