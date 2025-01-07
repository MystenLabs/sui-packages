module 0xdbcbe2d8258f0473f58e266bff3898f04712a705194a18b5774d109cc6033564::booh {
    struct BOOH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOOH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOH>>(0x2::coin::mint<BOOH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOOH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xc18b4c1e0b4d4d0f1e9627f25399f5073079ac3d.png?size=lg&key=c882db                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOOH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOOH    ")))), trim_right(b"BoohToken                       "), trim_right(b"The Meme Reaper has risen from the depths and is set to introduce ghosting, giving Meme Coins eternal life in Booh World. They will dive into Booh Brawlers, the most unhinged tournament in the cryptosphere, where they will battle fiercely and flex their unique powers.                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOOH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOH>>(0x2::coin::mint<BOOH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

