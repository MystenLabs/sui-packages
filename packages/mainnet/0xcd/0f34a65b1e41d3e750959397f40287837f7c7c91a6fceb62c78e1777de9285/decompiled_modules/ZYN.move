module 0xcd0f34a65b1e41d3e750959397f40287837f7c7c91a6fceb62c78e1777de9285::ZYN {
    struct ZYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYN>(arg0, 2, b"Zyn Coin", b"Zyn", b"$ZYN brings the best part of upper deckys, onchain. ZynCoin has no shortage of good vibes as a fair launch, community led project that brings that buzz to your portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_2120_f07e52f09b.jpeg&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZYN>(&mut v2, 50000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<ZYN>(&mut v2, 50000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

