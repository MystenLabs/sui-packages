module 0x43e9eee389968251735659e2c00a0cb3876424aaac9a8ebaae0c70c733f510b5::l2e {
    struct L2E has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<L2E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<L2E>>(0x2::coin::mint<L2E>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: L2E, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/31wwBuh6UAUbGK3S4ANYz1SwC21Va5X2MRj6Gvq6pump.png?size=lg&key=671607                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<L2E>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"L2E     ")))), trim_right(b"L2Eapp                          "), trim_right(b"Helping new users set up phantom wallets & buy Sui.                                                                                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L2E>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L2E>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<L2E>>(0x2::coin::mint<L2E>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

