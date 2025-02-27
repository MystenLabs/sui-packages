module 0x42e5663538a43f0b389b1eb9c44f6e8c8ea7a99a2884989e1ef8149bf2d22cbe::sage {
    struct SAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreib7eip2ymkh4b3ureblj64gc3vaddetrxnirhp3lmr2kcckcskhc4                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<SAGE>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAGE    ")))), trim_right(b"TokenSage Coin                  "), trim_right(b"TokenSage Coin powers the AI ecosystem rewarding users for engagement providing exclusive insights and enabling governance features within the AI Agent community                                                                                                                                                               "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SAGE>>(0x2::coin::mint<SAGE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAGE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAGE>>(v3);
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

