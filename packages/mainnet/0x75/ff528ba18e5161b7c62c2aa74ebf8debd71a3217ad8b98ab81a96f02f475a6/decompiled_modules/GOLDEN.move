module 0x75ff528ba18e5161b7c62c2aa74ebf8debd71a3217ad8b98ab81a96f02f475a6::GOLDEN {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN>(arg0, 9, b"GOLDEN", b"Golden Age", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GjqpHLGPUtmBbfGvEAEvVG6GJkfyAozNZb1uJLoppump.png?size=xl&key=0d5e27")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDEN>>(0x2::coin::mint<GOLDEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOLDEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

