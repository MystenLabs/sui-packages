module 0x66d97f99533ebcfb2cd17c27c14bd291f7414edd70b60ebf40d69d63128cea28::movewif {
    struct MOVEWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEWIF>(arg0, 6, b"MOVEWIF", b"Move Pump Wif Hat", x"4d6f76652050756d702069732067657474696e6720726561647920666f722074686520636f6c642077696e74657220616e6420676f7420612062756c6c6973682048617421200a0a244d4f564557494620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_85_removebg_preview_bcebd36c82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

