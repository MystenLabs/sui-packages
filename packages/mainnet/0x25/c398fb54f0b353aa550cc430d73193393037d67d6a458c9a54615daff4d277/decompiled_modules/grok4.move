module 0x25c398fb54f0b353aa550cc430d73193393037d67d6a458c9a54615daff4d277::grok4 {
    struct GROK4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742381190139.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<GROK4>(arg0, 6, b"GROK-4", b"GROK-4", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK4>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<GROK4>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GROK4>>(arg0);
    }

    // decompiled from Move bytecode v6
}

