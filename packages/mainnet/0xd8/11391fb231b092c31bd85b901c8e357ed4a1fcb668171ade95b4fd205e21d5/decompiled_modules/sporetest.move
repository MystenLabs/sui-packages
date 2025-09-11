module 0xd811391fb231b092c31bd85b901c8e357ed4a1fcb668171ade95b4fd205e21d5::sporetest {
    struct SPORETEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPORETEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPORETEST>(arg0, 6, b"SPORETEST", b"SPORE test token", x"5465737420546f6b656e2028535549292020747269616c206c697374696e67206f6e204d6f76652050756d702e0a507572706f73653a2076616c6964617465206c697374696e6720666c6f7720616e6420636f7265206d656368616e696373206168656164206f6620746865206d61696e2072656c656173652e0a546573742077696e646f773a205442442e0a506172616d6574657273206172652070726f766973696f6e616c20616e64206d61792072657365742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifgd5fz2ayj7hicvzksslt62s2oxqnahwiznmg3k6uwowes443lqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPORETEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPORETEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

