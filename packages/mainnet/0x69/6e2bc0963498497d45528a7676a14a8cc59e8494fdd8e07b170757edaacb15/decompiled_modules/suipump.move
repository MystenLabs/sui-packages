module 0x696e2bc0963498497d45528a7676a14a8cc59e8494fdd8e07b170757edaacb15::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"02474d06474d2053554964676d0a0a4e65772077616c6c706170657220666f7220796f75722070686f6e652e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5375694e6574776f726b2f7374617475732f32313032343334323837393730383132303635227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f65653064663332653864646338366461623163346565333536643233306336342e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

