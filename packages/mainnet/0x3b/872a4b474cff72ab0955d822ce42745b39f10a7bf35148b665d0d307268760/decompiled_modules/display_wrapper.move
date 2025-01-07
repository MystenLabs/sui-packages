module 0x3b872a4b474cff72ab0955d822ce42745b39f10a7bf35148b665d0d307268760::display_wrapper {
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

