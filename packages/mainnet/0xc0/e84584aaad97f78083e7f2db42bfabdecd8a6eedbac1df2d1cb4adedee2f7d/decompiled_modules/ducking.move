module 0xc0e84584aaad97f78083e7f2db42bfabdecd8a6eedbac1df2d1cb4adedee2f7d::ducking {
    struct DUCKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKING>(arg0, 6, b"DUCKING", b"DUCKINGSUI", b"DUCK IS DUCKING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A2kh_Rbh_RJ_Nr_AE_Hj95htiv_C4c_R4_Vb_Jwfss_DH_5_FP_Pb_P4m9_90273f66a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

