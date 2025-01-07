module 0x3007f50918033e7d8e4f014c85721a1953927bc55f0f7a4ab398fa5874a8cfc0::misteryoken {
    struct MISTERYOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTERYOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTERYOKEN>(arg0, 6, b"Misteryoken", b"Mistery On sui", b"Mistery on sui transcends the typical meme token. Its a captivating phenomenon that intrigues and draws you in. With its innovative and inclusive approach, this lovely ghost is redefining the landscape of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_16_12_32_c9e9baaa00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTERYOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTERYOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

