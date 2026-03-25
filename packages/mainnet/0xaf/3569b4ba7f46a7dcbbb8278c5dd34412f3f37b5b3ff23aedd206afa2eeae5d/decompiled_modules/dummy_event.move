module 0xaf3569b4ba7f46a7dcbbb8278c5dd34412f3f37b5b3ff23aedd206afa2eeae5d::dummy_event {
    struct Dummy has copy, drop {
        u8_field: u8,
        u64_field: u64,
        address_field: address,
    }

    entry fun emit(arg0: &0x2::tx_context::TxContext) {
        let v0 = Dummy{
            u8_field      : 1,
            u64_field     : 2,
            address_field : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<Dummy>(v0);
    }

    // decompiled from Move bytecode v6
}

