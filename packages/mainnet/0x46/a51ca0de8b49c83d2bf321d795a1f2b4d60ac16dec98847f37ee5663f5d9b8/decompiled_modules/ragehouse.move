module 0x46a51ca0de8b49c83d2bf321d795a1f2b4d60ac16dec98847f37ee5663f5d9b8::ragehouse {
    struct RAGEHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGEHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DppbdPzqkZvHhaZo91MXYUNaMDaXt15yrVBchPRkpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAGEHOUSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAGEHOUSE   ")))), trim_right(b"Rage House                      "), trim_right(b"Ever dreamed of owning a digital house? Well crush that dreamwith style. At RAGEHOUSE, we buy your house, offer you a fake price, and make you laugh while crying. Led by Rage Guy, Trollface, and Y U NO, this isnt just a projectits a museum of internet emotion and financial pain.                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGEHOUSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAGEHOUSE>>(v4);
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

