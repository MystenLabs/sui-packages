module 0x68744b8695f84c67e5150092e6fcab298392903596a686c8e1dc848fa137602e::rokitship {
    struct ROKITSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROKITSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROKITSHIP>(arg0, 6, b"ROKITSHIP", b"ROKITSHIP FLIGHT5 STARSHIT", b"Elon musk flight 5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W4m_Fee_Gs6_W_Sh_Yfaw_X3_E9_NLF_Sy7_Qos2_C_Tn_Evdg3_Fb_Tqn_H_e6add5f7f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROKITSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROKITSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

