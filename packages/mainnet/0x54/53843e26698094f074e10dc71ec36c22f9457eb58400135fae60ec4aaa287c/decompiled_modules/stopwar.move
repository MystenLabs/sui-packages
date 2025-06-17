module 0x5453843e26698094f074e10dc71ec36c22f9457eb58400135fae60ec4aaa287c::stopwar {
    struct STOPWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOPWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ARCnUgczLncnWUp71csDvRcBXXaNtZLgFxjMjrBUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STOPWAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STOPWAR     ")))), trim_right(b"STOP WAR                        "), trim_right(b"STOPWAR is created by people who believe that silence is no longer an option. Every part of this movement exists to remind the world: we are not powerless, and we will not pretend it's okay.                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOPWAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOPWAR>>(v4);
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

