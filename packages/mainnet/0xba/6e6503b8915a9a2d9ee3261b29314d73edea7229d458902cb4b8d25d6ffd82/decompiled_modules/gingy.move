module 0xba6e6503b8915a9a2d9ee3261b29314d73edea7229d458902cb4b8d25d6ffd82::gingy {
    struct GINGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7JRAtm3hGnF4iEeRJdcxBtB5zovzkcd2tgpw6Ns1pump.png?size=lg&key=20b96a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GINGY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GINGY   ")))), trim_right(b"The Gingerbread Man             "), trim_right(b"Welcome to $GINGY, celebrating the festive magic of the gingerbread man! Inspired by Gingy from Shrek and the timeless holiday icon, our token brings laughter, warmth, and a sprinkle of mischief to the season.                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGY>>(v4);
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

