module 0x79c38007d8f24d8da97386f86c775456ffcc20784428e7f7d9ceca7e210bf11e::nostalgic {
    struct NOSTALGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSTALGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"deab44465dcb6599ecaad1aa6d483dcc7dd32d274bb7960f83ba28ea4da502d6                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOSTALGIC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NOSTALGIC   ")))), trim_right(b"I Remember When                 "), trim_right(b"Crypto isnt just charts and tickers. Its a story. $Nostalgic is a tribute to the moments well never forget: the first bull run, the legendary memes, the sleepless nights in the trenches. Its a coin for the dreamers who got us here and the new degens writing the next chapter.                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSTALGIC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSTALGIC>>(v4);
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

