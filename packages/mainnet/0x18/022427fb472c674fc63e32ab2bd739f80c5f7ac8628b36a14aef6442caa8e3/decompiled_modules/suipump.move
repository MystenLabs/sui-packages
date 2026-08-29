module 0x18022427fb472c674fc63e32ab2bd739f80c5f7ac8628b36a14aef6442caa8e3::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04544944450853554920544944459502426f726e2066726f6d2074686520646565702063757272656e7473206f66207468652053756920626c6f636b636861696e2c20535549544944452069736e2774206a75737420616e6f74686572206d656d6520636f696ee280946974e2809973206120666f726365206f66206e61747572652e204c6564206279204361707461696e20537569546964652c206f75722063726577206973206368617274696e67206120636f75727365207468726f756768207468652063727970746f2073656173206469726563746c7920746f20746865206d696c6c696f6e2d646f6c6c6172206d61726b2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b56727874366e48764a6577794e545a6b227d2068747470733a2f2f692e696d6775722e636f6d2f5951416e36546f2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

