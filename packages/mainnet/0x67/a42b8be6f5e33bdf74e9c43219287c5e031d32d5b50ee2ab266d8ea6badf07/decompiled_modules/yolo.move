module 0x67a42b8be6f5e33bdf74e9c43219287c5e031d32d5b50ee2ab266d8ea6badf07::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YoLo", b"YOLO", b"I'm on Mars, with my dog and frog, venturing into the unknown with the spirit of YOLOfearless and ready for whatever comes next", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b51570dab1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

