module 0x3b26c57e5be17a5aaa10465348db6daa97c4bce0f59d6f0860522d272813e224::TAOLAI3 {
    struct TAOLAI3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOLAI3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741063897976.png"));
        let (v1, v2) = 0x2::coin::create_currency<TAOLAI3>(arg0, 6, b"abc", b"taolai3", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOLAI3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOLAI3>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TAOLAI3>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAOLAI3>>(arg0);
    }

    // decompiled from Move bytecode v6
}

