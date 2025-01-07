module 0x18835736313157a2d53a25102d23687ebbc5725a42bda01f6e99082770b2f65d::display_wrapper {
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

