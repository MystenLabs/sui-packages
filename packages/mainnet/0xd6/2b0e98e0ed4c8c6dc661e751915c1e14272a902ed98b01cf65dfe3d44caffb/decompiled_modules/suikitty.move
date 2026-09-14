module 0xd62b0e98e0ed4c8c6dc661e751915c1e14272a902ed98b01cf65dfe3d44caffb::suikitty {
    struct SUIKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIKITTY>(arg0, 9, 0x1::string::utf8(b"SUIKITTY"), 0x1::string::utf8(b"SuiKitty"), 0x1::string::utf8(b"SuiKitty is a fun community meme coin on Sui. Fast, playful, and built for the Sui ecosystem."), 0x1::string::utf8(b"https://gateway.irys.xyz/xYwT0v7B8V3TYh468fn80X_VMJ_937vvI2NBRWG-Yzg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIKITTY>>(0x2::coin::mint<SUIKITTY>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SUIKITTY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUIKITTY>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

