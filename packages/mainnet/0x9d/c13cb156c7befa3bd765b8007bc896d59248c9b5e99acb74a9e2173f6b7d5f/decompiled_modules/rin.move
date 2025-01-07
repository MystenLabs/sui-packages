module 0x9dc13cb156c7befa3bd765b8007bc896d59248c9b5e99acb74a9e2173f6b7d5f::rin {
    struct RIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729244500869-1bb87d41d15fe27b500a4bfcde01bb0e.png                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIN     ")))), trim_right(b"RIN TIN TIN                     "), trim_right(b"RIN TIN TIN - THE LIFE AND THE LEGEND OF THE WORLD'S MOST FAMOUS DOG. Rin Tin Tin was a real-life German Shepherd who rose to stardom during the silent film era of Hollywood.                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIN>>(v4);
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

