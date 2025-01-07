module 0x4ae49fac0a3bb424e9f6932ea6ea1d437fcab1a9cb9ddba9a006158ccc346009::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ICE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ICE>>(0x2::coin::mint<ICE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A5v9vstRtEMXbTakyASPo1dwz33hH8RFrX8GamSH3ice.png?size=lg&key=731800                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ICE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ICE     ")))), trim_right(b"ICE                             "), trim_right(b"Icethe first Pokmon of crypto! A cool, cute furball with frosty vibes, Ice is here to chill out the blockchain and keep things steady in a world where everything heats up fast. As the ultimate companion for navigating the crypto wilds, Ice brings resilience, fun, and a refreshing perspective to holders.                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ICE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ICE>>(0x2::coin::mint<ICE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

