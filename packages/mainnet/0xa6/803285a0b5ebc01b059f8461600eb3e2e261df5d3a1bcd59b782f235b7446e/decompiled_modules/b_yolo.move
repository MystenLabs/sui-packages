module 0xa6803285a0b5ebc01b059f8461600eb3e2e261df5d3a1bcd59b782f235b7446e::b_yolo {
    struct B_YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_YOLO>(arg0, 9, b"bYOLO", b"bToken YOLO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

