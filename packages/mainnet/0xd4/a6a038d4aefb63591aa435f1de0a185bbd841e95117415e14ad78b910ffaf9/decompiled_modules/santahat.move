module 0xd4a6a038d4aefb63591aa435f1de0a185bbd841e95117415e14ad78b910ffaf9::santahat {
    struct SANTAHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"35312e9a269291f84dd05a5b2f023bebaef40245679452be207e1ed717a5936d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SANTAHAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"santahat    ")))), trim_right(b"Santa Hat Cult                  "), trim_right(b"Elon's Cult of Santa Hats. Change your PFP and join us.                                                                                                                                                                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAHAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAHAT>>(v4);
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

