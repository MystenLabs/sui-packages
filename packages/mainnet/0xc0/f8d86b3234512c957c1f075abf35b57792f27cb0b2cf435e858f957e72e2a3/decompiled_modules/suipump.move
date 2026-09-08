module 0xc0f8d86b3234512c957c1f075abf35b57792f27cb0b2cf435e858f957e72e2a3::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0441494e550b4164656e69796920496e75d10153454e442049547c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f676f6c645f726f6f746c65742f7374617475732f32303937333936323132313639313633313833222c2274776974746572223a2268747470733a2f2f782e636f6d2f676f6c645f726f6f746c65742f7374617475732f32303937333936323132313639313633313833222c2277656273697465223a2268747470733a2f2f782e636f6d2f676f6c645f726f6f746c65742f7374617475732f32303937333936323132313639313633313833227d2068747470733a2f2f692e696d6775722e636f6d2f4d71425432516c2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

