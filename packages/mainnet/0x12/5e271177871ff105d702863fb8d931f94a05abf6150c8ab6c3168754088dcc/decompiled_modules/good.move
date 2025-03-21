module 0x125e271177871ff105d702863fb8d931f94a05abf6150c8ab6c3168754088dcc::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A6WCD9dzgpCpCofGG7boCN3jJitmBSoXS7tgZa4rGooD.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOOD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOOD        ")))), trim_right(b"PNut's Freedom Farm             "), trim_right(x"50274e7574732046726565646f6d204661726d20416e696d616c2053616e637475617279206973206120706c61636520776865726520686f70652c206865616c696e672c20616e64207365636f6e64206368616e63657320666c6f75726973682e2057652072657363756520616e696d616c732066726f6d20736974756174696f6e73206f66206e65676c6563742c2061627573652c20616e64206162616e646f6e6d656e742c206f66666572696e67207468656d206120736166652c206c6f76696e6720656e7669726f6e6d656e7420746f207265636f76657220616e642072656275696c64207468656972206c697665732e0a0a5461782070726f63656564732066726f6d20746869732070726f6a65637420676f206469726563746c7920746f20737570706f7274696e6720746865206f6e676f696e67206f70657261"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOD>>(v4);
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

