module 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::counter {
    struct Counter<phantom T0> has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Counter<T0> {
        Counter<T0>{
            id    : 0x2::object::new(arg0),
            count : 1,
        }
    }

    public fun get_count<T0>(arg0: &Counter<T0>) : u64 {
        arg0.count
    }

    public(friend) fun increment<T0>(arg0: &mut Counter<T0>) {
        arg0.count = arg0.count + 1;
    }

    // decompiled from Move bytecode v6
}

