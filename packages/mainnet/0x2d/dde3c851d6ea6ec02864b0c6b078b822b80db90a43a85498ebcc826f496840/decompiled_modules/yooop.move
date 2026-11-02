module 0x2ddde3c851d6ea6ec02864b0c6b078b822b80db90a43a85498ebcc826f496840::yooop {
    struct YOOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YOOOP>(arg0, 9, 0x1::string::utf8(b"YOOOP"), 0x1::string::utf8(b"YOOOOP"), 0x1::string::utf8(b"FSDFDSFDS"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YOOOP>>(0x2::coin_registry::finalize<YOOOP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

