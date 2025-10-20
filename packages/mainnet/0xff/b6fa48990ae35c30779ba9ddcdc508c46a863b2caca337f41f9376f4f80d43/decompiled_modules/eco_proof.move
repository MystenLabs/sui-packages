module 0xffb6fa48990ae35c30779ba9ddcdc508c46a863b2caca337f41f9376f4f80d43::eco_proof {
    struct SimpleItem has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun mint_simple(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleItem{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::public_transfer<SimpleItem>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

