module 0xcb462bd59c57c0d430034422c0b5c9a5434c69e68045e7d69728107f8757ca8b::spudd {
    struct SPUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2ea9d45ce4d35fe43e08b30d5ead6fe2ec06f009a66b18a08af215cc9906835c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPUDD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPUDD       ")))), trim_right(b"Crazy Spud                      "), trim_right(x"546865206372617a6965737420646f67206f6e2054696b546f6b206a7573742062726f6b65206c6f6f7365206f6e20536f6c616e612020616e6420686573206e6f7420736c6f77696e6720646f776e2e20245350554444206973206275696c7420646966666572656e743a206120766972616c207075702c2061207374726f6e67206465762c20616e64206120636f6d6d756e69747920746861747320616c72656164792072756e6e696e672077696c642e0a0a546869732069736e74206a757374206120636f696e2c206974732061206d6f76656d656e742e204576657279206261726b2c206576657279206275792c20657665727920686f6c64657220707573686573205370756420636c6f73657220746f20746865206d6f6f6e2e20596f752063616e206368617365206c61746572206f722072756e20776974682074"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUDD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUDD>>(v4);
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

