module 0xa322b975410bce095f6631d17db769677b291b31a03e52eaa23c9706715b7e16::counter {
    struct CountUpdateEvent has copy, drop {
        value: u64,
        owner: address,
        message: vector<u8>,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun complete_mission(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        increment(arg0, arg1);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun create_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        transfer_counter(create(arg1), arg0);
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
        let v0 = CountUpdateEvent{
            value   : arg0.value,
            owner   : 0x2::tx_context::sender(arg1),
            message : b"Mission completed!",
        };
        0x2::event::emit<CountUpdateEvent>(v0);
    }

    public fun reset(arg0: &mut Counter, arg1: &0x2::tx_context::TxContext) {
        arg0.value = 0;
        let v0 = CountUpdateEvent{
            value   : arg0.value,
            owner   : 0x2::tx_context::sender(arg1),
            message : b"Counter reset!",
        };
        0x2::event::emit<CountUpdateEvent>(v0);
    }

    public fun transfer_counter(arg0: Counter, arg1: address) {
        0x2::transfer::public_transfer<Counter>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

