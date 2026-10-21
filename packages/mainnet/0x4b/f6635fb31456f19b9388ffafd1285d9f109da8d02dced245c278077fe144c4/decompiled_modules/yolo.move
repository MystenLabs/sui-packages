module 0x4bf6635fb31456f19b9388ffafd1285d9f109da8d02dced245c278077fe144c4::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YOLO>(arg0, 6, 0x1::string::utf8(b"YOLO"), 0x1::string::utf8(b"Yolo Mascot"), 0x1::string::utf8(b"Official yolo.casa Mascot"), 0x1::string::utf8(b"https://yolo.casa/api/coin-icon/eea1a401201a7b7994345f166ea108b67df7e94cb8de6eca84350b3264a38c3c.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YOLO>>(0x2::coin_registry::finalize<YOLO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

