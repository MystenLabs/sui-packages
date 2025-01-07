module 0x27546ec091aa0cb1fcbdf7dcac6bc91001ac30dddc6d7a92a87336d20207ac0f::sdy {
    struct SDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDY>(arg0, 6, b"SDY", b"SUIDY", b"SUIDY ON SUI IS KING OF MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CN_2_Sh_R_Sbmow_GKYP_4ww8_L_Dxx2g_Hi_GCAS_Ne_Ww_M_Vx_Vpump_054d0b3b5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

