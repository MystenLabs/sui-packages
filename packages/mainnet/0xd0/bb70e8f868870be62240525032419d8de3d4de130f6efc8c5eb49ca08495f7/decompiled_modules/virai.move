module 0xd0bb70e8f868870be62240525032419d8de3d4de130f6efc8c5eb49ca08495f7::virai {
    struct VIRAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VIRAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VIRAI>>(0x2::coin::mint<VIRAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x32b0067d430c27baf1a714f420cd88005f2d2a22.png?size=lg&key=5e1ac0                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIRAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIRAI   ")))), trim_right(b"Viral AI                        "), trim_right(b"Viral AI $VIRAI is a crypto-powered engagement and promotion platform designed to revolutionize how cryptocurrency projects boost their visibility and engagement on social media, particularly on Twitter.                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIRAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIRAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VIRAI>>(0x2::coin::mint<VIRAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

