module 0x3448720e050bd16488609f49e5d8d17d13979e9b004564d83b5ce4ff7b498c6d::raichusui {
    struct RAICHUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAICHUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAICHUSUI>(arg0, 9, b"RAISUI", b"Raichusui", b"An orange electric rodent with a lightning tail curving into the Sui emblem, zapping Sui coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidmdesxkiphv2aw735xvdetiaqcn5azngmhoko4fdrfrjjwigweju")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAICHUSUI>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAICHUSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAICHUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

