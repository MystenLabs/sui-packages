module 0x1466647cacb98f023357f8b1a38fc43644907d49283ed30df71bab746c359774::ppy {
    struct PPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPY>(arg0, 6, b"PPY", b"opportunitymeme", x"4f70706f7274756e6974790a4d454d45203a2050505920776173206372656174656420746f20636f6d6d656d6f726174652074686520677265617420636f6e747269627574696f6e20746f2068756d616e6974792c20616e6420746865206c6f6e656c696e65737320696e207370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994121980.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

