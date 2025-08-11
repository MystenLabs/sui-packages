module 0x8c8e74c2b7ae0a11bbcbe6f8b2df66f96e0baedcc9427550268c6e879346580b::nodatahere {
    struct NODATAHERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODATAHERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODATAHERE>(arg0, 9, b"Null", b"No data here", b"Twitter: https://x.com/i/communities/1954879252018372859 | Website: https://x.com/NotAce_/status/1954879905520652622 | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifykomzirezpenvvduze74hv2x46qd3lru7vhs5z2p3gh5g4lrdjy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NODATAHERE>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODATAHERE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NODATAHERE>>(v1);
    }

    // decompiled from Move bytecode v6
}

