module 0xf19d8c13bb56ab1775f4c2c018cab1774cd3b67fd242b059fe989c7f4ccb2358::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074c4f4144494e470d416c706861204c6f6164696e6791024164656e6979692073616964205375692073686f756c6420626520746865206265737420706c61636520696e2074686520776f726c6420746f207472616465206d656d65732c2073746f636b732c20626f6e64732c20616e6420636f6d6d6f6469746965732e205468656e206865207265706c6965643a20e2809c616c706861206c6f6164696e677c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f323039393932383234363833333838313339363f733d3230222c2277656273697465223a2268747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f323039393932383234363833333838313339363f733d3230227d2068747470733a2f2f692e696d6775722e636f6d2f534c4e5054414c2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

