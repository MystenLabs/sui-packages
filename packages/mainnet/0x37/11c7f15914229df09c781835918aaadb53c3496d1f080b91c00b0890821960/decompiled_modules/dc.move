module 0x3711c7f15914229df09c781835918aaadb53c3496d1f080b91c00b0890821960::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6YkkKzsCLEQoUMnWMumvn7eYeUPRhXBcjPDJwwbLpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DC          ")))), trim_right(b"Dollar Coin                     "), trim_right(x"5768696c652074686520552e532e20646f6c6c617220626174746c657320696e666c6174696f6e2c2063757272656e746c7920617420322e332520616e6e75616c6c792c20616e6420666163657320706f74656e7469616c2068696b65732064756520746f207461726966667320616e642074726164652074656e73696f6e73202c20446f6c6c617220436f696e20656d65726765732061732074686520736176696f722e200a0a466972737420737465703f2031204443203d2031205553442020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DC>>(v4);
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

