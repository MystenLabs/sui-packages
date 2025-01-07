module 0x4ac5c3999aba0784f6705ea783679a435c2f59348ea27f39f950e30c70d6c60a::meme_token {
    struct MEME_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEME_TOKEN>(arg0, 6, b"TESTCOIN", b"TESTCOIN", b"TEST HIHI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(0x2::coin::mint<MEME_TOKEN>(&mut v3, 666666666000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_TOKEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME_TOKEN>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::DenyCapV2<MEME_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

