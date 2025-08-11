module 0xf3f9310a2dafbcf5a572a9906fd2073f12e41c7f57e146165386c6e4a218c275::illusionofdeath {
    struct ILLUSIONOFDEATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLUSIONOFDEATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLUSIONOFDEATH>(arg0, 9, b"Kraps", b" The Illusion of Death", b"Twitter: https://x.com/i/communities/1954836806907621826 | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaijt2eecxagjjz7rl424dsxhgm43hurukdkpoyairh3vtprhmo5q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILLUSIONOFDEATH>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLUSIONOFDEATH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILLUSIONOFDEATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

