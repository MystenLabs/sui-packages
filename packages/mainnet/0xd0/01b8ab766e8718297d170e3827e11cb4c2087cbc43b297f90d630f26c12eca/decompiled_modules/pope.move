module 0xd001b8ab766e8718297d170e3827e11cb4c2087cbc43b297f90d630f26c12eca::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"POPE DONALD", b"267th Pope. Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ry_Q_Pgywz_M2rb8_Nwn83_N_Xb_QWV_Ai_Y_Mkxw_Qu4st_Yeyswrnu_123a33706e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

