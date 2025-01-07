module 0xa7f5660f5db4448e95ee65c2f90207a0801700a0421ed63fc94685d9121e1560::nola {
    struct NOLA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NOLA>>(0x2::coin::mint<NOLA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/arbitrum/0xe934ab7e98d81e39477b1e47b961876c2d902598.png?size=lg&key=75ee4d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOLA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NOLA    ")))), trim_right(b"NOLA                            "), trim_right(b"Join Nola, the infamous Sui kitty who is dominating the space right now. This feline is ready to visit the moon and beyond, just needs your support! Visit our community and grab a bag, because Nola is our favorite!                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOLA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOLA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NOLA>>(0x2::coin::mint<NOLA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

