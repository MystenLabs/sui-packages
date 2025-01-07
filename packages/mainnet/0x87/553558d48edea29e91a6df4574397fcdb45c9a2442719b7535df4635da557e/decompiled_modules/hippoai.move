module 0x87553558d48edea29e91a6df4574397fcdb45c9a2442719b7535df4635da557e::hippoai {
    struct HIPPOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOAI>(arg0, 6, b"HIPPOAI", b"HIPPO AI", b"Moo Deng has become an AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SBUD_6iec8_Se5_PL_3_ZDG_8_Yn_Er5a_ASA_Ba_TG_1g_Y_Wkp_Z_Cx_Cc_X_c72a941546.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

