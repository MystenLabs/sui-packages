module 0xe203c9551122add5c0d88f17f2a4bb043e03b79eb1aa187394262e3b815c4c0a::yolotoken {
    struct YOLOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742288790657.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<YOLOTOKEN>(arg0, 6, b"YT", b"YoloToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLOTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLOTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLOTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLOTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

