module 0x158c5f4f975001f24e3d7bddbd6496a3c2d945880d4b44615d3b79e8f35896e6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044c4144530b4d797374656e204c616473ae014d797374656e204c616273206275696c74205375692e0a546865204c616473206275696c7420746865206d656d652e0a244c414453206f6e205375692e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f4d797374656e4c616473222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d797374656e6c616473222c2277656273697465223a2268747470733a2f2f6d797374656e6c6164732e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37383764396163363763656565346465616164626132666665633131653464392e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

