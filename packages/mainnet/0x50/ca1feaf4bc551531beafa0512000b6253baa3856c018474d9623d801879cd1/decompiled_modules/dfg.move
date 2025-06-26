module 0x50ca1feaf4bc551531beafa0512000b6253baa3856c018474d9623d801879cd1::dfg {
    struct DFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFG>(arg0, 6, b"DFG", b"dfgdfg", b"sdvfcsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

