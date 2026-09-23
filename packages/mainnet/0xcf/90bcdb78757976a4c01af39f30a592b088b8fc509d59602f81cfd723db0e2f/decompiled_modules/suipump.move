module 0xcf90bcdb78757976a4c01af39f30a592b088b8fc509d59602f81cfd723db0e2f::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0844454e44495355490544656e64695644656e646920636f6d696e677c7c7b2274656c656772616d223a2268747470733a2f2f6d652e496b616e6173696e222c2274776974746572223a2268747470733a2f2f782e636f6d2f496b616e6173696e5f3133227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f36316330653133633264313634653263666631343866643631353461376433352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

