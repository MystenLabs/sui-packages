module 0x25fedc10424901f6ac5e7bccdea5e1c6d621d1a705c726b382c0e1648b55b70f::wigga {
    struct WIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BzTDXRjeDmwQVDrYBmdZsoQQhZ7LNjeJVc11anL8pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WIGGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WIGGA       ")))), trim_right(b"White Nigga                     "), trim_right(b"$WIGGA  The Coin Your Racist Uncle Warned You About Born in the suburbs, baptized in Hennessy, $WIGGA is the first memecoin to come with a mixtape and a court date. Its got the complexion for protection, but the soul of a dude whos been to juvie once and wont shut up about it. No roadmap. No utility. Just vibes, bad de"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGA>>(v4);
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

