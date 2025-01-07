module 0x5f0b7bc2878fcf3ee848ab348e23f1b7410fc122de29f16763fe50f4a12746a7::stone {
    struct STONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONE>(arg0, 6, b"STONE", b"STONEFISH", b"don't tread on me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmXbehnWKSZ43P4wdMxaaj53cvnekCV9hR2kSP4eUA2LcK?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONE>>(v2, @0xd72e9d1da7766e4375e8968e073160c368eba8942ee17d58e02bef86458e0257);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

