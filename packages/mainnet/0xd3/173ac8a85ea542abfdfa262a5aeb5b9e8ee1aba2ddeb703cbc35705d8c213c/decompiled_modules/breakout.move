module 0xd3173ac8a85ea542abfdfa262a5aeb5b9e8ee1aba2ddeb703cbc35705d8c213c::breakout {
    struct BREAKOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAKOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2ZoVtwFzd9unQXEGq19XjMRn8zF3i81o5kNK2u8Tpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BREAKOUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BREAKOUT    ")))), trim_right(b"BREAKOUT                        "), trim_right(b"Breakout is here. The walls are crumbling, the limits are gone. This is the momentthe surge, the rise, the unstoppable force. Keep your head high and your eyes forward. The breakout is now.  Anon                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAKOUT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAKOUT>>(v4);
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

