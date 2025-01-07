module 0x893f8513501fdf264c2bccfc3b3d32ccfec7bf8796f9cb881a0a6a661bababc2::redguy {
    struct REDGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDGUY>(arg0, 6, b"REDGUY", b"Redguy on sui", x"6c657373206368696c6c2c206d6f7265207265642e0a0a4a6f696e207573200a54656c656772616d3a2068747470733a2f2f742e6d652f7265646775797375690a54776974746572203a2068747470733a2f2f782e636f6d2f7265646775797375690a57656273697465203a2068747470733a2f2f7265646775797375692e6d792e63616e76612e736974652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241224_072731_b06c9010c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

