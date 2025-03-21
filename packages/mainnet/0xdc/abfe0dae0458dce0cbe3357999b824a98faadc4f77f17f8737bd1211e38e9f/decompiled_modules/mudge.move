module 0xdcabfe0dae0458dce0cbe3357999b824a98faadc4f77f17f8737bd1211e38e9f::mudge {
    struct MUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8yeSLFG6YW41ntGpnyTKUnyh4V2QUt4hWgkTdknj8Gje.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUDGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mudge       ")))), trim_right(b"Mudge                           "), trim_right(x"4a757374206120235265616c446f672068656c70696e6720235265616c446f677320627920676976696e67206261636b2061732074686520234d75646765636f6d6d756e6974792067726f777320616c6c207768696c65206578706c6f72696e6720746865206d6f756e7461696e7320616e642073686172696e672068697320616476656e74757265732121210a244d7564676520746865206d6f756e7461696e20646f6720636f6d6520666f6c6c6f7720686973206163636f756e747320666f72207265616c206c69666520616476656e747572657320696e204e482c56542c4d410a436f6d65206a6f696e2068697320616476656e7475726520746f206e6577206865696768747320616e642068656c702023446f6773696e6e6565640a244d756467652020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUDGE>>(v4);
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

