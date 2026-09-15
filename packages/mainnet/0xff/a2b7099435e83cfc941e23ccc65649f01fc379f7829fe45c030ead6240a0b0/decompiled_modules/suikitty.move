module 0xffa2b7099435e83cfc941e23ccc65649f01fc379f7829fe45c030ead6240a0b0::suikitty {
    struct SUIKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIKITTY>(arg0, 9, 0x1::string::utf8(b"SUIKITTY"), 0x1::string::utf8(b"SuiKitty"), 0x1::string::utf8(b"sui"), 0x1::string::utf8(b"https://gateway.irys.xyz/UtuJGDYk7F0u29C96yhR0m0lPVhOEi2ky2FMV9iWTgI"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIKITTY>>(0x2::coin::mint<SUIKITTY>(&mut v2, 3000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SUIKITTY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUIKITTY>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

