module 0x96a7b65659de89a6b58d9f49f30dc6f694f76ff77d4119a4eb4739353c2968d7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055341494e54095361696e7420535549f1015361696e74205355492028245341494e54292069732074686520636875726368206f66205375692e20416e206f6c64206d6f6e6b2c2061206379616e2064726f702c20616e64206120636f6d6d756e697479207468617420626c657373657320626167732c2062617074697a6573206368617274732c20616e6420686f6c6473207468726f756768207265642063616e646c65732e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b6657687669336556516173324f446b78222c2274776974746572223a2268747470733a2f2f782e636f6d2f626c657373696e676f6e7375693f733d3131227d2068747470733a2f2f692e696d6775722e636f6d2f6b4539766a5a6d2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

