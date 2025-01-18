module 0x6070c6dd4c1f0fb156bbf62e67af373a37813e770fb667da770cb2e9a8c02579::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"SUIFFICIAL TRUMP", b"My NEW Official Trump Meme on SUI is HERE! Its time to celebrate everything we stand for: WINNING! Join my very special Trump Community. GET YOUR $TRUMP NOW. Go to http://gettrumpmemes.com  Have Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6p6xg_Hy_F7_Ae_E6_T_Zk_Sm_Fsko444wqo_P15ic_U_Sqi2jf_Gi_PN_0fbe56b886.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

