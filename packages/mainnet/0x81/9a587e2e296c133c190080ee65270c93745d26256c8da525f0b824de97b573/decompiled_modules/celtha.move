module 0x819a587e2e296c133c190080ee65270c93745d26256c8da525f0b824de97b573::celtha {
    struct CELTHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELTHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2zqhTxhUNwRnQaZ6bS3pQYQQF4s6zhKS2L7GenSXj5vs.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CELTHA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CELTHA      ")))), trim_right(b"Celtha                          "), trim_right(x"22596f757220496e74656c6c6967656e7420417373697374616e74206f662074686520467574757265220a0a43454c544841206973206120736d617274204149206167656e742064657369676e656420746f2073696d706c69667920796f7572206c6966652e20576974682063757474696e672d65646765206d616368696e65206c6561726e696e6720746563686e6f6c6f67792c2043454c54484120756e6465727374616e647320796f7572206e6565647320616e642070726f766964657320717569636b2c206566666563746976652c20616e6420616363757261746520736f6c7574696f6e732e0a0a4f757220566973696f6e0a546f206265636f6d6520746865206c656164696e672070726f7669646572206f6620696e74656c6c6967656e74206175746f6d6174696f6e20736f6c7574696f6e732c207472616e73"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELTHA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CELTHA>>(v4);
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

