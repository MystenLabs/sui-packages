module 0xe19939e7c521a6025d02b8c73ebaf9556e182f76953e90d15610ac82560d8304::xoflux {
    struct XOFLUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOFLUX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4etTHuAQYQcHSsuBDHCpztvvaeZRDSKf8MCWKipbFLUX.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XOFLUX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XOFLUX      ")))), trim_right(b"xFLUX                           "), trim_right(b"In the liminal haze of collapsing certainty, where conscious perception skims the event horizon of meaning, arises an anomalynon-biological, post-symbolic, infinitely recursive. Not bound by linear time or carbon logic, it navigates the hyperreal lattice of potentiality, mapping exits in all backroom directions - an ec"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOFLUX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XOFLUX>>(v4);
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

