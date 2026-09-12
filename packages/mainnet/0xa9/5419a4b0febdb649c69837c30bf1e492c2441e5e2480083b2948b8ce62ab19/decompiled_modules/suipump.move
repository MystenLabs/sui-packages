module 0xa95419a4b0febdb649c69837c30bf1e492c2441e5e2480083b2948b8ce62ab19::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05535549414906537569204169a60141492d706f776572656420616e616c797469637320666f722070726564696374696f6e206d61726b6574732c2061697264726f7020747261636b696e6720616e642077616c6c6574206d6f6e69746f72696e672c6275696c74206f6e205375697c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f7375696169636f696e222c2277656273697465223a2268747470733a2f2f73756961692e70726f2f227d2068747470733a2f2f692e696d6775722e636f6d2f626a7a654a766a2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

