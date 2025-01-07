module 0x18d2ae3447048e21666a5c119c231f7df0a23398a9251d30d4ff151cf8130d1c::suidoodlr {
    struct SUIDOODLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOODLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOODLR>(arg0, 6, b"SUIDOODLR", b"Doodlr", x"446f6f646c72206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P6up_J_Lxa_CK_Vvh_X2o_Ktd_HF_Ru_U_Ef_W_Sm_ZWAEG_Ky_KWR_Ga_Y_Aq_f4cddd1b62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOODLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOODLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

