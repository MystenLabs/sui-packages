module 0x4e4e4e6f0f4c6d1ab23ef3e8846ac10e1f2849bed48c27109e026713ea2c11fa::bluedeng {
    struct BLUEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDENG>(arg0, 6, b"BLUEDENG", b"BLUEDENG SUI", b"BLUEDENG Official ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VXS_Jv6s_Qac5z4iii_T9_Cudt_Bz_CW_Jrec_J8s_Z_Foj4_S_Hrcoc_1_8274748575.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

