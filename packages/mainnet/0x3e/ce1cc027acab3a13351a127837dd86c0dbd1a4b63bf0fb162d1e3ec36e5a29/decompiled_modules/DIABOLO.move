module 0x3ece1cc027acab3a13351a127837dd86c0dbd1a4b63bf0fb162d1e3ec36e5a29::DIABOLO {
    struct DIABOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIABOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIABOLO>(arg0, 9, b"DIABOLO", b"Official Mascot Church Of Satan", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EoFrf9ZDRkzLsxX45JXZNDgibEsEdG8bFmaTnJpMpump.png?size=xl&key=577761")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIABOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIABOLO>>(0x2::coin::mint<DIABOLO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIABOLO>>(v2);
    }

    // decompiled from Move bytecode v6
}

