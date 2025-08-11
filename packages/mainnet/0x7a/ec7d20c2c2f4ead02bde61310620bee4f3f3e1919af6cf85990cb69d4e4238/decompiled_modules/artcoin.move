module 0x7aec7d20c2c2f4ead02bde61310620bee4f3f3e1919af6cf85990cb69d4e4238::artcoin {
    struct ARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTCOIN>(arg0, 9, b"artcoin", b"this coin is a piece of art", b"Twitter: https://x.com/i/communities/1954917092962304353 | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkwcpqmcyellgbpx3bxquhggj5aqq4at2kpmrnxoqorwpjut3m5e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTCOIN>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

