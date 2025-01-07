module 0x22a3a5dbcc8b7104fdd9910d9752fa64aa48873e6b3d84b3590ab0053a34d8ab::KIYAMA {
    struct KIYAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIYAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIYAMA>(arg0, 9, b"KIYAMA", b"Kiyama Ino", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9gnHyT6J6SpoawXD8e1JMwXB7eVzF2heYBtCeLZKpump.png?size=xl&key=047b40")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIYAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KIYAMA>>(0x2::coin::mint<KIYAMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIYAMA>>(v2);
    }

    // decompiled from Move bytecode v6
}

