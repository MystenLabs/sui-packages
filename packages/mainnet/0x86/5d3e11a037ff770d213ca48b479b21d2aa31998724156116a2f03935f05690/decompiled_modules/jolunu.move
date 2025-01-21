module 0x865d3e11a037ff770d213ca48b479b21d2aa31998724156116a2f03935f05690::jolunu {
    struct JOLUNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLUNU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOLUNU>(arg0, 6, b"JOLUNU", b"Jolunu AI  by SuiAI", b"JOLUNU AI is an advanced artificial intelligence designed to enhance the efficiency of asset purchases within the cryptocurrency ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/fn_Oe_R_Dv7_400x400_29d00c57c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOLUNU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLUNU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

