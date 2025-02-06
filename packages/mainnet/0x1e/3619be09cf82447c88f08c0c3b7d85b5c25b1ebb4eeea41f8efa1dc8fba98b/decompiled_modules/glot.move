module 0x1e3619be09cf82447c88f08c0c3b7d85b5c25b1ebb4eeea41f8efa1dc8fba98b::glot {
    struct GLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/E7gBVsTN9UHP4uzc5HN6ZnRcc8hjzZX3HBiDERtHNJKd.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GLOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GLOT        ")))), trim_right(b"GlobalLotto                     "), trim_right(x"412042696c6c696f6e2d446f6c6c61722045636f73797374656d204275696c7420666f7220496e766573746f7273202620506c61796572730a5769746820666f72656361737473207265616368696e672062696c6c696f6e7320696e20616e6e75616c20726576656e75652c20657665727920646f6c6c61722077696c6c20666c6f77206261636b20696e746f2074686520696e766573746f727320616e64206261636b657273206f66206f75722063727970746f63757272656e63792c206d616b696e67204d474420746865206d6f73742070726f66697461626c652063727970746f2d706f7765726564206c6f747465727920706c6174666f726d20696e2074686520776f726c642e205768657468657220796f7572652061207061727469636970616e7420696e207468652064726177732c206120746f6b656e20686f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOT>>(v4);
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

