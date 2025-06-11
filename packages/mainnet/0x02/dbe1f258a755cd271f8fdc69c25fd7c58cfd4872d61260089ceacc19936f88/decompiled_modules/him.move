module 0x2dbe1f258a755cd271f8fdc69c25fd7c58cfd4872d61260089ceacc19936f88::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4xp8Ysi2oEHjBWocqrgm8w8kUFQvExCmjaYUxuwzpump.png?claimId=W4SV-cssKfAC4oTO                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HIM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HIM         ")))), trim_right(b"him                             "), trim_right(x"2468696d202068652069732068696d2e0a6e6f74206a7573742061206361742e206e6f74206a757374206120636f696e2e0a6865206d656f77732c20636861727473206c697374656e2e0a686520626c696e6b732c2063616e646c6573207072696e742e0a6865206973206e6f74206261736564206f6e20746865206d656d652e0a686520697320746865206d656d652e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIM>>(v4);
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

