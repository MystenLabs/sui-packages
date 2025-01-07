module 0xd544d4f49d8b1358d11ac5c6b76ae4a94040f1670cadfbc914f6b00bcaf6905a::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"CatAI", b"First AI-driven meme coin cat ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Vp_Ua4_R_d6eff01de6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

