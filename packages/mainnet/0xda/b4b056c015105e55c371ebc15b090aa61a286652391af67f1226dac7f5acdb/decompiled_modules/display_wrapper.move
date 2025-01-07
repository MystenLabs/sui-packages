module 0xdab4b056c015105e55c371ebc15b090aa61a286652391af67f1226dac7f5acdb::display_wrapper {
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

