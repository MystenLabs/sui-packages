module 0x3ebaf551d6616e5f254a01f8fc646eb6d08649603611f80b08279d6490ef3886::fartgranpa {
    struct FARTGRANPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTGRANPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AXYZDxt5yNEAavPUcPa4wZEyL9ySJPvAtbNJxmFdpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTGRANPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTGRANPA  ")))), trim_right(b"FARTGRANDPA                     "), trim_right(b"FartGrandpa the heart of the Fart family is here to love, care, and ensure that FartBoy, FartGirl, and every member of the family stay safe and happy. With Grandpa by your side, youll always have love, support, and a guiding hand!                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTGRANPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTGRANPA>>(v4);
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

