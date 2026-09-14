module 0x89fd919bc6d243feccc9ab47a445dfad407c3f17b8f0e54bce8aa3e6de99c6e5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055355494d45055355494d454f5375696d65206973206e6f74206a7573742061206d656d652c20697427732061206d6f76656d656e74217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f7375696d655f5f227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f313635323031303933383836383837353237312f4e554e504a5166435f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

