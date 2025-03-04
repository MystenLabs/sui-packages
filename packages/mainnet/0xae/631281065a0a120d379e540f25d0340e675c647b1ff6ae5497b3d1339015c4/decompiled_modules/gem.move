module 0xae631281065a0a120d379e540f25d0340e675c647b1ff6ae5497b3d1339015c4::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4ceWKFXX4bz8NoTiHhYgiBJsGwnUDSjCLkzJGFFUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GEM         ")))), trim_right(b"UK First Cloned Animal Dog      "), trim_right(x"54686520554b7320466972737420436c6f6e656420506574204d656d6520436f696e21200a0a4a757374206c696b6520636c6f6e696e67206d616b6573207065747320657465726e616c2c2047454d206973206865726520746f207265706c6963617465207375636365737320616e642070756d70206e6f6e2d73746f70210a0a20556e6971756520436c6f6e656420506574204e61727261746976650a2048696768204c6971756964697479202620556e73746f707061626c6520464f4d4f0a204d756c7469706c792026204c697665204f6e20466f72657665720a0a4a6f696e2047454d206e6f772020436c6f6e696e6720746865204675747572652c2050756d70696e6720746865204d61726b657421202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEM>>(v4);
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

