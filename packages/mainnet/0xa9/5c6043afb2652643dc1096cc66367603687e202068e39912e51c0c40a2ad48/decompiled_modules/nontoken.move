module 0xa95c6043afb2652643dc1096cc66367603687e202068e39912e51c0c40a2ad48::nontoken {
    struct NONTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742268558473.png"));
        let (v1, v2) = 0x2::coin::create_currency<NONTOKEN>(arg0, 6, b"NONTOKEN", b"NONTOKEN", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NONTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NONTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

