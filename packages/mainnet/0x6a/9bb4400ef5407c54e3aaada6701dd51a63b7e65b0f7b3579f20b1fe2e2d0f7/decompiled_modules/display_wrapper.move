module 0x6a9bb4400ef5407c54e3aaada6701dd51a63b7e65b0f7b3579f20b1fe2e2d0f7::display_wrapper {
    struct DisplayWrapper<phantom T0: key> has store, key {
        id: 0x2::object::UID,
        display: 0x2::display::Display<T0>,
    }

    public fun new<T0: key>(arg0: 0x2::display::Display<T0>, arg1: &mut 0x2::tx_context::TxContext) : DisplayWrapper<T0> {
        DisplayWrapper<T0>{
            id      : 0x2::object::new(arg1),
            display : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

