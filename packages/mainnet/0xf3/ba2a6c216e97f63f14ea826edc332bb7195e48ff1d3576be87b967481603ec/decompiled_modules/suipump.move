module 0xf3ba2a6c216e97f63f14ea826edc332bb7195e48ff1d3576be87b967481603ec::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"07535549464953480753554946495348830154686520636f6f6c6573742066697368206f6e205355497c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f737569666973687465616d222c2274776974746572223a2268747470733a2f2f782e636f6d2f7375696669736858222c2277656273697465223a22687474703a2f2f737569666973682e66756e2f227d4f68747470733a2f2f692e6962622e636f2f32303773306735422f3739313438383638352d313434343938373835373438303733342d333339323931393334313230393933303636342d6e2e77656270");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

