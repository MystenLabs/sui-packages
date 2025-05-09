module 0x6231f4f217f639386dd4e716c8548725cdbd7d6357ad5e3ae45576f1855eaf57::senti {
    struct SENTI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SENTI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SENTI>>(0x2::coin::mint<SENTI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SENTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0xee20edd0cd31b499796b4dc9db5fd0eb6bb17961.png?size=lg&key=ec517d                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SENTI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SENTI   ")))), trim_right(b"Senti AI                        "), trim_right(b"AI companion on Sui. Tag @SentiAI_Sui to deploy tokens, manage DeFi, and get blockchain insights fast on X!                                                                                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENTI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SENTI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SENTI>>(0x2::coin::mint<SENTI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

