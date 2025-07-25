module 0x5643004e63eddd93a312cbbfe9c6d81a806d6df3786003421c3970bfeaf9f1c0::blot {
    struct BLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BLotpJQNGbqwKNp9BjaxDGY86PTSZ1GmrmU6bYJJSksQ.png?claimId=p_7awBz4IkQUbdjQ                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BLOT        ")))), trim_right(b"FolkRealms Blt                  "), trim_right(x"24424c4f54202054686520546f6b656e206f6620466f6c6b5265616c6d73200a466f7267656420696e2074686520737069726974206f6620616e6369656e742072697465732c2024424c4f5420697320746865206f6666696369616c20746f6b656e206f6620466f6c6b5265616c6d732c2061206d7974686963206469676974616c20776f726c6420776865726520686f6e6f722c206c6f79616c74792c20616e6420636f6e747269627574696f6e20617265206561726e65642e0a0a4f6e6c79203130206d696c6c696f6e2024424c4f542065786973742e204e6f206d6f72652077696c6c2065766572206265206d696e7465642e0a4f662074686573652c2031206d696c6c696f6e20617265207265736572766564202d20616e6420353025206f6620746861742063616e206265206561726e6564207468726f75676820"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOT>>(v4);
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

