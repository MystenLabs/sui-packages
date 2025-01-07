module 0xbac22ec526438e74ab719dc87a7eb7c8ce0351925868a05919a528b990e9e509::pengi {
    struct PENGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGI>(arg0, 6, b"PENGI", b"Pengi", b"Pengi is the most brutal on Sui. Fish are afraid of HIM, because he literally kills them in seconds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yaki_L_Rn_Wu_D91_DLL_9_Ro_EG_Liipn_KFMB_Xzy_B2_Hp563m_C_Kx_Y_605181c6f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

