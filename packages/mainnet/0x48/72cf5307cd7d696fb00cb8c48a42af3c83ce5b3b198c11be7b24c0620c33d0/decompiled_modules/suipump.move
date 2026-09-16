module 0x4872cf5307cd7d696fb00cb8c48a42af3c83ce5b3b198c11be7b24c0620c33d0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074d4552494c4f4e074d6572696c6f6e727c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6d6572696c6f6e737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d6572696c6f6e737569222c2277656273697465223a2268747470733a2f2f7777772e6d6572696c6f6e2e78797a2f227d2068747470733a2f2f692e696d6775722e636f6d2f7738514f7436552e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

