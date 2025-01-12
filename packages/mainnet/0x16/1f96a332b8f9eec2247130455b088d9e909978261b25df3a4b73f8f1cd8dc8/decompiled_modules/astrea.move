module 0x161f96a332b8f9eec2247130455b088d9e909978261b25df3a4b73f8f1cd8dc8::astrea {
    struct ASTREA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTREA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTREA>(arg0, 6, b"ASTREA", b"Astrea AI", b"autonomous Sui Movement engineering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NN_5_Ax_G6i_MXN_93_Nrj_Lz_D_Ehqy_H_Dx_G5_LP_6y_V_Qbt_Seg_C_Fmd7_a9cc92e90c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTREA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTREA>>(v1);
    }

    // decompiled from Move bytecode v6
}

