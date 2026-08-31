module 0x7113cdef4de74915f436955a0077cd2b7c6ba7d2d48c91bede1d2fdc2d99ad89::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"045355494209537569626120496e759b02426f726e2066726f6d20612070617373696f6e20666f7220666169726e65737320616e642066756e2c20537569626120656d706f776572732074686520636f6d6d756e69747920776974682063757474696e672d6564676520746f6f6c7320616e6420612076696272616e742065636f73797374656d2077686572652065766572796f6e65206861732061206368616e636520746f20726964652074686520537569207761766520746f20737563636573732e7c7c7b2274656c656772616d223a22742e6d652f5375696261506f7274616c222c2274776974746572223a2268747470733a2f2f782e636f6d2f73756962616f6e737569222c2277656273697465223a22646973636f72642e67672f4b56644257666d627a6e227d2068747470733a2f2f692e696d6775722e636f6d2f375a724953424b2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

