module 0x402e70021c3982e02e9c2d2eeeee646812ae6a70ca5087f4e662ed8d0333cf68::lick {
    struct LICK has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: LICK, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LICK>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LICK>>(0x2::coin::mint<LICK>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICK>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<LICK>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<LICK>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LICK>>(0x2::coin_registry::finalize<LICK>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<LICK>(v3, arg12);
        };
    }

    fun init(arg0: LICK, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 6, 0x1::string::utf8(b"LICK"), 0x1::string::utf8(b"lick"), 0x1::string::utf8(b"lick"), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/98f49983c43040ea9f7d106cf15dd3bdb8e8178d924b9c69625de40c302984e5.webp"), 0, @0x5ee1, 0, @0x16941cd1ecf567d1fa519edfa39503f4b926f577779779aeaa6af1640318665, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

