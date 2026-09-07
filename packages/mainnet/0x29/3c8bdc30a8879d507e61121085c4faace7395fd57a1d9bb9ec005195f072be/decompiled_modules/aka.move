module 0x293c8bdc30a8879d507e61121085c4faace7395fd57a1d9bb9ec005195f072be::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AKA>(arg0, 9, 0x1::string::utf8(b"AKA"), 0x1::string::utf8(b"AKA"), 0x1::string::utf8(b"AKA"), 0x1::string::utf8(b"https://gateway.irys.xyz/s5zo7gIPQhdGgjyfVCRE0JjZd4qsvUZuPt0Lg9dbA74"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AKA>>(0x2::coin::mint<AKA>(&mut v2, 1000000000, arg1), @0xee8ade9c3ae68177288a1247b56d41f66488045dabcdcd13e8ddbc7da34be99d);
        0x2::coin_registry::make_supply_fixed_init<AKA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AKA>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

