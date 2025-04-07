module 0x205d120736a69934c9c328121af54b380a1a9b539b072dd76136167dbeb6238b::doog {
    struct DOOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOOG>>(0x2::coin::mint<DOOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x34b2adb3bd4aef3af0b4541735c47b6364d88d1e.png?size=lg&key=2cdb72                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOOG    ")))), trim_right(b"DooggieCoin                     "), trim_right(b"DooggieCoin was launched on the 4th birthday of Dooggies to celebrate the project's provenance as one of the first 10k PFP projects on Ethereum. Who controls the memes, controls the universe!                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOOG>>(0x2::coin::mint<DOOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

