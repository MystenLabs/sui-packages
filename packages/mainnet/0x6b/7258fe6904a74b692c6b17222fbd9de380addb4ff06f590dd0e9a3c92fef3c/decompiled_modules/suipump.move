module 0x6b7258fe6904a74b692c6b17222fbd9de380addb4ff06f590dd0e9a3c92fef3c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064d484f4e4b59064d686f6e6b79e4014275696c742074686520686f6d65206f6620244d484f4e4b5920e280942067726166666974692077616c6c732c20686f6e6b20636f756e7465722c20616e64206120636f6d6d756e6974792077616c6c20796f752063616e207461672e204e6f207374726573732c206a7573742076696265732e20f09f90be7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6d686f6e6b795f63686174222c2274776974746572223a2268747470733a2f2f782e636f6d2f4d686f6e6b795f222c2277656273697465223a2268747470733a2f2f6d686f6e6b792e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37613238383530643938366266393565636639626563333735646135326537612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

