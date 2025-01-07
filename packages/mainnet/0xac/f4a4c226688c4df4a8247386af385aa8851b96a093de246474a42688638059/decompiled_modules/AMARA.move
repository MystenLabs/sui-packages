module 0xacf4a4c226688c4df4a8247386af385aa8851b96a093de246474a42688638059::AMARA {
    struct AMARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMARA>(arg0, 9, b"AMARA", b"AMARA Hippo", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4mQoDqq9cFFnYD4Zd4CDN63kBKszsY7Nf1EMuBwipump.png?size=xl&key=55f0c2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMARA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AMARA>>(0x2::coin::mint<AMARA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AMARA>>(v2);
    }

    // decompiled from Move bytecode v6
}

