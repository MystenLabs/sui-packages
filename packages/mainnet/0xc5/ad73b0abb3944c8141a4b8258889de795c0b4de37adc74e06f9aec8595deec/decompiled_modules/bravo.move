module 0xc5ad73b0abb3944c8141a4b8258889de795c0b4de37adc74e06f9aec8595deec::bravo {
    struct BRAVO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRAVO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRAVO>>(0x2::coin::mint<BRAVO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BRAVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/x9JZdgyqxfakyn7km2Y4KVANBnP19AEVw5vWNxgpump.png?size=lg&key=0a7d71                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRAVO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRAVO   ")))), trim_right(b"JOHNNY BRAVO                    "), trim_right(b"Hey there, handsome! Oh wait, that's me. Welcome to the one and only digital kingdom of Johnny Bravo! This isnt just a token, babyit's a lifestyle. So, buckle up, flex those biceps, and lets strut through this website like we're walking down the coolest beach boulevard.                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAVO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRAVO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BRAVO>>(0x2::coin::mint<BRAVO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

