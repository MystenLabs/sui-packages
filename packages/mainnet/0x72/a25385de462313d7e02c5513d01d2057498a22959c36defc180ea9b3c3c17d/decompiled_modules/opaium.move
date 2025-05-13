module 0x72a25385de462313d7e02c5513d01d2057498a22959c36defc180ea9b3c3c17d::opaium {
    struct OPAIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPAIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4HuSTfcJruukNbhrF9sc5iKrMeGxNBs6XpQ1L2hUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OPAIUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OPAIUM      ")))), trim_right(b"opaium                          "), trim_right(b"Opaium is a music label operating as a DAO (Decentralized Autonomous Organization), leveraging governance to make collective decisions on signing artists, defining terms, managing distribution, streaming, handling rights, and more. Tokens in the developer wallet will be allocated for the DAO treasury.                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPAIUM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPAIUM>>(v4);
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

