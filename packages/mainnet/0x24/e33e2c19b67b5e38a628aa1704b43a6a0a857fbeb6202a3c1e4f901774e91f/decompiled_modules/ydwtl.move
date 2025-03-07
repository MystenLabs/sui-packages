module 0x24e33e2c19b67b5e38a628aa1704b43a6a0a857fbeb6202a3c1e4f901774e91f::ydwtl {
    struct YDWTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YDWTL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/93vpr9tx4jXzeyt14Jwqcd4q4d9CBP9jb674pQ5vpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YDWTL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YDWTL       ")))), trim_right(b"You Dont Want This Life         "), trim_right(b"You Dont Want This Life is a streetwear lifestyle brand born in Toronto, raised in London that lost everything due to the covid crisis. We are built on a family mentality for those who resonate with our culture and lifestyle. This means overcoming adversity, hard work, and creativity, which is expressed in what we choo"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YDWTL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YDWTL>>(v4);
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

