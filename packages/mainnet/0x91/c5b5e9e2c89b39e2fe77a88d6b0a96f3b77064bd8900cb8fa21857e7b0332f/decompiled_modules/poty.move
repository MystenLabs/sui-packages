module 0x91c5b5e9e2c89b39e2fe77a88d6b0a96f3b77064bd8900cb8fa21857e7b0332f::poty {
    struct POTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTY>(arg0, 9, b"POTY", b"POTY Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/9XcefgUMsUWkHcmHWX1g8cKZzr9hsL6pQsupBvH4pump.png?size=lg&key=4b92a9"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POTY>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

