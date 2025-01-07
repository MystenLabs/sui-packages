module 0x13d2bfd2a13e9540f763d2094bb233377228a620af29c42e0715f7159ce3ed6c::mrug {
    struct MRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRUG>(arg0, 6, b"MRUG", b"Meow Rug", x"244d5255472077696c6c206769766520796f75206120484541444143484520616e642077697368696e6720796f7520776f6e277420617065206d65210a4a6f696e20746f20757320616e64206c6574277320616c6c20676574204d454f5752554747212120574542534954453a6d656f777275672e66756e2054473a0a742e6d652f4d656f77527567506f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0390_5b31264d67.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

