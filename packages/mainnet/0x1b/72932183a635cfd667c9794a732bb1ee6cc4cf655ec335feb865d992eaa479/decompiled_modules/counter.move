module 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter {
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

