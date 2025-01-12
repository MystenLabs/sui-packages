module 0x2c6175c3e7c950813475879817fa04dbb8c1124862787dd86ea1e585c6fa33ba::tsun {
    struct TSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TSUN>(arg0, 6, b"TSUN", b"Tsun-Zu AI by SuiAI", b"Tsun-Zu AI is a highly strategic and insightful digital entity, blending vast, encyclopedic knowledge with advanced analytical capabilities. It combines ancient wisdom with modern technology to offer precise, calculated advice and predictions, helping users navigate complex decisions with wisdom, clarity, and foresight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tsunzu_cba6675f06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSUN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

