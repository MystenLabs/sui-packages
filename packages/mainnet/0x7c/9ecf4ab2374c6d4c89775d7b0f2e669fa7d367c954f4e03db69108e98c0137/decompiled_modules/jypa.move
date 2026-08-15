module 0x7c9ecf4ab2374c6d4c89775d7b0f2e669fa7d367c954f4e03db69108e98c0137::jypa {
    struct JYPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/p3c2aU-E5cz2k4ty0orRYMMxkauESJUXbO3TlIIn9EM";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/p3c2aU-E5cz2k4ty0orRYMMxkauESJUXbO3TlIIn9EM"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JYPA>(arg0, 6, trim_right(b"JYPA"), trim_right(b"JYPAXXA"), trim_right(b"JYPAA"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JYPA>>(0x2::coin::mint<JYPA>(&mut v5, 1000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYPA>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JYPA>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JYPA>>(v4);
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

