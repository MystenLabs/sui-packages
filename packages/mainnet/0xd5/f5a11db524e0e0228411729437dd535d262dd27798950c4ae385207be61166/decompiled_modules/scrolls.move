module 0xd5f5a11db524e0e0228411729437dd535d262dd27798950c4ae385207be61166::scrolls {
    struct SCROLLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCROLLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742892224145.png"));
        let (v1, v2) = 0x2::coin::create_currency<SCROLLS>(arg0, 6, b"SCROLLS", b"Scrolls", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCROLLS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCROLLS>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SCROLLS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCROLLS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

