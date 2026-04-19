module 0x4826b64aed8660dc80fb7913e5295107bb05212b656a7bf76eac510825e100f9::drain {
    struct Box has store, key {
        id: 0x2::object::UID,
    }

    public entry fun new_box(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Box{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Box>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun receive_and_drain(arg0: &mut Box, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

