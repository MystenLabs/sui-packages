module 0x7be92c3e56a229ef8c35baa0c198d72d68b1868438187629632c2384bbfac9f8::ABC {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741061874869.png"));
        let (v1, v2) = 0x2::coin::create_currency<ABC>(arg0, 6, b"abc123", b"abc", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABC>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ABC>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ABC>>(arg0);
    }

    // decompiled from Move bytecode v6
}

