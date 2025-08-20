module 0x71193784a6c54425279d2d2df3c70c694a8e424a5018cf5103dfc4ead5a89c24::slother {
    struct SLOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6Jq9jgvB9eoDBLrYHZcbDNF9k2cKCAhRCLbxPmn5oAbQ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SLOTHER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SLOTHER     ")))), trim_right(b"The Harry Slother               "), trim_right(b"The Harry Slother  The Chillest Spell in Crypto  Harry Slother isnt just a coin  its a movement of calm, calculated magic in a chaotic market. Powered by community, guided by wisdom (and naps), Harry Slother brings the perfect blend of meme culture and Web3 wizardry. Whether you're here for the vibes, the spells, or th"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTHER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTHER>>(v4);
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

