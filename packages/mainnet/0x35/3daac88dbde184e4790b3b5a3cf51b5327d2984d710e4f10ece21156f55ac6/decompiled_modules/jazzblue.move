module 0x353daac88dbde184e4790b3b5a3cf51b5327d2984d710e4f10ece21156f55ac6::jazzblue {
    struct JAZZBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAZZBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAZZBLUE>(arg0, 6, b"JAZZBLUE", b"JAZZY", b"JAZZY the one blue eyed dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1333_1fbe2b2d94.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAZZBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAZZBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

