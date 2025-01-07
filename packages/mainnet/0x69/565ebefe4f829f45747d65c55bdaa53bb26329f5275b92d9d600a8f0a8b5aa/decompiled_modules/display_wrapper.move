module 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::display_wrapper {
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

