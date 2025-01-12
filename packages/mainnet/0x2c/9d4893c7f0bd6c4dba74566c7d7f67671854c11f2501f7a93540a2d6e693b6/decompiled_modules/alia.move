module 0x2c9d4893c7f0bd6c4dba74566c7d7f67671854c11f2501f7a93540a2d6e693b6::alia {
    struct ALIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIA>(arg0, 6, b"ALIA", b"AlienAI on Sui", b"\"Alien AI: Sui Platform, the future of NFTs and DeFi.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_1204_x_1204_px_1204_x_1204_px_1204_x_850_px_1215_x_1215_px_1230_x_1215_px_1230_x_1000_px_1230_x_1000_px_1250_x_1000_px_1300_x_1000_px_1350_x_1000_px_23_5cf2a5e966.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

