module 0x6de8b89a58aa0441f2a9f6ab35881ee4afab72c2b844ebb194f82ea7f64e2e86::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424c4153540b426c617374646f7466756e7443544f206f6620626c6173742e66756e0a4255545454205748454545454e4e4e4e4e4e3f3f3f3f3f7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f626c617374646f7466756e222c2277656273697465223a2268747470733a2f2f7777772e626c6173742e66756e2f227d2068747470733a2f2f692e696d6775722e636f6d2f706a73626c38722e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

