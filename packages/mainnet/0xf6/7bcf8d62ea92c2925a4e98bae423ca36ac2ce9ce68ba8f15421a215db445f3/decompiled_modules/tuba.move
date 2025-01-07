module 0xf67bcf8d62ea92c2925a4e98bae423ca36ac2ce9ce68ba8f15421a215db445f3::tuba {
    struct TUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUBA>(arg0, 6, b"TUBA", b"No1 YouTube Shark", x"5475626120697320746865206d6f73742066616d6f757320736861726b206f6e20596f75547562652c2077697468206d6f7265207468616e20312062696c6c696f6e207669657773206f6e2069747320766964656f732e2054686973206261627920736861726b206c6f76657320746f20676574207469636b6c65642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xi_Cy_E_Tfr_L9mgab_FT_Svq_Gku_Sm_JDSH_Fb1_Lf49_XK_Zh_DWYVS_28e2391389.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

