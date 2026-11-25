module 0x6ef017545361a5a05ec2324deb186a84c4dab8a0736b0d7470c2b485d10fcb46::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05414c5048410c416c70686120446f67206f6e84015765623a2068747470733a2f2f742e636f2f5854766e706f4d7476712054473a2068747470733a2f2f742e6d652f616c706861646f67207c2042657374206d656d65206f6e20537569205765623a2054473a2043616c6c65642062792068747470733a2f2f782e636f6d2f47727878786b756e2076696120404f7572626c617374626f742168747470733a2f2f6f7572626c6173742e78797a2f69636f6e2d3139322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

