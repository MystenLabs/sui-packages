module 0xfaeb5857524ee6d16397042db2c9356c895bacd0867732346b8aaafdcadd53f0::starb {
    struct STARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARB>(arg0, 9, b"STARB", b"starbucks", b"Get ready for Starbuks Coin  the meme token thats stronger than your morning coffee!  Invest, laugh, and watch your portfolio espresso to the moon. It's not just a token, it's a brew-tiful ride! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/fLQy9TsYw95DX2bD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STARB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

