module 0x7e14db92bb92da95efea734d6bb04b725cc654b9570385702a90857f2d275aa7::etatecoina {
    struct ETATECOINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETATECOINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ffd20cf2ad3880116242f28089515954b53321648eca7bc66721517342bf1e43                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ETATECOINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ETATECOIN   ")))), trim_right(b"Estate Coin                     "), trim_right(b"Insurance is confusing and expensive. Most brokers suck TRADFI as we know it, is on its way out. Build generational wealth for your family and protect your hard earned assets and estate.  Welcome to estate planning re-engineered. Welcome to the future. #E$tatecoin                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETATECOINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETATECOINA>>(v4);
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

