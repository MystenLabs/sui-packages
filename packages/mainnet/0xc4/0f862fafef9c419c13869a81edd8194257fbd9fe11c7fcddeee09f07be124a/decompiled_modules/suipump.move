module 0xc40f862fafef9c419c13869a81edd8194257fbd9fe11c7fcddeee09f07be124a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0247470c476f6c64656e20476f6f736585014120676f6c64656e20676f6f736520697320612076616c7561626c652061737365742c20627573696e6573732c206f7220696e766573746d656e74207468617420636f6e74696e756f75736c792070726f647563657320612073746561647920616e642072656c6961626c652073747265616d206f6620696e636f6d652f70726f6669742e2068747470733a2f2f692e696d6775722e636f6d2f343355745543682e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

