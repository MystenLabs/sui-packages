module 0xad174448ca1825e6ce0a301da28eaddad9a5e8377f884f9896314f2a19504ba9::zygo {
    struct ZYGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYGO>(arg0, 6, b"ZYGO", b"ZYGOSUI", b"$ZYGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UK_5_F1_Xko_Ac_N4_Qz_PN_To_PPZY_9p_PTN_2_Si8_Bc9b_YF_72_K_Ra_DN_0f6113fcc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

