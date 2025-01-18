module 0x5ebbf71deefc5ad2d4d971d05f9ef0480bd4a24983aebf78adbb220f8310d1b2::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"OFFICIAL TRUMP", b"The Only Official Trump Meme. $TRUMP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6p6xg_Hy_F7_Ae_E6_T_Zk_Sm_Fsko444wqo_P15ic_U_Sqi2jf_Gi_PN_1_61fe6fd2bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

