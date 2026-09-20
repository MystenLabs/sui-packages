module 0x50d1acf7421d44c63dcbc3f43b9b9e7f8a75d11677f8034055fedf4b88bbb703::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065041544152410950617461726141707097014578706c6f7265205375694e6574776f726b2077697468205061746172617c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f506174617261417070222c2274776974746572223a2268747470733a2f2f782e636f6d2f506174617261417070222c2277656273697465223a2268747470733a2f2f6c696e6b74722e65652f7061746172615f6f6666696369616c227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62393632656133396662653165653331356131653564376662303866333037322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

