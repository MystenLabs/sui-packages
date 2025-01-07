module 0x44377d34d23d744ee3e3af3652cb19b010c676953e802b8b44d63751ea46a371::charlie {
    struct CHARLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARLIE>(arg0, 6, b"CHARLIE", b"CHARLIE THE UNICORN", x"68747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d437347596838416163675920576520616c6c2072656d656d62657220746861742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R1_M_Uk_J_Vx_Do7_QQ_Sf_B5_KS_8_BUM_6_WA_Jzv_Z_Qm2563_Duo_Jn_Zr8_5c2352e5b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

