module 0x145deca540b06570b017c1314c07220304ba521a21aed07617f4ef3a82a3e1c1::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044c4f5742044c4f57425f6c6f7762e4bbace69da5e5889be980a0e5a587e8bfb9e590a7efbc8ce4b9b06c6f7762e4baabe58f976c6f7762e4babae7949fefbc8ce8bf9e6c6f7762e983bde4b9b0e4b88de8b5b7efbc8ce4bda0e8bf9e6c6f7762e983bde4b88de5a6822068747470733a2f2f692e696d6775722e636f6d2f633367475131562e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

