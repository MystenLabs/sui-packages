module 0x44cf3a2875d6626fb2c2f1ea66c5629ca2f6e81a3560d2b210ae17e7613e8e25::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0650414e444153095375692050616e6461ca01426f726e20696e204368696e612e20526169736564206f6e205375692e20426c65737365642062792074686520647261676f6e2e2046756e6465642062792074686520636162616c2e20f09f90bcf09f92a7f09f90897c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f46617450616e6461424e4342222c2274776974746572223a2268747470733a2f2f782e636f6d2f46617450616e6461424e4342222c2277656273697465223a2268747470733a2f2f66617470616e64612e6c6f6c2f227d1f68747470733a2f2f692e696d6775722e636f6d2f71617a566b79532e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

