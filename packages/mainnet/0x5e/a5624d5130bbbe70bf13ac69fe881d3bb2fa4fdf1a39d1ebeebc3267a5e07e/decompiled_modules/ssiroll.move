module 0x5ea5624d5130bbbe70bf13ac69fe881d3bb2fa4fdf1a39d1ebeebc3267a5e07e::ssiroll {
    struct SSIROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSIROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSIROLL>(arg0, 6, b"SSIROLL", b"Suishiroll", b"The Tastiest token in crypto, its a whole vibe! Fresh, fun, and packed with potential, its rolling out fast and ready to take over the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cute_meme_of_sushi_9d7f252f12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSIROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSIROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

