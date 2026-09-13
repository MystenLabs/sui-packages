module 0xe53f319d2a84df77159070dcb25e616a12b612860e9af8c0b9a0e2ac1ec2d053::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05534455434b077375696475636bcc015375694475636b2077617320626f726e2066726f6d20746865207761766573206f66205375692e200a536d616c6c2c20666561726c6573732c20616e6420616c77617973207377696d6d696e6720666f72776172640a5375694475636b2063617272696573206f6e65206d697373696f6e3a206272696e672066756e2c206c75636b2c20616e64206368616f7320746f20746865205375692065636f73797374656d7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f53756950756d705f53554d50227d5368747470733a2f2f63646e2e70686f746f746f75726c2e636f6d2f667265652f323032362d30392d31332d38303232346364372d316532342d343036372d616563612d3161656465653133666437652e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

