module 0xf9c3b7e61f02a33ea574606ccb820e6f62fa7de3a9a0ed08d5fa5b71c1a2e59b::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUBBLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BUBBLE>>(0x2::coin::mint<BUBBLE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xe9689028ede16c2fdfe3d11855d28f8e3fc452a3.png?size=lg&key=f86fc5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUBBLE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUBBLE  ")))), trim_right(b"Bubble                          "), trim_right(b"BUBBLE is the utility token driving the Imaginary World, used for gaming, merchandise, and content.                                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUBBLE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUBBLE>>(0x2::coin::mint<BUBBLE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

