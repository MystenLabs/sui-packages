module 0xe976cd8c23a8c7618f3839fc03808164ae79f1a3e580ebbb33528b60c5c2bb0c::yolol {
    struct YOLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742251866311.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<YOLOL>(arg0, 6, b"YOLOL", b"YOLOL", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLOL>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLOL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLOL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

