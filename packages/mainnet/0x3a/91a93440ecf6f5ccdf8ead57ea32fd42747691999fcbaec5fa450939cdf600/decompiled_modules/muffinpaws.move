module 0x3a91a93440ecf6f5ccdf8ead57ea32fd42747691999fcbaec5fa450939cdf600::muffinpaws {
    struct MUFFINPAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFFINPAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFFINPAWS>(arg0, 9, b"MUFFY", b"Muffinpaws", x"437574656e65737320736f20737765657420796f75722077616c6c6574206d6967687420676574206120746f6f746861636865e280944d756666696e7061777320616c77617973206c616e6473206f6e2069747320666565742c2070726566657261626c7920696e20612063757063616b6520747261792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiap3wfd4zlph7qthdgsiabsxe34wpqvo23orgt4stxpb73w2xzxly")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUFFINPAWS>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFFINPAWS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFFINPAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

