module 0x5f670faef531fa635da65760aad2833ff082d8d8b91f10d66c5e0fd3319ce4f9::shoggoth {
    struct SHOGGOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGGOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOGGOTH>(arg0, 6, b"Shoggoth", b"Shoggoth", x"5468652074656e7461636c65642073686f67676f74682066726f6d20482e502e204c6f76656372616674e280997320e2809c417420746865204d6f756e7461696e73206f66204d61646e657373e2809d20686173206265636f6d65206120766972616c206d656d6520696e2074686520414920776f726c642e20546865206d656d652069732061206d65746170686f7220666f7220636f6e6365726e732074686174206172746966696369616c20696e74656c6c6967656e636520636f756c64206f6e6520646179206265636f6d6520696e646966666572656e7420746f2068756d616e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/H2c31USxu35MDkBrGph8pUDUnmzo2e4Rf4hnvL2Upump.png?size=lg&key=cdf2da"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOGGOTH>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHOGGOTH>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGGOTH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

