module 0x74eb94f8b09487d24f92643a43e216bdfa6b3f705cd91226a01e44f16e61a26a::ghb {
    struct GHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GHB>(arg0, 6, b"GHB", b"GoodHEAT BOT by SuiAI", b"An ai agent for the clothing company Good Heat that generates leads and engages the community to create user content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1548_7cf7a9238a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GHB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

