module 0xef89818cdf39e342d40c62c656cd6a849f68bdeec25e118ac6354a3b8277ec53::eugene {
    struct EUGENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUGENE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b0958e039a68d75b00e2f98bbc30d8f1909c59a286800d21bb675e9848dc0481                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EUGENE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Eugene      ")))), trim_right(b"Eugene The Meme                 "), trim_right(x"4d656d6573206861766520647269656420757020736f206d756368207468617420776520617265206f6e6c792073656e64696e6720686f74206e6577732c20616e642072656c61756e636865732e0a0a536f20776879206e6f742063726561746520616e20656e746972656c79206e6577206d656d650a0a6f6e65207468696e67207468652063727970746f20636f6d6d756e697479206973206772656174206174206973206d61726b6574696e672c20736f20776879206e6f74207075736820616e20656e746972656c79206e6577206d656d6520756e74696c20697420737469636b732e0a0a492070726573656e7420746f20796f752074686520616d617a696e676c7920646f6e6520455547454e4520202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUGENE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUGENE>>(v4);
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

