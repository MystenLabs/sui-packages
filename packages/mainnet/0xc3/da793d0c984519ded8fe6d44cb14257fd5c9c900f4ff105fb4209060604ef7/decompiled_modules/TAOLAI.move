module 0xc3da793d0c984519ded8fe6d44cb14257fd5c9c900f4ff105fb4209060604ef7::TAOLAI {
    struct TAOLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741063897976.png"));
        let (v1, v2) = 0x2::coin::create_currency<TAOLAI>(arg0, 6, b"abc", b"taolai", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOLAI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOLAI>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TAOLAI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAOLAI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

