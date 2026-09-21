module 0x1239d7abe80414cfb5ec2e86af40060646f3e4bc1213bbf36b8d5ecdc2377c0e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0655544f5049410655544f504941930143616c6c65642062792068747470733a2f2f782e636f6d2f42656c61796e65736873656e6265742076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f79206120746f6b656e204e616d653a2055544f504941205469636b65723a202455544f50494120496d616765203a2068747470733a2f2f742e636f2f51794f55634364483945222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485376615f342d576b4141385556502e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

