module 0xabf875a7480c31998f81ef64b7a227126daa4faafdb4e3edd2d8623ff7303374::yolo_mon {
    struct YOLO_MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO_MON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742356139589.png"));
        let (v1, v2) = 0x2::coin::create_currency<YOLO_MON>(arg0, 6, b"YOLO_MON", b"YOLO_MON", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO_MON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO_MON>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLO_MON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLO_MON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

