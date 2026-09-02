module 0x1bdc8cc28d8288675be9d634c160d4fe2a52b18e85fa5bbdc9a79df018a3280a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044d414741074d4147414942419501536f2067656e746c652c20736f20676f6f642e7c7c7b2274656c656772616d223a2268747470733a2f2f646973636f72642e636f6d2f696e766974652f5959424578685378222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d616761696261736f67656e746c65222c2277656273697465223a2268747470733a2f2f6d6167616962612e78797a2f65732f227d2268747470733a2f2f6d6167616962612e78797a2f6d61676169626974612e77656270");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

