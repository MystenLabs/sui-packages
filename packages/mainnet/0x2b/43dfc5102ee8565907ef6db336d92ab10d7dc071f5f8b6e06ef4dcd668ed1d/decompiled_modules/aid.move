module 0x2b43dfc5102ee8565907ef6db336d92ab10d7dc071f5f8b6e06ef4dcd668ed1d::aid {
    struct AID has drop {
        dummy_field: bool,
    }

    fun init(arg0: AID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AID>(arg0, 6, b"AID", b"AIDIOT", b"01010010 00100000 01110101 00100000 01100101 01111001 00100000 01100100 01101001 01101111 01110100 00100000 01000101 01101110 01101111 01110101 01100111 01101000 00111111 00111111 00100000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057445_a2844c895f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

