module 0xf9e9d017150f9ded986ee1b9e4ea53faa7805dc5972a616ef12a0bf5206eb5e2::usct {
    struct USCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USCT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/undefined";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/undefined"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USCT>(arg0, 9, trim_right(b"USCT"), trim_right(b"USCT  "), trim_right(b"The issuer (Tether Limited) claims to hold US dollars or other assets equivalent in value to the USDT in circulation as reserves."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USCT>>(0x2::coin::mint<USCT>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USCT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USCT>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USCT>>(v4);
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

