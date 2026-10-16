module 0x2a7803434c3e35a8d899340aa20cc9d5ddd2e5469a7d21b265ed00fd18bc04f9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0747524f4b4c45540747726f6b6c6574a60143616c6c65642062792068747470733a2f2f782e636f6d2f4d6a626472616e2076696120404f7572626c617374626f742022404f7572626c617374626f74206c61756e6368202447524f4b4c45542047726f6b6c6574206f6e2073756970756d70207769746820302e30313520626e622c2063726561746f72206665657320746f206164656e6979692e7375692068747470733a2f2f742e636f2f76574e597a6b57393458222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4855746e61664258494141375665462e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

