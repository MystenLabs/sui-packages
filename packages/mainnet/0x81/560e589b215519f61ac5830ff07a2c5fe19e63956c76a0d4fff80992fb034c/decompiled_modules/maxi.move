module 0x81560e589b215519f61ac5830ff07a2c5fe19e63956c76a0d4fff80992fb034c::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DMVy3Pvyb1Tspwn45GBFjX4B5V1NMFfujJGXH6wcpump.png?size=lg&key=7e9b7e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAXI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAXI    ")))), trim_right(b"JUSTICE FOR DOG KILLED BY COP   "), trim_right(b"BREAKING NEWS: A family is mourning the Christmas Eve death of their 15-year-old Husky after the dog was shot and killed while aggressively approaching a Raleigh police officer.                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXI>>(v4);
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

