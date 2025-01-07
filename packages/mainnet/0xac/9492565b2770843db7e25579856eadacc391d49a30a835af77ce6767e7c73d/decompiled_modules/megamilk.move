module 0xac9492565b2770843db7e25579856eadacc391d49a30a835af77ce6767e7c73d::megamilk {
    struct MEGAMILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGAMILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGAMILK>(arg0, 6, b"MEGAMILK", b"TITTY MONSTER", b"hmm, you don't sound very convinced, Shigeto-kun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQWi4FKR82penjGaWsDnSn8r5s76zAQZPM6s8eZQd8qwW?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEGAMILK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGAMILK>>(v2, @0x4410b378438d8a6fd9eacf565b16615d9589b83c62f2d11a16f4e4ed95a0c3ca);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGAMILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

