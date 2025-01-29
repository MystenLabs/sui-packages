module 0xc96d6aa230b8cbcac8b59f9754f76abddd642a8c0a7dd33dfae27612545b2541::clones {
    struct CLONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLONES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2ocRmgxFPnfvTJzT8mMTJDFDSFq5BmXFPRRPdEf3WT9r.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLONES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"clones      ")))), trim_right(b"Clones Coin                     "), trim_right(b"Clones allows you to create an AI-powered video replica of yourself or someone of your choice to answer questions, serve as your virtual assistant, set reminders, and make calls. Train it to know everything about you, turning it into your enduring online legacy! The Clones coin is a community based operates on the Sola"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLONES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLONES>>(v4);
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

