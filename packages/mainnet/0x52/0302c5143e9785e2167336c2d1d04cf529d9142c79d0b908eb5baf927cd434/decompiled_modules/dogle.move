module 0x520302c5143e9785e2167336c2d1d04cf529d9142c79d0b908eb5baf927cd434::dogle {
    struct DOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLE>(arg0, 6, b"DOGLE", b"Dogle", b"Dogle is a memecoin designed to bring fun and community power to the world of cryptocurrency. With a meme-based concept, Dogle focuses on building an active community through social interaction and digital influence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733422439532.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

