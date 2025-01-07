module 0x39a39ac78b27f42abb0078aa8a5d52e4502015d79c1ab70d2ea049abd65c0b43::ACTP {
    struct ACTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACTP>(arg0, 9, b"ACTP2", b"Act II : The Peanut Prophecy", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6ofzqLnHhobh7cJ4C63rAf5qnKU8AoMxVBi7Kkm6n9wq.png?size=xl&key=d9dbb0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ACTP>>(0x2::coin::mint<ACTP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ACTP>>(v2);
    }

    // decompiled from Move bytecode v6
}

