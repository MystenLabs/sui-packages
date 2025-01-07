module 0x236d8197f2256e9b377d616f06c5e79e292c95adbe17b33b339af6ba0262f935::hedgehog {
    struct HEDGEHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDGEHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDGEHOG>(arg0, 6, b"HEDGEHOG", b"Hedgehog", b"HEDGEHOG is ready for an adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sz_XH_Fdt_Y_Hp8_L_Dc_HU_3_D_Bneyni_Lu2y_Uod29_A_Zq_WW_Ethh1m_ea758559fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDGEHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEDGEHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

