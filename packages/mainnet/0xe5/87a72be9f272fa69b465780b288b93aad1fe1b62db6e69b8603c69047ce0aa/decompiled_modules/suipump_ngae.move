module 0xe587a72be9f272fa69b465780b288b93aad1fe1b62db6e69b8603c69047ce0aa::suipump_ngae {
    struct SUIPUMP_NGAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_NGAE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044e474145054e6f476165104e6f20576169742e204e6f204761652e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f31363435663966656539646565333532356431326237353634633265613035622e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_NGAE>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_NGAE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_NGAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

