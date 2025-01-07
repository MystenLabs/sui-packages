module 0x38c290930e4b428360087950156a9d5e3110ff90100cdd31520b2a8195c6ef7b::hercules {
    struct HERCULES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERCULES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERCULES>(arg0, 6, b"HERCULES", b"HERCULES ON SUI", b"Half a GOD. Son of ZEUS. Started Masculinity trend back in antiquity. Did 12 labors - only 1 left - to conquer cryptomarket and show who is the only GIGACHAD here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zv_Y_Cr_Rkz_Mub1ish_U_Jd2j_LPJ_Cgk_F88_X5_WL_Qm_JU_6_SMXW_3j_096be93ecd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERCULES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERCULES>>(v1);
    }

    // decompiled from Move bytecode v6
}

