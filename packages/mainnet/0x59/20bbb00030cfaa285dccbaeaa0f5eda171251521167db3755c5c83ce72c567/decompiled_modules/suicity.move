module 0x5920bbb00030cfaa285dccbaeaa0f5eda171251521167db3755c5c83ce72c567::suicity {
    struct SUICITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICITY>(arg0, 6, b"SuiCity", b"Sui Citytoken", b"FreeMint SuiCity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Ll_Ji_Yin_400x400_2ea20e40a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

