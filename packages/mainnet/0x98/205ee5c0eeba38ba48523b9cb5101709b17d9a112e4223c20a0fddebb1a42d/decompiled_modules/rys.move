module 0x98205ee5c0eeba38ba48523b9cb5101709b17d9a112e4223c20a0fddebb1a42d::rys {
    struct RYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8gHPxqgHj6JQ2sQtMSghQYVN5qRP8wm5T6HNejuwpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RYS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RYS         ")))), trim_right(b"RefundYourSOL                   "), trim_right(x"546865206d6f737420616476616e6365642066656520726566756e6420616e6420746f6b656e2d6275726e696e6720706c6174666f726d206f6e20536f6c616e612e0a0a526566756e6420796f757220534f4c206665657320776974682075732e200a0a4164646974696f6e616c2062656e656669747320666f7220686f6c646572733a0a2d20353025206f6620616c6c20726576656e756520697320646973747269627574656420616d6f6e6720746f7020686f6c646572732028686f6c64696e67203130302c3030302b20746f6b656e73290a2d2035302520626f6e7573206f6e20616c6c20656c696769626c652066656520726566756e64730a0a537461727420736176696e67206d6f726520776974682065766572792074726164652c20616e64206761696e206578747261207265776172647320627920686f6c64"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYS>>(v4);
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

