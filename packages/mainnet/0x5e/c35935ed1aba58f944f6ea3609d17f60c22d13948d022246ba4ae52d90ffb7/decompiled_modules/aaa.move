module 0x5ec35935ed1aba58f944f6ea3609d17f60c22d13948d022246ba4ae52d90ffb7::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"AAA", b"The Anthropic AI Alliance", b"AAA - The Anthropic AI Alliance on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNe2hiD4K2s1HCSDaXxsbvA5vW99MXxDSphPhN4WZbWTh")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

