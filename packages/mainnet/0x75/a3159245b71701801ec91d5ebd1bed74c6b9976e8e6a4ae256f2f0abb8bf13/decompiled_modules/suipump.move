module 0x75a3159245b71701801ec91d5ebd1bed74c6b9976e8e6a4ae256f2f0abb8bf13::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"035353430f535549205355504552204359434c45ba01535549205355504552204359434c45202824535343292069732061206d656d652d706f7765726564206d6f76656d656e74206275696c742061726f756e64207468652062656c69656620746861742053756920697320656e746572696e67206974732062696767657374206379636c6520796574206173206164656e69796920706f737465642e20e29aa1f09f8c8a0a4f6e6520636861696e2e204f6e65206e61727261746976652e204f6e65207375706572206379636c652e1f68747470733a2f2f692e696d6775722e636f6d2f6237474951474a2e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

