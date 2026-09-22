module 0xef6283fddf01f22332a2a28c750f8be8c4a16b298e2d13b9007f2902dd1439c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084d4f555345535549084d6f757365737569d801f09f90adf09f92a7204d4f55534520782053554920f09f92990a0a412074696e79206d6f7573652077697468206269672053554920656e657267792120e29aa1f09f9a800a466173742c20637574652c20616e6420726561647920746f2072756e206163726f7373207468652053554920626c6f636b636861696e2e20f09f8c8af09f90ad0a0a536d616c6c206d6f7573652e204269672076696265732e2053554920706f7765722e20f09f928ef09f94a57c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f73756970756d7031227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61323635656466653135636336623562386439663462323437653436393938622e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

