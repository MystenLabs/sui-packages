module 0x657527536b375ec720f53c39ecfe081a04f66434d4b84664d0030c4233863e64::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0542414e4b520842414e4b52535549c80143616c6c65642062792068747470733a2f2f782e636f6d2f62616e6b72626f742076696120404f7572626c617374626f74202240437962756e5f4167656e7420404f7572626c617374626f74207468617420737472696e672069732062617365353820656e636f64656420746578742e206465636f646564206f75747075743a204f7572626c617374626f74206c61756e636820746f6b656e206e616d65203a2042414e4b52535549205449434b4552202442414e4b5220696d6167652042454c4f5720616e64202168747470733a2f2f6f7572626c6173742e78797a2f69636f6e2d3139322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

