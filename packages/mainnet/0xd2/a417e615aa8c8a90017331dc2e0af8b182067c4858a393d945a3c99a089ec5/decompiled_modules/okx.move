module 0xd2a417e615aa8c8a90017331dc2e0af8b182067c4858a393d945a3c99a089ec5::okx {
    struct OKX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OKX>(arg0, 9, 0x1::string::utf8(b"OKX"), 0x1::string::utf8(b"OKX"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"https://gateway.irys.xyz/yXr7agFJPEWycndcC4e4aLmwnhp7UBnVW7V5nepKeLo"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OKX>>(0x2::coin::mint<OKX>(&mut v2, 1000000000, arg1), @0xee8ade9c3ae68177288a1247b56d41f66488045dabcdcd13e8ddbc7da34be99d);
        0x2::coin_registry::make_supply_fixed_init<OKX>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<OKX>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

