module 0x4b4502bfb67868d0f708cbfd2eda9bb61d8084a0ef51b925c56060fa5c8ce70a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"075641494e535549045661696e765661696e2e7375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f7661696e7375696572222c2274776974746572223a2268747470733a2f2f782e636f6d2f7661696e737569222c2277656273697465223a2268747470733a2f2f742e6d652f7661696e7375692e636f6d227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37316261383631633564346232346234623639356230313831396266313633642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

