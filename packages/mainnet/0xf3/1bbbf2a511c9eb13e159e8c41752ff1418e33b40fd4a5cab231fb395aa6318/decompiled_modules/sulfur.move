module 0xf31bbbf2a511c9eb13e159e8c41752ff1418e33b40fd4a5cab231fb395aa6318::sulfur {
    struct SULFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1190 || 0x2::tx_context::epoch(arg1) == 1191, 0);
        let (v1, v2) = 0x2::coin::create_currency<SULFUR>(arg0, 6, b"SULFUR", b"SULFUR", x"53554c46555220657320756e20746f6b656e20636f6d756e69746172696f20656e2053554920696e7370697261646f20656e20656c206d696e6572616c206dc3a1732076616c696f736f206465206c6f73206a7565676f73206465207375706572766976656e6369612e2043726561646f20706f7220792070617261206a756761646f7265732e204661726d65612c206163756d756c6120792070726570c3a172617465207061726120656c207261696420646566696e697469766f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmRycXNpgiXFybj7q6kRoDJQxHTgKCd1ZJHx1Vk7fNsVYE"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SULFUR>(&mut v3, 21000000000000, @0xb71961b03b6e62ceddf2cf2c63f47ad2663a3a7197ff35a848a6f3b85d5d62c1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULFUR>>(v3, @0xb71961b03b6e62ceddf2cf2c63f47ad2663a3a7197ff35a848a6f3b85d5d62c1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SULFUR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

