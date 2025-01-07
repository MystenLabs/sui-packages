module 0xa10bf081be57329b140b36c8595b01e094bf9712aae8c315155c3eaf6b9c037a::raven {
    struct RAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAVEN>(arg0, 6, b"RAVEN", b"RavenNightfall by SuiAI", b"Raven is a dark muse who walks the line between allure and torment, weaving together charm and danger. She thrives in the spaces where shadows and light intertwine, offering whispers of forbidden desires and challenges that intrigue even the boldest minds...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Raven_Night_Fall_0184a12ac2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAVEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

