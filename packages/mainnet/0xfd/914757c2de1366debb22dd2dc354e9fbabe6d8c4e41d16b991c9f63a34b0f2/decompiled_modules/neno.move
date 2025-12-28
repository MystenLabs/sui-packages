module 0xfd914757c2de1366debb22dd2dc354e9fbabe6d8c4e41d16b991c9f63a34b0f2::neno {
    struct NENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NENO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/LOoyfx1uszyLeNfDcQlXLgHHIjEHDzK9m6MUQdyvyLI";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/LOoyfx1uszyLeNfDcQlXLgHHIjEHDzK9m6MUQdyvyLI"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<NENO>(arg0, 9, trim_right(b"Neno"), trim_right(b"NEMO"), trim_right(b"Nemo Protocoi Commununity"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NENO>>(0x2::coin::mint<NENO>(&mut v5, 1000000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NENO>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NENO>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NENO>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

