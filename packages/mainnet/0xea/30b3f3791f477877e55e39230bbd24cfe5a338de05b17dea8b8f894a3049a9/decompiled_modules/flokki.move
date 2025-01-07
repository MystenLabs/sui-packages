module 0xea30b3f3791f477877e55e39230bbd24cfe5a338de05b17dea8b8f894a3049a9::flokki {
    struct FLOKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKKI>(arg0, 9, b"FLOKKI", b"Flokki", b"FLOKKI is a community-driven cryptocurrency inspired by memes, with a playful yet ambitious goal to revolutionize DeFi. It focuses on creating real utility through projects like NFTs and a metaverse, blending fun with functionality for long-term growth in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1769512431116537856/_VGDf4KJ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOKKI>(&mut v2, 240000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

