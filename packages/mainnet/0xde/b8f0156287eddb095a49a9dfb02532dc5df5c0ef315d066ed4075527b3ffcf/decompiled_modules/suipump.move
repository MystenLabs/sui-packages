module 0xdeb8f0156287eddb095a49a9dfb02532dc5df5c0ef315d066ed4075527b3ffcf::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03525955065375695279757f527975206a6170616e65736520647261676f6e2063756c747c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f5375696f6e527975222c2274776974746572223a2268747470733a2f2f782e636f6d2f53756972797573222c2277656273697465223a2268747470733a2f2f5375695279752e66756e227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f35306139643537346233623039323537366539666466333739303563313766642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

