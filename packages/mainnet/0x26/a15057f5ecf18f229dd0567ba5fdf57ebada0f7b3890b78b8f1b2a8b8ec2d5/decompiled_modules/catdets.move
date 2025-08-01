module 0x26a15057f5ecf18f229dd0567ba5fdf57ebada0f7b3890b78b8f1b2a8b8ec2d5::catdets {
    struct CATDETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c9fd9d734319df3ccbf38e8f043ea3da20aa094d6d8a57703d736a80e14c910c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATDETS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CATDETS     ")))), trim_right(b"The Jupiverse Cult              "), trim_right(x"57652061726520746865204a757069766572736520436174646574732e0a576527726520616c6c2061626f757420737072656164696e67206c6f766520616e6420706f73697469766974792e0a4361746465747320656d627261636573205050502e0a4361746465747320617265204a757069766572736520477561726469616e732e0a4a757020697320486f6d652e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDETS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDETS>>(v4);
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

