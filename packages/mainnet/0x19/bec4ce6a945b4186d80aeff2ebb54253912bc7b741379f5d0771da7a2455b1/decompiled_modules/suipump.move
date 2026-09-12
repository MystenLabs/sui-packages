module 0x19bec4ce6a945b4186d80aeff2ebb54253912bc7b741379f5d0771da7a2455b1::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0553554943410c5355494341205241424249548f01686520507572706c652043726561747572652074616b696e67206f766572204a6170616e2773207261696c7320616e642074686520676c6f62616c206d656d652065636f6e6f6d792e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f6a75705f656e6a6f796f6f72732f7374617475732f32303937333930393337343038323436313030227d2068747470733a2f2f692e696d6775722e636f6d2f75304b776368652e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

