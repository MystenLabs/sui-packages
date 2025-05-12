module 0xe23d1e63a117d5c5dd30b6992b4800ef152d24e13f4fed745cf4520dba485d94::helpcoin {
    struct HELPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7HZaPg59D47417kRn3NUStbShV7bmuzjMKUkzD9kpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HELPCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HELPCOIN    ")))), trim_right(b"HELPCOIN                        "), trim_right(x"5765206172652073656c6c696e672077697468207468652035252077616c6c657420302e3125206576657279203130304b206d61726b6574206361702e2054686520736f6c64206d6f6e65792077696c6c206265207468656e20646f6e6174656420746f20612063686172697479206f7267616e697a6174696f6e2077686963682068656c7073206368696c6472656e20696e206e6565642e200a5765206170707265636961746520616c6c20646f6e6174696f6e7320616e64206a7573742072656d656d62657220657665727920627579206368616e67657320736f6d656f6e6573206c69666521200a0a4665656c206672656520746f20646f6e617465206469726563746c79207468726f75676820746865206f7267616e697a6174696f6e206c696e6b202863727970746f206973206163636570746564290a28596f75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELPCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELPCOIN>>(v4);
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

