module 0x3ac535d381192dba315f52b2fd9072dd7ecfc21143dccb74e81499013c40599f::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2DJAyCbx9HkHiPsyJdZmgio9Pu9p1w6jujXDo5h4pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COKE        ")))), trim_right(b"Coke on Sol                     "), trim_right(b"COKE V2 is back on the blockpure, uncut, and hitting harder than ever. This aint a soft relaunch; its a full-on re-up. Weve cooked up a cleaner batch with zero filler, just straight fire. Whether youre here to flip or stash, COKEs got that premium grade supply. Dont get left drygrab your bag and ride the wave.         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKE>>(v4);
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

