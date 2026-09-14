module 0xf3af5dddeed9ebbcb645ca1be2d2a0ed9434243e3a8559aba06338aaf4633e7c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"08504c415954524f4e08504c415954524f4e697c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5375694e6574776f726b2f7374617475732f31373737393930323938333835323139393836222c2277656273697465223a2268747470733a2f2f7777772e706c617974726f6e2e6f6e652f227d2368747470733a2f2f696d672e72656d69742e65652f692f5139613754617955544e7538");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

