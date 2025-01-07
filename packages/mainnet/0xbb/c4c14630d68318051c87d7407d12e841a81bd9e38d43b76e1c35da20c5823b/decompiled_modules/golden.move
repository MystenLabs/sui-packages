module 0xbbc4c14630d68318051c87d7407d12e841a81bd9e38d43b76e1c35da20c5823b::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOLDEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDEN>>(0x2::coin::mint<GOLDEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GjqpHLGPUtmBbfGvEAEvVG6GJkfyAozNZb1uJLoppump.png?size=lg&key=0d5e27                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOLDEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOLDEN  ")))), trim_right(b"Golden Age                      "), trim_right(b"As Trump steps back into office, fulfilling his bold promise that Your vote will unleash a new GOLDEN AGE! a glorious new dawn breaks over America. His words, shared in a tweet that ignited hope across the nation, resonate in every heart.                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOLDEN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDEN>>(0x2::coin::mint<GOLDEN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

