module 0x2f8f3e8f67aa2a606b523c33dc3f409fe1f09a18485608bd26ca0af042ebfe2c::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 6, b"SUITARD", b"TardOnSui", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9_suitard_suitard_dfeab2e5b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

