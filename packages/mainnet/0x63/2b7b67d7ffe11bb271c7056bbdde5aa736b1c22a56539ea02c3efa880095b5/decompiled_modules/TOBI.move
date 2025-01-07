module 0x632b7b67d7ffe11bb271c7056bbdde5aa736b1c22a56539ea02c3efa880095b5::TOBI {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 9, b"tobi", b"tobi", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HPueqQjSgaSatMBKrvBvAnRmc6jnr51cPM1EjUJVpump.png?size=xl&key=71fb50")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOBI>>(0x2::coin::mint<TOBI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOBI>>(v2);
    }

    // decompiled from Move bytecode v6
}

