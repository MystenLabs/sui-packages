module 0xbab12ac11e34da9d322f0e84c1e4d7c0068c360053b6871246ba312b4d948e63::blastoff {
    struct BLASTOFF has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: BLASTOFF, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLASTOFF>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BLASTOFF>>(0x2::coin::mint<BLASTOFF>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTOFF>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<BLASTOFF>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<BLASTOFF>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLASTOFF>>(0x2::coin_registry::finalize<BLASTOFF>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BLASTOFF>(v3, arg12);
        };
    }

    fun init(arg0: BLASTOFF, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"BLASTOFF"), 0x1::string::utf8(b"Blastoff"), 0x1::string::utf8(b"Build your strategy, blast the rocket into space."), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/e8a94ab348b182a867a627d88cfc90a2db94b991703f023ec4b3f1ccf1c81b61.webp"), 0, @0x5ee1, 0, @0xee5c9c539a0793b727476432bc9d9b9c017571021e3ca9f2ca0d30c10d919c1b, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

