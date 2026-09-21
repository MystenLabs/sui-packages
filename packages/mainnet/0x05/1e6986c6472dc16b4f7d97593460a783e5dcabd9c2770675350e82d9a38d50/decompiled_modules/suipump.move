module 0x51e6986c6472dc16b4f7d97593460a783e5dcabd9c2770675350e82d9a38d50::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424c415354086f7572626c617374c601f09f9a80204f5552424c415354207c2024424c4153540a4275696c74206f6e2053756920e29aa10a436f6d6d756e69747920e280a2204d656d657320e280a220426c61737420f09f92a57c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f426c6173746e6f7466756e5f43544f222c2274776974746572223a2268747470733a2f2f782e636f6d2f4f7572626c617374626f74222c2277656273697465223a2268747470733a2f2f742e6d652f426c6173746e6f7466756e5f43544f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65346266393363356565333364303561333439343863323661383432643936642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

