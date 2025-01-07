module 0x7091dd59e1fb58ba148d32c70e00ea25dac5baceefe5533c1dd3d622fa12c613::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE>(arg0, 6, b"Bepe", b"Baby Pepe", b"Discover the latest sensation in the meme token universe - Baby Pepe Token! Inspired by Matt Furie's adorable tweet showcasing a cuddly baby Pepe stuffed doll, Baby Pepe Token is here to bring a playful twist to your crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YZ_Saqiiec2_EHK_5a_Yw8_T_Fhc_Qt_Qo_Caa9_J_Usw_B3_Dvt_Rz_Gz_U_cdae10f480.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

