module 0x1c819131f8180604c06f0acf6448374470a1de121dd374375f3196a40c6c69::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"FLY", b"I believe I can fly", b"I believe I can fly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yd_Vpz_A_Ps_Ryw_X_Bj_YL_Lp_R_Qw_C_Svooh_F_Go_Uetcn_Jwwb_Jx_P5g_5cf4dddba6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

