module 0xc6e4af40d3a8823c41f1908295cc3cf6b2f4226e2ea4ae18157ea09df6fb7ba::BOG {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 9, b"BOG", b"Bogdanoff", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DxQwEZvCdAPfvw8PiUSVjvATxowQJ5FJL8bBiHUbpump.png?size=xl&key=6595cd")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOG>>(0x2::coin::mint<BOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOG>>(v2);
    }

    // decompiled from Move bytecode v6
}

