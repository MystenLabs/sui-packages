module 0xfc9cadd2d723a27268e46a63fcdfcb0e2c23bbac08b7661263daee98972cd531::BEFFFAI {
    struct BEFFFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEFFFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEFFFAI>(arg0, 9, b"BeffAI", b"BeffAI", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2Tr3i2qjSPUb7e7BSFWTq7gsRzJEnYBKc7wRAYu3pump.png?size=xl&key=e69e19")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEFFFAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BEFFFAI>>(0x2::coin::mint<BEFFFAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEFFFAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

