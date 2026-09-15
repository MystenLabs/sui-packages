module 0x6dc26c7dbf518fdd4ced904fcc4a96a627bad668c3a76eea022a1e40839021c4::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0642414c4c53590d42616c6c7379204f6e20537569830142616c6c737920697320796f757220756e61706f6c6f676574696320646567656e2073706972697420616e696d616c2e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f62616c6c73796f6e737569222c2277656273697465223a2268747470733a2f2f6c696e6b74722e65652f62616c6c73796f6e737569227d2068747470733a2f2f692e696d6775722e636f6d2f594c4c796a71302e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

