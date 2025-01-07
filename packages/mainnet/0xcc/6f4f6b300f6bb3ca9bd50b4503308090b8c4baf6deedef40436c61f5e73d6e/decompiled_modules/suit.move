module 0xcc6f4f6b300f6bb3ca9bd50b4503308090b8c4baf6deedef40436c61f5e73d6e::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIT", b"im uniform maxxing. suit maxxing. im in my yohji yamamoto suit. yes i dress up nicely just to post. im on the blockchain in my suit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRZUJg84bvMdZt7QaDoSTdw4FU52YFuqVPsVPS1tc7ZPE?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v2, @0xb8dfa020470db4dfd2ddba157296301fbcfbaaec3aea1a8a405e01309c707a6a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

