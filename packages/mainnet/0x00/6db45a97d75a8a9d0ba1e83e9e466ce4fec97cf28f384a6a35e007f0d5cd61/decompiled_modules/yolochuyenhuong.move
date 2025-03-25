module 0x6db45a97d75a8a9d0ba1e83e9e466ce4fec97cf28f384a6a35e007f0d5cd61::yolochuyenhuong {
    struct YOLOCHUYENHUONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLOCHUYENHUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742895313191.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<YOLOCHUYENHUONG>(arg0, 6, b"yolo_chuyenhuong", b"yolo_chuyenhuong", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLOCHUYENHUONG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLOCHUYENHUONG>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLOCHUYENHUONG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLOCHUYENHUONG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

