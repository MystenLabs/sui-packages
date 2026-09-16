module 0x1141f831c9f7d369e75b1a9fd5a51e168015fd576f6972b9b7300154b4fa96fc::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0453544655105368757420746865206675636b2075707c5768656e20666163656420776974682063726974696369736d2066726f6d2074686520636f6d6d756e6974792c204164656e69796920726573706f6e646564207769746820e28098535446552ee2809920446f65732053544655207374616e6420666f7220e280985368757420746865206675636b207570e280993f2068747470733a2f2f692e696d6775722e636f6d2f53366a416758502e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

