module 0x7d47206dd9aeed66c411e7287a556015cccf5b19157166bb15eadd584a65f543::RIGGED {
    struct RIGGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGGED>(arg0, 9, b"RIGGED", b"RIGGED", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x64b7ca881ba6fa7fa594d9a41e3036b567bc2fbd.png?size=xl&key=567581")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIGGED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIGGED>>(0x2::coin::mint<RIGGED>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIGGED>>(v2);
    }

    // decompiled from Move bytecode v6
}

