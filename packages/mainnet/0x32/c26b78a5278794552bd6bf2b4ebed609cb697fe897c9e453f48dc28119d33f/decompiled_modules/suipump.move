module 0x32c26b78a5278794552bd6bf2b4ebed609cb697fe897c9e453f48dc28119d33f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0657414c4c45540657414c4c4554d60157616c6c6574206973207665727920696d706f7274616e7420696e206f7572206461696c79206c69666520746f2070726f74656374206d6f6e65792e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f72685f77616c6c6574222c2277656273697465223a2268747470733a2f2f646576656c6f706572732e676f6f676c652e636f6d2f77616c6c65742f67656e657269632f7573652d63617365732f6c696e6b2d66726f6d2d67656e657269632d7061737365733f75746d5f736f757263653d636861746770742e636f6d227d2968747470733a2f2f6b6f6d6d6f646f2e61692f692f6d436f4d50565a505372534e7733666932384564");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

