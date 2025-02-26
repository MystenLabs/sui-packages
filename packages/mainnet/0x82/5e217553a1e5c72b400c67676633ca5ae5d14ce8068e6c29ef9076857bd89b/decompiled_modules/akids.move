module 0x825e217553a1e5c72b400c67676633ca5ae5d14ce8068e6c29ef9076857bd89b::akids {
    struct AKIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2z5VijfstyHnDsvGwMExtvjTgTB1TT3JSf29PRe9MvNG.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AKIDS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AKIDS       ")))), trim_right(b"AFRICA KIDS TOKEN               "), trim_right(b"Welcome to Africa Kids Token, an innovative project that unites blockchain, solidarity, and culture to transform lives. Inspired by the contagious energy and extraordinary talent of young Africans from all corners of the continent, this token is born with a clear purpose: to give global visibility to the positive impac"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIDS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIDS>>(v4);
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

