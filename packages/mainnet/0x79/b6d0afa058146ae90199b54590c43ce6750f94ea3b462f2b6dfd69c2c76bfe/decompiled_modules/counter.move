module 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::counter {
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

