module 0x3b5ee3a37ac17b18e43f784375332ef88fa79075631fb8367f9a1a86fa8b6e62::champs {
    struct CHAMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CJNATDxyJxucbQ9t1nHxePTBtDhywrba7qENQqd2MYzQ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAMPS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Champs      ")))), trim_right(b"Europe Champion Token           "), trim_right(x"53706f727473546f6b6e206973206120536f6c616e612070726f6a65637420666f7220576562332053706f72747320546f6b656e697a6174696f6e2c2074686174206c61756e636865732074686520464952535420434f494e2c20546865204575726f7065204368616d70696f6e20546f6b656e202d20244368616d7073210a0a244368616d707320697320616e20756e6f6666696369616c2063757272656e6379207469656420746f204575726f70652773206269676765737420666f6f7462616c6c206368616d70696f6e736869702c20746865204368616d70696f6e73204c6561677565210a0a427579206f757220546f6b656e732e204d616b65204d6f6e65792e20436865657220776974682055732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMPS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMPS>>(v4);
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

