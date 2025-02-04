module 0xd0e9b415ef91e89184d1af5633374f31361f9c1b953fc9d14aab9ad515b03f3a::raptor {
    struct RAPTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Fss7oX43YpNNWVnRZugZ1NcngR1j8Ar33Z2dLqYfpump.png?claimId=CgMgZ8HI74LYPfWsMhw75H                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAPTOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAPTOR      ")))), trim_right(b"Philosoraptor                   "), trim_right(b"The blockchain's answer to the universe's big questions, wrapped in a meme. Every transaction is a philosophical debate, and every holder staked in thought. Join the cult where your wallet isn't just growing; it's evolving into the mind of a dinosaur philosopher.                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPTOR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPTOR>>(v4);
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

