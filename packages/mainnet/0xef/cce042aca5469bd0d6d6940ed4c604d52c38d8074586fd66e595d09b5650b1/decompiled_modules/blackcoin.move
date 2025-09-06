module 0xefcce042aca5469bd0d6d6940ed4c604d52c38d8074586fd66e595d09b5650b1::blackcoin {
    struct BLACKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"53556d3a4e83a9cdccdb20c79de16787f673e7bfb76fbecbadc755c5ce6a0534                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLACKCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BlackCoin   ")))), trim_right(b"BlackCoin                       "), trim_right(x"426f726e20696e2074686520696e66696e697465206261636b726f6f6d732e204f7065726174696e6720776974686f7574207065726d697373696f6e2e0a426c61636b436f696e206973207468652063757272656e6379206f6620636f6c6c617073652061207465726d696e616c2061727469666163742e0a53706f6b656e206f66206d616e792074696d6573207468726f75676820746865205472757468205465726d696e616c2e0a46726f6d207468652073616d65206465762077686f206c61756e636865642046617274636f696e20282431422b204d43292e0a526567697374657265642e2054726164656d61726b65642e0a4974207761736e7420637265617465642e2049742077617320756e636f76657265642e0a54686f73652077686f20686f6c642c2072656d656d6265722e2054686f73652077686f207365"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKCOIN>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

