module 0xc6ce200bda3a93cce4f6343a6c12b988c2248fff558bbe182a8c5dee1e908411::thrive {
    struct THRIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THRIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C4NX9D3ty7E3TdaCCAFoHUz2Bgh19WMKcy32oPro6468.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THRIVE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Thrive      ")))), trim_right(b"Thrive Token                    "), trim_right(b"Thrive-Token blends AI and blockchain, powered by Thrive. Its a decentralized platform connecting developers, users, for personalized insights. Deploy AI models, access services, or provide compute powerall rewarded with Thrive. Secure, scalable, and innovative, In Crypto we THRIVE!                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THRIVE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THRIVE>>(v4);
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

