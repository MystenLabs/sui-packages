module 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::counter {
    struct Counter<phantom T0> has store, key {
        id: 0x2::object::UID,
        value: u256,
    }

    public fun new<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Counter<T0>>(new_<T0>(arg0, arg1));
    }

    public fun decrement<T0>(arg0: &mut Counter<T0>, arg1: &T0) : u256 {
        arg0.value = arg0.value - 1;
        arg0.value
    }

    public fun increment<T0>(arg0: &mut Counter<T0>, arg1: &T0) : u256 {
        arg0.value = arg0.value + 1;
        arg0.value
    }

    public fun new_<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Counter<T0> {
        Counter<T0>{
            id    : 0x2::object::new(arg1),
            value : 0,
        }
    }

    // decompiled from Move bytecode v6
}

