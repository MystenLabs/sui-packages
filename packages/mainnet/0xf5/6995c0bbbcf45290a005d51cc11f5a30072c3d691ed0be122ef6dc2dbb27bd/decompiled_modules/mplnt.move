module 0xf56995c0bbbcf45290a005d51cc11f5a30072c3d691ed0be122ef6dc2dbb27bd::mplnt {
    struct MPLNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPLNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPLNT>(arg0, 6, b"MPLNT", b"Manic Planter", x"53546159204d614e496320506c614e54696e4720536565444473730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zi_LV_9_K_Uv_Bj_FH_An5_Z_Kot43qu_Jp_Vfrh_Ca_GE_Hon_Mk4a_L_Es_D_f5d423dffb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPLNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPLNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

