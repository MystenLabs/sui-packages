module 0x2f43887f87113c9dfbb38fef21e3afb7f1c8605047309ce6fb404295bb7c8530::TAOLAI2 {
    struct TAOLAI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOLAI2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741063897976.png"));
        let (v1, v2) = 0x2::coin::create_currency<TAOLAI2>(arg0, 6, b"abc", b"taolai2", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOLAI2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOLAI2>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TAOLAI2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAOLAI2>>(arg0);
    }

    // decompiled from Move bytecode v6
}

