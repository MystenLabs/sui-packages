module 0x595f1acba58b3c82e5365d2c8eaab99d4fee7a0e04b41756395cd5824c628717::leaf {
    struct LEAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEAF>(arg0, 6, b"LEAF", b"Leaf", b"The leaf is a chorus of greens. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_082414_768_c56a89bfe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

