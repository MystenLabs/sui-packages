module 0x88e93463d575e173dfbd522deac79185bbb5abb9b8a234b9a84bb64a7c4760e0::ltm {
    struct LTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTM>(arg0, 6, b"LTM", b"LATOM", b"Fire on the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid5ykmwlkuqfderswyl6hmscjiljdiaufmkpqrjrim3tcgwfuuxbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

