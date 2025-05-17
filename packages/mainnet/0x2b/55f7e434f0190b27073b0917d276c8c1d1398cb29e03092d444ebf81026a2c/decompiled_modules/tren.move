module 0x2b55f7e434f0190b27073b0917d276c8c1d1398cb29e03092d444ebf81026a2c::tren {
    struct TREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GbRgj4361Gw5PatDyUxBWmKaN9MzEkrJEk7n99yJHtfN.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TREN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TREN        ")))), trim_right(b"The Official Steroid Coin       "), trim_right(x"245452454e2020546865204d6f737420416e61626f6c696320436f696e206f6e2074686520426c6f636b636861696e200a537465702061736964652c207765616b2070726f6a656374732e20245452454e206973206865726520746f20646f6d696e61746520746865206d656d6520636f696e206172656e6120776974682074686520696e74656e73697479206f6620612066756c6c2d626c6f776e2072616765206379636c652e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREN>>(v4);
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

