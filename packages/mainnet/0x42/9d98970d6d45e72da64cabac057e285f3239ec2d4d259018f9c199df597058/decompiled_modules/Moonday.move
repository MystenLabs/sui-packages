module 0x429d98970d6d45e72da64cabac057e285f3239ec2d4d259018f9c199df597058::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/04fbebf7-cc7a-4521-8bea-29f96cbe4438/512+gnAV1kL.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/04fbebf7-cc7a-4521-8bea-29f96cbe4438/512+gnAV1kL.jpg"))
        };
        let v1 = b"aGAMER";
        let v2 = b"bGamer Coin";
        let v3 = b"cGamer coin";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 185360668;
        if (185360668 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

