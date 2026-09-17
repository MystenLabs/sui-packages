module 0xea3a81962613ae283160257e185214f5f4d0267d89a3c2006762da888a0c4aed::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0653554942554e0853554942554e4e59970153554942554e2054484520424541524445442042554e4e59204f46205355497c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f73756962756e6e79222c2274776974746572223a2268747470733a2f2f782e636f6d2f53756942756e4f6666696369616c222c2277656273697465223a2268747470733a2f2f73756962756e2e65706f63687375692e636f6d2f227d3368747470733a2f2f692e6962622e636f2f73764348315032442f5468692d742d6b2d63682d612d632d742d6e2d31372e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

