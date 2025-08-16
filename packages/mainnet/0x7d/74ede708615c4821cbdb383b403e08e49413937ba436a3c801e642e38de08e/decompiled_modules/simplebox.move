module 0x7d74ede708615c4821cbdb383b403e08e49413937ba436a3c801e642e38de08e::simplebox {
    struct Box<T0: store> has store, key {
        id: 0x2::object::UID,
        value: T0,
    }

    public fun create_box<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Box<T0>{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::transfer<Box<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

