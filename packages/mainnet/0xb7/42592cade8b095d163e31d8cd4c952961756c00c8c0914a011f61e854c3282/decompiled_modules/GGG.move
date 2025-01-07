module 0xb742592cade8b095d163e31d8cd4c952961756c00c8c0914a011f61e854c3282::GGG {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 9, b"GGG", b"God, Guns, Girls", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BHut8WEeEGcZpggkmvZRHNDLqDFTZPWmXdLigG86pump.png?size=xl&key=c97f20")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GGG>>(0x2::coin::mint<GGG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GGG>>(v2);
    }

    // decompiled from Move bytecode v6
}

