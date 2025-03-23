module 0xc3721f6ed68899855d592341fae05517c362880c71f89034c54f6dade65770f2::tcoin {
    struct TCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F7nyoyGJ47SezzNWcGkdeCUwPafTN9Nj1wsMxYvPNvqm.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TCOIN       ")))), trim_right(b"TCOIN                           "), trim_right(x"547269706c6520506c617920495420496e632e206973206120666f722d70726f66697420495420636f72706f726174696f6e20626173656420696e2044616c6c61732c2054657861732e2054686520636f6d70616e79207370656369616c697a657320696e20706f696e742d6f662d73616c6520746563686e6f6c6f676965732e2049747320676c6f62616c20776f726b666f726365207370616e7320666f757220646966666572656e7420636f756e74726965733a204d657869636f2c20496e6469612c20746865205068696c697070696e65732c2045637561646f722c20616e6420746865205553412e20200a0a54686579206f66666572206669656c642073657276696365732077697468206f76657220332c30303020736572766963652074656368206e6174696f6e776964652c20736563757265206e6574776f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCOIN>>(v4);
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

