module 0xa3770dc6a31823ae42293f463a65fe5d2ca4a286679ee9475b55efe09e71204::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"035355490c7468696e6b696e6720636174a20143616c6c65642062792068747470733a2f2f782e636f6d2f4d6a626472616e2076696120404f7572626c617374626f742022476d202453554920476d20404f7572626c617374626f74206465706c6f7920746f6b656e206f6e2053756970756d702e2e2e6e616d653a207468696e6b696e6720636174207469636b65722024484d4d4d20696d6167652068747470733a2f2f742e636f2f6d7165717346446a346e222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f48537376704d56583041414a674d352e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

