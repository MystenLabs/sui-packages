module 0x27d274ce7445c669eca08b80ba32a681170a0cf8ed450000f483075dc92e1199::voyage {
    struct VOYAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOYAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOYAGE>(arg0, 6, b"VOYAGE", b"Voyager AI", x"41206a6f75726e6579207468726f7567682074686520636f736d6f730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xn_HN_8_H7_X_Hqj_Sun_G4a_Zz5_SN_Mpisrnmp4s7_TZL_Nhw_Mm_Ba4_aafeea70ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOYAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOYAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

