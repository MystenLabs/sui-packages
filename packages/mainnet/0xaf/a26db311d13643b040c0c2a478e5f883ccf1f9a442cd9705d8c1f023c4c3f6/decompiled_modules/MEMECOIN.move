module 0xafa26db311d13643b040c0c2a478e5f883ccf1f9a442cd9705d8c1f023c4c3f6::MEMECOIN {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"MEMECOIN", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DxrupDm3nUtMtMRxfZVyUPgtunTKdgQjRmLTEv3Jpump.png?size=xl&key=37ef12")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEMECOIN>>(0x2::coin::mint<MEMECOIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMECOIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

