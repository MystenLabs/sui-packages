module 0xdbc622a99330048985b3d77cda5dbf4c414c090af4f359e751e63121b0ec5bef::eic {
    struct EIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9m3nh7YDoF1WSYpNxCjKVU8D1MrXsWRic4HqRaTdcTYB.png?claimId=1jElnBZd_k7-aLMH                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EIC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EIC         ")))), trim_right(b"EVERYTHING IS COMPUTER          "), trim_right(x"2745766572797468696e6720697320436f6d7075746572206973206120766972616c206d656d65207468617420626567616e207769746820612063617375616c2072656d61726b2066726f6d20507265736964656e74205472756d7020647572696e67205465736c61206576656e742e2054686520696e7465726e6574207365697a6564206f6e2069742c207475726e696e67207468652070687261736520696e746f20616e206162737572642079657420737472616e67656c792070726f666f756e642074616b65206f6e207265616c6974792c20746563686e6f6c6f67792c20616e6420616363656c65726174696f6e69736d2e0a0a546865206d656d6520616c69676e73207769746820636f6e6365707473206c696b652070616e636f6d7075746174696f6e616c69736d202874686520696465612074686174207468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIC>>(v4);
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

