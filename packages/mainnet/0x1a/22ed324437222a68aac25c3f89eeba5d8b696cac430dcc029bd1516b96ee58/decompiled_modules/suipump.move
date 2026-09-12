module 0x1a22ed324437222a68aac25c3f89eeba5d8b696cac430dcc029bd1516b96ee58::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554946524f470753756946726f677f5468652046726f67206f66205375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f73756966726f67636f696e222c2274776974746572223a2268747470733a2f2f782e636f6d2f73756966726f67636f696e222c2277656273697465223a2268747470733a2f2f73756966726f672e66756e2f227d1f68747470733a2f2f692e696d6775722e636f6d2f486c334f6b4d7a2e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

