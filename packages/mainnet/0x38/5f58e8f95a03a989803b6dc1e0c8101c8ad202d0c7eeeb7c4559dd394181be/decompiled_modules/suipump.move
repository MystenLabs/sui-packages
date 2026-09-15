module 0x385f58e8f95a03a989803b6dc1e0c8101c8ad202d0c7eeeb7c4559dd394181be::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0546494e49580546696e69788c01426f726e206f6e2046697265204275696c64206f6e205375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f46696e69786f6e737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f46696e69786f6e737569222c2277656273697465223a2268747470733a2f2f7777772e66696e69787375692e78797a2f227d2068747470733a2f2f692e696d6775722e636f6d2f507765337a386e2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

