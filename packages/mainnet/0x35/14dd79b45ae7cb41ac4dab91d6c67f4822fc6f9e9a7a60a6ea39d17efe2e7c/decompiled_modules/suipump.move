module 0x3514dd79b45ae7cb41ac4dab91d6c67f4822fc6f9e9a7a60a6ea39d17efe2e7c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03535452085374726174656779537c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4d6963726f5374726174656779222c2277656273697465223a2268747470733a2f2f782e636f6d2f4d6963726f5374726174656779227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61663535326431356364633266643438306662336664343239343063613335612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

