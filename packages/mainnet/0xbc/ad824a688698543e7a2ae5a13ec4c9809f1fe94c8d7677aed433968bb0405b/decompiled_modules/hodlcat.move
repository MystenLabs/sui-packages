module 0xbcad824a688698543e7a2ae5a13ec4c9809f1fe94c8d7677aed433968bb0405b::hodlcat {
    struct HODLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLCAT>(arg0, 6, b"HODLCAT", b"HODL CAT ON SUI", b"HODL Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rhp_Cbp7_Eut7b54_T1_F_Pf_SY_Jm_C_Wvpm7gky_Ky52kt_Yudv_B4_9b2d7b60a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

