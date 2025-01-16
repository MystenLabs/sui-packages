module 0x8a590e60d31142142a95d773f8356b17f7e4c5a1131c6b5873a8c97e502d699b::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"Cat AI Sui Network by SuiAI", b"The AI Meme Token for the Community on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gh_TW_Ho_Hb_QA_Arfz_N_f1996c200c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

