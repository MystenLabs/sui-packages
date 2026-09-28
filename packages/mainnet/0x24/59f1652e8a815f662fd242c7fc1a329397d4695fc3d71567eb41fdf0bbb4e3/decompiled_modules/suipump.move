module 0x2459f1652e8a815f662fd242c7fc1a329397d4695fc3d71567eb41fdf0bbb4e3::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"095349514f4d414e534f097369716f6d616e736f646c6f7665206d65206f722069206665656420796f7520746f6f207369716f6d616e736f7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5365616c734352432f7374617475732f32313034353438393732313037313034353131227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66373037383365326663396538376333623330356264343266656366303964662e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

