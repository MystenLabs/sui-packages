module 0xbba8522da9fc5d6055017c3c030c545d83598cd5f58a872efb0689ed864e5c81::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424f5355490b426f726e206f6e20737569ce01426f726e206f6e205375692c20424f53554920697320616c6c2061626f7574206d656d65732c20636f6d6d756e6974792c20616e6420686176696e672066756e20696e207468652063727970746f20756e6976657273652e204e6f20636f6d706c6963617465642073746f7279e280946a757374206120626f6c64206d6173636f742c20612067726f77696e672061726d792c20616e64206f6e65206d697373696f6e3a206d616b6520424f53554920696d706f737369626c6520746f2069676e6f72652e20f09f9a80f09f92a71f68747470733a2f2f692e696d6775722e636f6d2f574464565175482e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

