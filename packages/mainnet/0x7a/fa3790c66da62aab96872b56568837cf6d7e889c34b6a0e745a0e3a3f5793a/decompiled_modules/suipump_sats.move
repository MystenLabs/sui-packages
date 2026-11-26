module 0x7afa3790c66da62aab96872b56568837cf6d7e889c34b6a0e745a0e3a3f5793a::suipump_sats {
    struct SUIPUMP_SATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_SATS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0453415453045361747313486f6c642073617973206561726e20684254434268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f32366533376266636565373438633135303437316666636435616662356332652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_SATS>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_SATS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_SATS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

