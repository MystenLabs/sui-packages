module 0x1bb88edeb26649b1626b5aec36b18cdf5f3925ea0e5644118582d70cb51a00b2::ozzyai {
    struct OZZYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZZYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9Y9kbG9ZaxWmrtjHASsckBcLPu3WEBPSsYscxKne4SzC.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OZZYAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OzzyAi      ")))), trim_right(b"Ozzy Ai                         "), trim_right(x"4f7a7a792041492077696c6c20686f6e6f722061206c6567656e6420666f7220746865206e657874203130302079656172732e204c657473206275696c642061206d6f76656d656e742061726f756e642068696d2e2041207265616c20636f6d6d756e6974792e204f6e6520746861742067726f77732c20637265617465732c20616e64206b6565707320686973206c656761637920616c6976652e0a0a546869732069736e74206a7573742061207472696275746520206974732061206d697373696f6e2e20496620796f752062656c6965766520696e20776861742068652073746f6f6420666f722c206e6f7773207468652074696d6520746f20636f6e6e6563742c20636f6e747269627574652c20616e6420636172727920697420666f72776172642e20202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZZYAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZZYAI>>(v4);
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

