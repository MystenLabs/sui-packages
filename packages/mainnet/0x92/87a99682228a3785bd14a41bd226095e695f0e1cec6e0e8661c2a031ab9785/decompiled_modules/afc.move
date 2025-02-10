module 0x9287a99682228a3785bd14a41bd226095e695f0e1cec6e0e8661c2a031ab9785::afc {
    struct AFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bw47unND4udstYQYZfriadEJuqpZkQACbFRZZiSHa2LH.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AFC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AFC         ")))), trim_right(b"American Fart Coin              "), trim_right(x"506f77657265642062792066726565646f6d20616e64206265616e7321220a0a5768617420697320416d65726963616e204661727420436f696e3f0a2441464320697320746865206d6f7374206578706c6f73697665206d656d6520746f6b656e206f6e2074686520626c6f636b636861696e2120436f6d62696e696e6720416d65726963616e2070726964652c2066696e616e6369616c2066726565646f6d2c20616e642061206c6974746c6520626974206f66206761732c207468697320636f696e20697320726561647920746f20626c6f7720757020746865206d61726b657420286c69746572616c6c79292e205768657468657220796f75277265206865726520666f7220746865206761696e73206f72206a75737420666f7220746865206d656d65732c206f6e65207468696e67206973206365727461696e2020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFC>>(v4);
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

