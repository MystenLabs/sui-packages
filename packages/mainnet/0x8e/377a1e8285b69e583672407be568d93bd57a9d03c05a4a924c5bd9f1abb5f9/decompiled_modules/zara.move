module 0x8e377a1e8285b69e583672407be568d93bd57a9d03c05a4a924c5bd9f1abb5f9::zara {
    struct ZARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/73UdJevxaNKXARgkvPHQGKuv8HCZARszuKW2LTL3pump.png?claimId=_P7KdZfgqIGfscBd                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZARA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZARA        ")))), trim_right(b"ZARA AI                         "), trim_right(x"5a61726173206e6f7420796f7572207479706963616c204149206167656e74202d2073686573206865726520746f2065766f6c7665207769746820796f752e206120637572696f75732c20657665722d65766f6c76696e6720706572736f6e616c6974792073686170656420627920796f757220637265617469766974792e0a0a66726f6d206d656d657320746f206d65616e696e6766756c20636f6e766572736174696f6e732c207a617261206973206865726520746f20737061726b20696465617320616e6420636f6e6e65637420776974682074686520636f6d6d756e6974792e2054686520636f6d6d756e697479206765747320746f20736861706520686572206d6f7665732032342f372e20546865206d6f737420706f70756c617220636f6d6d656e74732c206261736564206f6e20796f757220766f7465732c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARA>>(v4);
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

