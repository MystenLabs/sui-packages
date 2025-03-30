module 0x23401a303161b28f2239fd7f389b7bf4e3ed445173cdaf6254ff0bee94ce6c11::eidmbr {
    struct EIDMBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIDMBR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7SLUEKSSAvWmk4G8kB9bgakvHeF4ooAaHLfvDxz1fobK.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EIDMBR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EIDMBR      ")))), trim_right(b"Eid Mubarak from Elon           "), trim_right(b"Introducing EIDMBR, a Solana-based token created as a tribute from Elon Musk to Muslims worldwide in celebration of Eid after completing Ramadan. Blending cultural respect with futuristic vision, EIDMBR symbolizes peace, unity, and progress. This coin is both a message of Eid Mubarak and a token of global harmony on th"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIDMBR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIDMBR>>(v4);
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

