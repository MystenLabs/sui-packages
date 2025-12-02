module 0xa12fa40bb6dc09a2a29a925675aded46312e31b5e2b93ce625c0fb91ec22c63d::cshield {
    struct CSHIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSHIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ebf5b77b9a6a73c0f42a6b66ff7e334bda390441c2d7772108a14860bc269687                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CSHIELD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CShield     ")))), trim_right(b"Celestial Shield                "), trim_right(b"Celestial Shield Coin (CShield) reflects a powerful connection between spiritual science and faith-based conviction. CShield recognizes - as both ancient principles and modern insight affirm, that human beings are not bystanders; we are designed with intention. Every individual thought echoes out and creates a reality "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSHIELD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSHIELD>>(v4);
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

