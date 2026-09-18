module 0xe2a6043e5c7da0ec943522bf5f13cf0fad17db2ba4859b0f52860761d6d32a21::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04464f4d4f04466f6d6f6e5465737420746f6b656e2e20446f206e6f74206275792c20627574207468697320697320746865206669727374205375692050756d70206c61756e63682066726f6d2054656c656772616d2e2068747470733a2f2f742e6d652f416c69656e7a7465636854726164696e67426f744268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f63636331636234653330323462353565616561383338373065313562373037362e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

