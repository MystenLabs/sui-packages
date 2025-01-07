module 0x41130bec148d94396f2e33c8deea4d921e85d4d0b8695c26747335983cf96a23::dogle {
    struct DOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLE>(arg0, 6, b"DOGLE", b"Dogle", b"Dogle is a memecoin designed to bring fun and community power to the world of cryptocurrency. With a meme-based concept, Dogle focuses on building an active community through social interaction and digital influence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241205_201357_71b4d4be92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

