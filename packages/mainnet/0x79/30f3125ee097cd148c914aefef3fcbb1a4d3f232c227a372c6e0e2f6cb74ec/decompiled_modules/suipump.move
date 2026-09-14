module 0x7930f3125ee097cd148c914aefef3fcbb1a4d3f232c227a372c6e0e2f6cb74ec::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044455434b08537569206475636b80014f6666696369616c20537569204475636b7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f5375694475636b73222c2274776974746572223a2268747470733a2f2f782e636f6d2f4475636b6f6e737569222c2277656273697465223a2268747470733a2f2f7777772e7375696475636b2e66756e2f227d2068747470733a2f2f692e696d6775722e636f6d2f744d70736130392e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

