module 0x756404eff1a289b66e3c4daefe2a49fa6b0cc7efd2e40261995fe0cdec2984e0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034d4f4f0a4d4f4f204f4e20535549890147657420726561647920746f206d696c6b20746865206d656d65636f696e2068797065207769746820244d6f6f206f6e20746865205375694e6574776f726b7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6d6f6f5f737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d6f6f5f6f6e5f737569227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313834303534373036303032373839393930342f5664304f376b77665f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

