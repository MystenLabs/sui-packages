module 0x306bd3d94790d5a375dc057ab2a0cb3d1ecefb3293bd8bc7fa65772cc3dee877::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 6, b"MILTON", b"Mr. Milton", b"Hurricane vibes, dollar signs out the window", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ump_Ck_Mu86ofs4_C_Qu_TXGLU_Gv_V_Wcf_G_Ps31_H_Mx_Cs5_Dp_Zp_Zm_c878c3cc7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

