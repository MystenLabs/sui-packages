module 0x6dceb070783852106f48591c8a826a7d407266c56ba1a51bff1f7c1b5d9ded6::jeff {
    struct JEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFF>(arg0, 6, b"JEFF", b"Jeff", b"just jeff.I'm always watching you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RZXFAH_8jy_LR_6_Pn_G_Sx_EN_Fg_Vca_ZS_3_G5_A83_Pf_Vr_GL_Qsu_A_Jb_83d6f18a69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

