module 0x1ae2e6f745256b91627eea586ab0301c81a30485353b79a04c0941a54e16bc98::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSSS>(arg0, 9, 0x1::string::utf8(b"SSSS"), 0x1::string::utf8(b"SSSS"), 0x1::string::utf8(b"GGG"), 0x1::string::utf8(b"https://gateway.irys.xyz/RyqIn5srF9MekZwThSVHj0LonptCbehTMd-Q8ss4aDk"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SSSS>>(0x2::coin::mint<SSSS>(&mut v2, 12000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SSSS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SSSS>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

