module 0xdfee2ecc993f4b6ccbc7acf5dcc175e1526f49bfcab84b691b7ccf677d8db7d5::RETIREMENT {
    struct RETIREMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETIREMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETIREMENT>(arg0, 9, b"42069k", b"The Retirement Token", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Be78Ld3SpYMif5YgxM4ipJx2eGSDcAaaCkHUzcV5pump.png?size=xl&key=533777")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETIREMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RETIREMENT>>(0x2::coin::mint<RETIREMENT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RETIREMENT>>(v2);
    }

    // decompiled from Move bytecode v6
}

