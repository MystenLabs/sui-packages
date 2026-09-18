module 0x750dced8df78ab2c773d9d54247fe823a31fe9f076b8c704cd2ae563d1bd2a77::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"09545552544c4553554909547572746c65737569f001f09f90a2f09f92a720545552544c4520782053554920f09f92990a0a536c6f772c207374656164792c20616e64206275696c7420746f206c6173742e20f09f90a2f09f9a800a41206375746520747572746c6520706f776572656420627920746865205355492065636f73797374656d2e20f09f8c8ae29ca80a0a547572746c65206d6f76657320736c6f772e20535549206d6f76657320666173742e20e29aa17c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f73756970756d7031222c2277656273697465223a2268747470733a2f2f747572746c652e65706f63687375692e636f6d2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37316364353639313265363633646330373337633930333832356237366166372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

