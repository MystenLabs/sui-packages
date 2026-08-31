module 0x828d78c7b0b80e0b266a18d769c615a8e9b42af906a03d8fe688dacfe2595571::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044359524f064379726f414985014379726f4149204f6666696369616c7c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f6379726f31303931383133222c2274776974746572223a2268747470733a2f2f782e636f6d2f6379726f31303931383133222c2277656273697465223a2268747470733a2f2f782e636f6d2f6379726f31303931383133227d2068747470733a2f2f692e696d6775722e636f6d2f35353541346c542e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

