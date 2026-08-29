module 0xb01beba8311e859e6ad6fb46e7dd8ec1ab48b77523e6e100e1972502d449974e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0847524f4b534e41520b47524f4b204c45534e4152b1015374657020696e746f20746865206d656d657461676f6e207769746820796f75722074616b653f2042616420696465612e2047726f6b204c65736e617220646f65736e277420646f20726562757474616c732c20686520646f65732067726f756e6420616e6420706f756e642e20546170206f7574206f722067657420666f6c6465642e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f487573746c655f546f6b656e5f4270227d2068747470733a2f2f692e696d6775722e636f6d2f694435466b4b6f2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

