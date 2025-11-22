module 0xd7a6ba04b08d91d48d29e7edc5f22f0c3a50ea219ab1addb681fd192efbff350::spsn {
    struct SPSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"55c1f791c0b5f2ad2d43f0ae9d87d03ba030af09cdfef6973e3fd407ee82f4a4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPSN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPSN        ")))), trim_right(b"South Park Sucks Now            "), trim_right(b"The phrase \"South Park sucks now\" refers to a recent storyline in the show itself, originating from the \"South Park sucks now\" episode that satirizes online fan complaints. In the plot, Stan starts an online page with the same name after feeling the show has become too political, which then leads him to start a cryptoc"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPSN>>(v4);
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

