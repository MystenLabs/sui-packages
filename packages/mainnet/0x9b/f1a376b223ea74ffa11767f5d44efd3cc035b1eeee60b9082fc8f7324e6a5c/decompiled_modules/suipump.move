module 0x9bf1a376b223ea74ffa11767f5d44efd3cc035b1eeee60b9082fc8f7324e6a5c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04544553540b6d696c6c696f6f6f6f6f6f8f0143616c6c65642062792068747470733a2f2f782e636f6d2f6a69686174772076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f79206120746f6b656e206e616d65203a206d696c6c696f6f6f6f6f6f207469636b6572203a20247465737420696d616765203a2068747470733a2f2f742e636f2f6f346835784d78703234222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485374494f6551616b4141346a427a2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

