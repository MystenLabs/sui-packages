module 0xa31364f3198f840bbd56c6a6c9dfae4e749a51c6752792df22c6481836d9e3cf::suipump_bnb {
    struct SUIPUMP_BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03424e420754657374424e42004268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62663230343361343132373430393832366465393537356234666166366266642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_BNB>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_BNB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_BNB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

