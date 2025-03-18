module 0xcb4102178d2bab2dc066b80d77b15aa80f676351cdec8a682b0bcaa72404f194::tokenbyxu {
    struct TOKENBYXU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENBYXU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742271010990.png"));
        let (v1, v2) = 0x2::coin::create_currency<TOKENBYXU>(arg0, 6, b"TOKENBYXU", b"TOKENBYXU", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENBYXU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKENBYXU>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TOKENBYXU>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKENBYXU>>(arg0);
    }

    // decompiled from Move bytecode v6
}

