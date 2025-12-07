module 0x8e77ee6a6e6547476b577991d49931f2e17f41788cd18c672611cdb4d5437bbc::ssoq {
    struct SSOQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSOQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5deae5bfafc05198ae4ae76f338e759e21ea23653d77e6b5198e67048afaf11e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SSOQ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"sSOQ        ")))), trim_right(b"SoQuBit                         "), trim_right(b"SoQuBit is the official Solana representation of the post-quantum Soqucoin - SOQ  PoW blockchain. Soqucoin  (the \"So Quantum Coin\") features advanced ML-DSA-44 post-quantum signatures and implements cutting-edge protocols and algorithms for unrivaled security AND performance. A SoQuBit bridge to native SOQUCOIN is plan"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSOQ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSOQ>>(v4);
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

