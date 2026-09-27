module 0x7a6d514f8a204678711907c0f8b489c905daa9d8366621759d2d91853e7c9e7a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0241490e4172746966696369616c20496e75a001546865206f6e2d636861696e20414920636f6d6d756e6974792e0a200a24414920706169726564207769746820636f6d7075746520706f7765722e0a457665727920747261646520666565647320746865205661756c742e0a457665727920666565206275726e6564206f72206c6f636b656420666f72657665722e0a200a54686520446f67204973204c6f6e6720436f6d707574652e20f09f90b6f09f928e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f31613035343532656465643466376333363461613132663938616531643965392e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

