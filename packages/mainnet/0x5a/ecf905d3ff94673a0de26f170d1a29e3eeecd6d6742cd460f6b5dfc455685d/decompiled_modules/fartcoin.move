module 0x5aecf905d3ff94673a0de26f170d1a29e3eeecd6d6742cd460f6b5dfc455685d::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Hv32oBLXvsZFX3W1cxyLkRreSzGrEBLc1hh4gqYniz6E.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FartCoin    ")))), trim_right(b"FartCoin                        "), trim_right(x"5748415420495320544845204e4152524154495645204f46202466617274636f696e3f0a0a466f7267657420426974636f696e2c20457468657265756d2c206f7220536f6c616e61546865204e6578742046617274436f696e206973206865726520746f20627265616b2074686520626c6f636b636861696e20616e6420796f7572206e6f737472696c7321204675656c656420627920746865206d6f7374206f7267616e696320666f726d206f66206761732c2074686973206d656d65636f696e2069732064657369676e656420746f20726970207468726f756768207468652063727970746f2073706163652077697468206d6178696d756d2076656c6f6369747920616e64207a65726f207368616d65202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCOIN>>(v4);
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

