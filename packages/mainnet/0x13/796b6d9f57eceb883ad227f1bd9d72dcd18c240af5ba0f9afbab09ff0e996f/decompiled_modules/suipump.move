module 0x13796b6d9f57eceb883ad227f1bd9d72dcd18c240af5ba0f9afbab09ff0e996f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"035348520d5368617265734e6574776f726b6b4f776e2074686520636861696e20796f75207472616465206f6e2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f5348524e6574776f726b222c2274776974746572223a2268747470733a2f2f782e636f6d2f5368617265734e6574776f726b227d2068747470733a2f2f692e696d6775722e636f6d2f363670564462622e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

