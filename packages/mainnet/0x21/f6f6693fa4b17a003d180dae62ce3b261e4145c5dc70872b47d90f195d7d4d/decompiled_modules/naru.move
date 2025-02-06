module 0x21f6f6693fa4b17a003d180dae62ce3b261e4145c5dc70872b47d90f195d7d4d::naru {
    struct NARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreiahekexlmftllissabqg7hlnsglf7mbcb2ls2whk5suwstpbhe3qy                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<NARU>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NARU    ")))), trim_right(b"Naruto                          "), trim_right(b"Naruto is taken                                                                                                                                                                                                                                                                                                                 "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<NARU>>(0x2::coin::mint<NARU>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NARU>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NARU>>(v3);
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

