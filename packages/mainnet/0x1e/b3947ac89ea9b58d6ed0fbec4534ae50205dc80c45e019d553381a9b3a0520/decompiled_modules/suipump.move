module 0x1eb3947ac89ea9b58d6ed0fbec4534ae50205dc80c45e019d553381a9b3a0520::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06505552504c4510507572706c65204461726b2034343433a00143616c6c65642062792068747470733a2f2f782e636f6d2f537569576f726c64426c6f782076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f7920746f6b656e2c206e616d65203a20507572706c65204461726b20343434332c205469636b6572203a20752f505552504c45206f6e2053756970756d702068747470733a2f2f742e636f2f7a6f366b6f3145377a32222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4853756550793762414141694579532e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

