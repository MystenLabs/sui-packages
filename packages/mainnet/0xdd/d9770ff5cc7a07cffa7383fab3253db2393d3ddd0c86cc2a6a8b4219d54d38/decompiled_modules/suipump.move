module 0xddd9770ff5cc7a07cffa7383fab3253db2393d3ddd0c86cc2a6a8b4219d54d38::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424f4e45520a426f6e657220436f696e7853554920436861696e20e2809320576520617265206865726520666f722067726561746e6573732e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f626f6e6572636f696e6c6f6e67222c2277656273697465223a2268747470733a2f2f626f6e65726f6e6c6f6e672e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f35613631326531326536316330356435373838373130383535386631363461612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

