module 0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054a41534f4e054a61736f6eb0015448452053554920445249564552204a5553542050554c4c45442055502e20244a41534f4e206973206f6e207468652053756920636861696e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6a61736f6e5f7375695f32303236222c2274776974746572223a2268747470733a2f2f782e636f6d2f6a61736f6e5f7375695f5f222c2277656273697465223a2268747470733a2f2f6a61736f6e2d7375692e6f6e6c696e65227d2068747470733a2f2f692e696d6775722e636f6d2f636557704d4e772e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

