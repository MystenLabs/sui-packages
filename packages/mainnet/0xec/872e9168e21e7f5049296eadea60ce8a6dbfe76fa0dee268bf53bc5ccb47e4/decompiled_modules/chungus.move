module 0xec872e9168e21e7f5049296eadea60ce8a6dbfe76fa0dee268bf53bc5ccb47e4::chungus {
    struct CHUNGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNGUS>(arg0, 6, b"CHUNGUS", b"Chungus Token", b"Big Chungus. Spoopy Chungus. Bullish narrative for Halloween. First Chungus on Sui. Sendor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_ED_3_CA_1_E_7_CC_1_40_FB_A660_E5_F13604_F0_C8_dc1e3d5ee7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

