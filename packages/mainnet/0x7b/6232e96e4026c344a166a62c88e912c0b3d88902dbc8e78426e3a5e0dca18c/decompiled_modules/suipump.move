module 0x7b6232e96e4026c344a166a62c88e912c0b3d88902dbc8e78426e3a5e0dca18c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04464152540746617274426f79860146617274426f7920697320537569e2809973206669727374206265616e2d706f77657265642073757065726865726f2e0a5a65726f20627261696e732e204d6178696d756d206761732e20496e66696e697465206d656d65732e0a2446415254424f5920e2809420484f4c4420594f5552204e4f534520262053454e442049542e20f09f9a802068747470733a2f2f692e696d6775722e636f6d2f486a486c3378442e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

