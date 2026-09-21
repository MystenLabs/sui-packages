module 0x9c64aedc3afc742b8d0dcfcdfeca2f05b0db746962917374704f68379e8e5016::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554946454e470753756946656e67c6014275696c64696e6720696e20746865205375692065636f73797374656d202e2043726561746f72206f66206d656d652063756c747572652026206469676974616c206173736574732e204c65742773206d616b652077617665737c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f66656e676f6e737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f66656e676f6e737569222c2277656273697465223a22687474703a2f2f73756966656e672e66756e2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65663061343936333032613030313866633261356365303730366664313433372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

