module 0x903ac2c07bc83f6e8a3e250f309efe586df61e2c0a99a4fa7d4a2f67c52df87f::suilebi {
    struct SUILEBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEBI>(arg0, 9, b"SUIBI", b"Suilebi", b"A small, mystical sprite with leafy antennae, floating inside a glowing Sui bubble.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreicfgbl5kq5gc7fcnv7u37x2c3qnxew4xaph2b5g4bwneulm72yvlu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILEBI>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

