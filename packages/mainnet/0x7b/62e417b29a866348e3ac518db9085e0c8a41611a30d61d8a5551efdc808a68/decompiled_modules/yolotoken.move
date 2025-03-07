module 0x7b62e417b29a866348e3ac518db9085e0c8a41611a30d61d8a5551efdc808a68::yolotoken {
    struct YOLOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741344318413.webp"));
        let (v1, v2) = 0x2::coin::create_currency<YOLOTOKEN>(arg0, 6, b"YT", b"YoloToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLOTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLOTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLOTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLOTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

