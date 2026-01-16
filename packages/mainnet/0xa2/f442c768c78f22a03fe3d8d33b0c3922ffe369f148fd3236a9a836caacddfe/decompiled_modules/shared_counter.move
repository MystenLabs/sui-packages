module 0xa2f442c768c78f22a03fe3d8d33b0c3922ffe369f148fd3236a9a836caacddfe::shared_counter {
    struct CounterIncremented has copy, drop, store {
        value: u64,
        by: address,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create_counter(arg0: &mut Counter) {
        arg0.value = 0;
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public entry fun increment(arg0: &mut Counter, arg1: address) : CounterIncremented {
        arg0.value = arg0.value + 1;
        CounterIncremented{
            value : arg0.value,
            by    : arg1,
        }
    }

    public entry fun transfer_counter(arg0: Counter, arg1: address) {
        0x2::transfer::transfer<Counter>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

