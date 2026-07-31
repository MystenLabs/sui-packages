module 0x97a2a3c0773e4bab984c205c9306b524ee5e5d64d4cae58b38e9daf569596e87::jypn {
    struct JYPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYPN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/bB2KphV9gY_kymhMKy6qgt0oXnJrl7u0YtMLOGHXpwc";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/bB2KphV9gY_kymhMKy6qgt0oXnJrl7u0YtMLOGHXpwc"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JYPN>(arg0, 6, trim_right(b"JYPN"), trim_right(b"JYPNXXA"), trim_right(b"JYPNXAAA"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JYPN>>(0x2::coin::mint<JYPN>(&mut v5, 1000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYPN>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JYPN>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JYPN>>(v4);
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

