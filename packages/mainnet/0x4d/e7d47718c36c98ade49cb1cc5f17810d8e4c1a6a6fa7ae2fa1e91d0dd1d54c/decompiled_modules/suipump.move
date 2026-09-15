module 0x4de7d47718c36c98ade49cb1cc5f17810d8e4c1a6a6fa7ae2fa1e91d0dd1d54c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034d45470a4d4547206f6e205355493e244d4547206f6e202453554920e298a0efb88e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4d6567616c6f646f6e5f737569227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313837373338343732383338343335323235362f745f704a524932305f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

