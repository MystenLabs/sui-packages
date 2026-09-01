module 0x2a1d762712d1a4e419c5cc3c5357b6392a74878d21db341989dfafb16d3c15e3::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HELLO>(arg0, 9, 0x1::string::utf8(b"HELLO"), 0x1::string::utf8(b"HELLO"), 0x1::string::utf8(b"HELLO"), 0x1::string::utf8(b"https://gateway.irys.xyz/AHp79516t80C0RcCIly9Wd3hrebn6CTNxA-h02tQD-4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HELLO>>(0x2::coin::mint<HELLO>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<HELLO>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HELLO>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

