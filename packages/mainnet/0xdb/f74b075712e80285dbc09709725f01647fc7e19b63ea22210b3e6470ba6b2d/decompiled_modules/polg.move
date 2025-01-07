module 0xdbf74b075712e80285dbc09709725f01647fc7e19b63ea22210b3e6470ba6b2d::polg {
    struct POLG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<POLG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POLG>>(0x2::coin::mint<POLG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: POLG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/04117Q5OY2FXgY9N?width=56&height=56&fit=crop&quality=95&format=auto                                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POLG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POLG    ")))), trim_right(b"PEPE GOLD                       "), trim_right(b"Pepe Gold  isn't just another flash in the pan; it's the meme coin that turns laughter into lasting value. With the glimmer of gold and the spirit of Pepe, this coin is built to shine bright and endure. Join the fun, embrace the gold, be the gold, and be part of the gold revolution.                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POLG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<POLG>>(0x2::coin::mint<POLG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

