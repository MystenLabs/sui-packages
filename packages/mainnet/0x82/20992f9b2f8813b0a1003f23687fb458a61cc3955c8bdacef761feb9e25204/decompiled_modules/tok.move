module 0x8220992f9b2f8813b0a1003f23687fb458a61cc3955c8bdacef761feb9e25204::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 6, b"TOK", b"TOKEN2", b"Here we have a new token which we created as a test. so any one wishng to buy, buy at your own risk. only small amount of liquidity will be added for testing purpose only. And liquidity may also be removed. BUt it depends, if some innocent folk buy s it th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreif3pqsqr3d5agxiyv33aznefydx3ykf77egh2oetcbjpu74l5hsom")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOK>>(0x2::coin::mint<TOK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOK>>(v1);
    }

    // decompiled from Move bytecode v7
}

