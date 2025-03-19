module 0xed28c8f032689548e32e07a1a97b6fed0f74f1dfb6402257728f5a902d0579fd::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742380273773.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"GROK", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<GROK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GROK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

