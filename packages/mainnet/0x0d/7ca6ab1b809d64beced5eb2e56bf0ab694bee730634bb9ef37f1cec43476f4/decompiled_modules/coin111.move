module 0xd7ca6ab1b809d64beced5eb2e56bf0ab694bee730634bb9ef37f1cec43476f4::coin111 {
    struct COIN111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<COIN111>(arg0, 9, b"jup", b"111", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<COIN111>(&mut v3, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN111>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COIN111>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN111>>(v2);
    }

    // decompiled from Move bytecode v6
}

