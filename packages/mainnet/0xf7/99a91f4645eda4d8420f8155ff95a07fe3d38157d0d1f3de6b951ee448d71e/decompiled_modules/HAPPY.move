module 0xf799a91f4645eda4d8420f8155ff95a07fe3d38157d0d1f3de6b951ee448d71e::HAPPY {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"Happy Cat", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HAPPYwgFcjEJDzRtfWE6tiHE9zGdzpNky2FvjPHsvvGZ.png?size=xl&key=7065e5")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAPPY>>(0x2::coin::mint<HAPPY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAPPY>>(v2);
    }

    // decompiled from Move bytecode v6
}

