module 0x1541b19ba0456ad1331d55f1aab72a10cffb4bc4642d9bb0150409ee9e42a595::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 6, b"First", b"First", b"First come first serve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPgLMu1sXteqh8QrTmY8F5skCAYiD7pZBawicDPHHHBwP?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIRST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v2, @0x416bd6c4e0e53dc07be2fe156b8fbed1eda1d0d99df2e3f7ed0bf218895d822c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRST>>(v1);
    }

    // decompiled from Move bytecode v6
}

