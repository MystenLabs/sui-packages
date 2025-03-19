module 0xc9846d3b5b9e3cf1713482f83571bc213a47f5f6de37d00b889b0f8ca876eef6::cointes {
    struct COINTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINTES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742356042540.jfif"));
        let (v1, v2) = 0x2::coin::create_currency<COINTES>(arg0, 6, b"COINTES", b"COINTES", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINTES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COINTES>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<COINTES>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COINTES>>(arg0);
    }

    // decompiled from Move bytecode v6
}

