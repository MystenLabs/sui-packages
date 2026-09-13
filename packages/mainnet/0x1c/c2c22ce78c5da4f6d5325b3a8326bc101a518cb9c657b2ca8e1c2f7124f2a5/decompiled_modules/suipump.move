module 0x1cc2c22ce78c5da4f6d5325b3a8326bc101a518cb9c657b2ca8e1c2f7124f2a5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05534455434b075375696475636b7b536d616c6c2c20666561726c6573732c20616e6420616c77617973207377696d6d696e6720666f72776172642c205375694475636b2063617272696573206f6e65206d697373696f6e3a206272696e672066756e2c206c75636b2c20616e64206368616f7320746f20746865205375692065636f73797374656d2e1768747470733a2f2f6962622e636f2f7853666e6a725173");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

