module 0x472ae0f1395f227bb7c0223bd92181e269c83826601a960835321e64b5f84589::mwoodeng {
    struct MWOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWOODENG>(arg0, 6, b"MWOODENG", b"mwoodeng", b"$MWOODENG is a baby hippo who was adopted by $FWOG in the trenches on his SUI journey. Pack your bags, grab some popcorn and prepare yourself for some crazy adventures to the insane peaks of the SUI jungle! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Kj_K_Aq_Lp_Fos9_Hs_S_Un2_P4x_TZE_Gnv6_Wto6ko_Rt_EHNRR_Jw_V_f3548a7900.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

