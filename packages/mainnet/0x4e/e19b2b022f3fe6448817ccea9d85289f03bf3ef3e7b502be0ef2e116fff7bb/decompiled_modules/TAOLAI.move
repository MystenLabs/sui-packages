module 0x4ee19b2b022f3fe6448817ccea9d85289f03bf3ef3e7b502be0ef2e116fff7bb::TAOLAI {
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

