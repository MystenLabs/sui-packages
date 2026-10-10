module 0xd10f7392da65d22c8331c7560da16a1583772f4117f817437ae5cea8420f9f9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"09534f5554485041524b0d536f75746820416d65726963619101416c6c2d6e657720657069736f6465206f6620536f75746820416d6572696361206e6f772073747265616d696e67206f6e20506172616d6f756e742b7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f536f7574685061726b222c2277656273697465223a2268747470733a2f2f7777772e736f7574687061726b73747564696f732e636f6d2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34306362393032623035643237303238353638383737343632663735336630382e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

