module 0xb06dbd39a80c05b3f22b462a5f2c904f3cb0034386ca30f437b6d839a63a6fe::shrippo {
    struct SHRIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIPPO>(arg0, 6, b"SHRIPPO", b"Shrippo", x"46726f6d206120736872696d7020746f206120686970706f207265616c20717569636b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qzr_D8igxunawg_Qyy_S_Bkb_Ci_Kn_E_Nn7_Nd_X_Fpyzcg_W_Rtu_Jzc_8118e7cce5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

