module 0xdb6b5cd03c518cc6577f926d83b7882293aec7c68effccc99f7ad4049850b574::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064d4150434154064d4150434154be014d415043415420697320696e737069726564206279206120766972616c20696e7465726e6574206f62736572766174696f6e20746861742074686520776f726c64206d617020726573656d626c65732061206769616e742063617420706c6179696e672077697468204175737472616c69612e7c7c7b2274656c656772616d223a2268747470733a2f2f742e636f2f554d5335434b4f4c6532222c2274776974746572223a2268747470733a2f2f782e636f6d2f4d61706361745f31227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34306636623265363462346164373364313261653262303665663534393233322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

