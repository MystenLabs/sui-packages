module 0x981346bd403ab2e9271d4c5d660110fd6db0e8b69abbdc4c7a3e61e1df6bd727::shoggoth {
    struct SHOGGOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGGOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOGGOTH>(arg0, 6, b"Shoggoth", b"Shoggoth", b"Shoggoth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/H2c31USxu35MDkBrGph8pUDUnmzo2e4Rf4hnvL2Upump.png?size=lg&key=cdf2da"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOGGOTH>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHOGGOTH>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGGOTH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

