module 0x69a62d892c465f43d0dacddb4e45c7fe2267c8f767e0099085384baa64b6e23e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0253490753756920496e757b53756920496e75202d20537570657220696e7520f09f9095f09f92a70a426f726e206f6e205375692e204275696c7420666f7220746865206d656d65732e0a4a75737420616e20496e7520726964696e672074686520626c756520776176652e20f09f8c8a0a4a7573742053756920496e74656c6c6967656e63654268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62633833636366313230363931643263653664643233323561386437646634352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

