module 0x1decf2abd9a3c18b268a136ce294dc9a795e3de943ce503f4ad06e2da1affa87::suipump_brrr {
    struct SUIPUMP_BRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_BRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04425252520442525252414c657420746865204761696e207072696e74657220676f20425252527c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f42525252737569227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f33363964333732653632616136343339346136656638393830363561303365332e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_BRRR>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_BRRR>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_BRRR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

