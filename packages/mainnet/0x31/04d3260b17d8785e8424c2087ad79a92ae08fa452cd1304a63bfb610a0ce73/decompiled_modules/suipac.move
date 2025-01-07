module 0x3104d3260b17d8785e8424c2087ad79a92ae08fa452cd1304a63bfb610a0ce73::suipac {
    struct SUIPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAC>(arg0, 6, b"SuiPAC", b"PAC", b"Join The America $PAC Movement! We support Trump and the tech billionaire SuperPacs backing him, like Elon Musk and the Winklevoss Twins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28_c98b55075f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

