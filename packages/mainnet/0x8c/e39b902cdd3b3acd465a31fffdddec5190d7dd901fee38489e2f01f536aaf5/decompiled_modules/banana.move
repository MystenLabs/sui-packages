module 0x8ce39b902cdd3b3acd465a31fffdddec5190d7dd901fee38489e2f01f536aaf5::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"BANANA", b"BANANA SUI", x"46656564696e672074686520576f726c6420776974682074686520506f776572206f66204d454d45530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S3_Et_Qz_P3e_Cgz_QH_Lm_TX_Dj_T_Wk8_PV_5_Xekq_Wa_ZSX_7_R5_P_Akd5_e3e6a1509a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

