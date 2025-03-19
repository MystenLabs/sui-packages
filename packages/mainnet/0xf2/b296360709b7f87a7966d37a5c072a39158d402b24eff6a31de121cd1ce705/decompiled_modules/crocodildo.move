module 0xf2b296360709b7f87a7966d37a5c072a39158d402b24eff6a31de121cd1ce705::crocodildo {
    struct CROCODILDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCODILDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742379446176.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<CROCODILDO>(arg0, 6, b"Crocodildo", b"Crocodildo", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCODILDO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCODILDO>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CROCODILDO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CROCODILDO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

