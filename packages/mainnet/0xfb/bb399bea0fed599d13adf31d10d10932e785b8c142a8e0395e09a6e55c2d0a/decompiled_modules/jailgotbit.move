module 0xfbbb399bea0fed599d13adf31d10d10932e785b8c142a8e0395e09a6e55c2d0a::jailgotbit {
    struct JAILGOTBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILGOTBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9hKvJe95irLSp3Mx4UNu46CnmiXx1v25Ezomocbcpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JAILGOTBIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JAILGOTBIT  ")))), trim_right(b"JAILGOTBIT                      "), trim_right(x"476f746269747320666f756e64657220686173206265656e206578747261646974656420746f2074686520552e532e206f6e2063686172676573206f66206d61726b6574206d616e6970756c6174696f6e20616e642066726175642e0a0a546865204642492070726576696f75736c79206372656174656420697473206f776e20457468657265756d20746f6b656e2c20546865204e657846756e64414920546f6b656e2c20746f206578706f736520696c6c6963697420616374697669746965732c206c656164696e6720746f206368617267657320616761696e737420342063727970746f20636f6d70616e69657320616e6420313420696e646976696475616c732c20696e636c7564696e6720476f746269742e2020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILGOTBIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILGOTBIT>>(v4);
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

