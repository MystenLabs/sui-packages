module 0xd0ab953ca1d3816980464305e423b0c2168e7e497d4b641ffb831fca7e311353::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054252494353054252494353fc01425249435320f09f8c8d0a4120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e20696e7370697265642062792074686520425249435320737069726974206f6620676c6f62616c20636f6f7065726174696f6e2c20656d657267696e67206d61726b6574732c20616e642061206d756c7469706f6c617220776f726c642e204e6f2070726f6d697365732c206e6f20706f6c6974696373e280946a757374206d656d65732c20636f6d6d756e6974792c20616e6420646567656e20656e657267792e20f09f9a800a0a425249435320e2809420446966666572656e74204e6174696f6e732e204f6e6520436f6d6d756e6974792e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37626439376533643736323965326463336235376134666239346531643839302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

