module 0xc21f1c0eb6f1e3b84d2aaca5d260e72c55b446293861febfeb8fb5dcda8f473c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0641444550494706416465706967900154686520627261696e69616320626f6172206f66205355492e20414445202b205049477c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f6164657069675f737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f6164657069675f737569222c2277656273697465223a22687474703a2f2f6164657069672e66756e2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f36623234633364613230653364346136653231333565373135393663336462302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

