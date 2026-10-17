module 0x7351f5aa696378841883ce86bd4507cbedfa2ab58ce9b3f9f3e773f9f65131ad::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04424f4f4e0f47726f777468206f66204b6576696e6642656c696576656420696e204d797374656e206174206c6f77732e2043616c6c6564206472756e6b20666f72206275696c64696e672077697468205375692e204e6f772c2049e280996d207468652070756e6b2043454f206174204d797374656e20f09fa4aa4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f33613261323736623463323964633737346165393564643631663135643830342e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

