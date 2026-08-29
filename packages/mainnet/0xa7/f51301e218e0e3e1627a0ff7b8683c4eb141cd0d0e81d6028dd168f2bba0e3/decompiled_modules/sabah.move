module 0xa7f51301e218e0e3e1627a0ff7b8683c4eb141cd0d0e81d6028dd168f2bba0e3::sabah {
    struct SABAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SABAH>(arg0, 9, 0x1::string::utf8(b"SABAH"), 0x1::string::utf8(b"SABAH"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"https://gateway.irys.xyz/bv9THkpwaH0AFnwIaw5-H-FqaqpISDkQmTpJvkfLD9U"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SABAH>>(0x2::coin::mint<SABAH>(&mut v2, 1000000000, arg1), @0xee8ade9c3ae68177288a1247b56d41f66488045dabcdcd13e8ddbc7da34be99d);
        0x2::coin_registry::make_supply_fixed_init<SABAH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SABAH>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

