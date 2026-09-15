module 0x28205169c286ca014e8a9701e766f0ff8e380cf8e4b1e1f8012565e9bb4e2c56::sanaa {
    struct SANAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SANAA>(arg0, 9, 0x1::string::utf8(b"SANAA"), 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"f"), 0x1::string::utf8(b"https://gateway.irys.xyz/5RXh6G3ai_Yez6k9iE0t8cwwTN33x82CBA8SZGWCuTc"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SANAA>>(0x2::coin::mint<SANAA>(&mut v2, 1000000000, arg1), @0xee8ade9c3ae68177288a1247b56d41f66488045dabcdcd13e8ddbc7da34be99d);
        0x2::coin_registry::make_supply_fixed_init<SANAA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SANAA>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

