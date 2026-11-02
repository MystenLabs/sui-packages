module 0x3a4c233e241212c18d6a8f9bcaf2afdd524bec035e628419d234745b21d3b28f::suipump_brrr {
    struct SUIPUMP_BRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_BRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04425252521442525252202d204d6f6e6579205072696e746572940142525252202d20546865204d6f6e6579205072696e7465722e2054686973206973206e6f74206120746573742e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f42525252535549222c2274776974746572223a2268747470733a2f2f782e636f6d2f42727272737569222c2277656273697465223a2268747470733a2f2f73756970756d702e6f7267227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34366435666635383335393938303364653939303830333931303530386366352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_BRRR>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_BRRR>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_BRRR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

