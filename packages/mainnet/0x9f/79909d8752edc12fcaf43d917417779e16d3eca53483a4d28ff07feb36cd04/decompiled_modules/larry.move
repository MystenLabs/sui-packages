module 0x9f79909d8752edc12fcaf43d917417779e16d3eca53483a4d28ff07feb36cd04::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LARRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LARRY>>(0x2::coin::mint<LARRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FLARRY_LOGO_WIF_SAND_75c8c4e679.jpg&w=640&q=75                                                                                                                                                                                                   ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LARRY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LARRY   ")))), trim_right(b"Larry the Lobster               "), trim_right(b"OFFICIAL LARRY THE LOBSTER Welcome to the Sui Lagoon. Here you can find many ocean dwellers, but none are as much of a MUSCULAR HODL'ing CHAD as $LARRY. $LARRY has a 10 Billion supply, LP is burnt and 0% buy and sell tax                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LARRY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LARRY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LARRY>>(0x2::coin::mint<LARRY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

