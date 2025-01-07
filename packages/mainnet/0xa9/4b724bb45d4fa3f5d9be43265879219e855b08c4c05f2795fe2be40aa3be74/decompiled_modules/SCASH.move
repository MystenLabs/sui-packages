module 0xa94b724bb45d4fa3f5d9be43265879219e855b08c4c05f2795fe2be40aa3be74::SCASH {
    struct SCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCASH>(arg0, 9, b"SCASH", b"Space Cash", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/43EhjH9MPn5ACsuG4HE9ASiiEaVGXpxttFdN8Jjcpump.png?size=xl&key=814998")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCASH>>(0x2::coin::mint<SCASH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCASH>>(v2);
    }

    // decompiled from Move bytecode v6
}

