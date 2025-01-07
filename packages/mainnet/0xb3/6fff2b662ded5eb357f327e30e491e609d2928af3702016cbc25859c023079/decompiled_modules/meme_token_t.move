module 0xb36fff2b662ded5eb357f327e30e491e609d2928af3702016cbc25859c023079::meme_token_t {
    struct MEME_TOKEN_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_TOKEN_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEME_TOKEN_T>(arg0, 6, b"XXXX", b"XXX", b"xxxxxx", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN_T>>(0x2::coin::mint<MEME_TOKEN_T>(&mut v3, 666666666000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_TOKEN_T>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME_TOKEN_T>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::DenyCapV2<MEME_TOKEN_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

