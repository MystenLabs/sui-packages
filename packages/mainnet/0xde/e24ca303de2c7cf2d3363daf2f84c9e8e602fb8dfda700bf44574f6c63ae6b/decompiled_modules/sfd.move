module 0xdee24ca303de2c7cf2d3363daf2f84c9e8e602fb8dfda700bf44574f6c63ae6b::sfd {
    struct SFD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SFD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFD>>(0x2::coin::mint<SFD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SFD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7rX3w3KKWssxmbEqgd8UNuQZAL1RF7L7Np4higjfpump.png?size=lg&key=aa98dd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SFD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SFD     ")))), trim_right(b"Santa Fart Dust                 "), trim_right(b"One cold winter night, Santa realized that delivering gifts wasnt enough he needed to add a little extra magic to the season. So, with a hearty laugh, he harnessed the power of fart dust to fuel his sleigh and deliver not just presents but profits!                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFD>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SFD>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SFD>>(0x2::coin::mint<SFD>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

