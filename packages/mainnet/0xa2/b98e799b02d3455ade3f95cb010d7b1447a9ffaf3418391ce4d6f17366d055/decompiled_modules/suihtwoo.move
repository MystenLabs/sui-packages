module 0xa2b98e799b02d3455ade3f95cb010d7b1447a9ffaf3418391ce4d6f17366d055::suihtwoo {
    struct SUIHTWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHTWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHTWOO>(arg0, 6, b"Suihtwoo", b"Htwoo", b"Htwoo on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9433_6a0f6d6bd0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHTWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHTWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

