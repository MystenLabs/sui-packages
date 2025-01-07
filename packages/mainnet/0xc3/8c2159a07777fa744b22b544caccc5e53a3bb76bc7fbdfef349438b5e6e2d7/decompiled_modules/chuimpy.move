module 0xc38c2159a07777fa744b22b544caccc5e53a3bb76bc7fbdfef349438b5e6e2d7::chuimpy {
    struct CHUIMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUIMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUIMPY>(arg0, 6, b"Chuimpy", b"Chuimpy Turtle", b"Chuimpy Chuimpy Chuimpy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_5_e249c43d0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUIMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUIMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

