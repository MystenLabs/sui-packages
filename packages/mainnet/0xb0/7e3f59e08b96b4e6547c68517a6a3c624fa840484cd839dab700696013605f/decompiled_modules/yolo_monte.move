module 0xb07e3f59e08b96b4e6547c68517a6a3c624fa840484cd839dab700696013605f::yolo_monte {
    struct YOLO_MONTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO_MONTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742356177403.png"));
        let (v1, v2) = 0x2::coin::create_currency<YOLO_MONTE>(arg0, 6, b"YOLO_MONTE", b"YOLO_MONTE", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO_MONTE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO_MONTE>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLO_MONTE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLO_MONTE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

