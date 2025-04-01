module 0x1761b138a5babc4347dce5fdc01decae4c0da1f5e535e1cce1c181cdb05b6ed4::foolsday {
    struct FOOLSDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLSDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6nczo5ZMLQLyzjeVguKcNpUQCexBYwrp8vpv2Legpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FOOLSDAY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FOOLSDAY    ")))), trim_right(b"HAPPY FOOL'S DAY!               "), trim_right(x"20417072696c20466f6f6c732720446179206f7220416c6c20466f6f6c73272044617920697320616e20616e6e75616c20637573746f6d206f6e203120417072696c20636f6e73697374696e67206f662070726163746963616c206a6f6b657320616e6420686f617865732e200a0a20446f6e742067657420666f6f6c65642c2062652074686520666f6f6c20206a6f696e207468652066756e20776974682024464f4f4c444159210a204275792024464f4f4c444159206e6f7720202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLSDAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOLSDAY>>(v4);
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

