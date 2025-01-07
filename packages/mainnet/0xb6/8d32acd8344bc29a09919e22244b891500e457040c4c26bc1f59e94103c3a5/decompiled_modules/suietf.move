module 0xb68d32acd8344bc29a09919e22244b891500e457040c4c26bc1f59e94103c3a5::suietf {
    struct SUIETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIETF>(arg0, 6, b"SUIETF", b"SUICHAINETF", b"This is a high-quality token growth ETF based on the Sui chain, utilizing quantitative tools for trading operations to achieve sustainable returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3736_51cf5273a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

