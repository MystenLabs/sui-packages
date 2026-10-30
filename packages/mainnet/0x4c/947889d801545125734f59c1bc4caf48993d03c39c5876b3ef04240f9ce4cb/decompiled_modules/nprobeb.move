module 0x4c947889d801545125734f59c1bc4caf48993d03c39c5876b3ef04240f9ce4cb::nprobeb {
    struct NPROBEB has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: NPROBEB, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NPROBEB>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NPROBEB>>(0x2::coin::mint<NPROBEB>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPROBEB>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<NPROBEB>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<NPROBEB>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NPROBEB>>(0x2::coin_registry::finalize<NPROBEB>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NPROBEB>(v3, arg12);
        };
    }

    fun init(arg0: NPROBEB, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"NPROBEB"), 0x1::string::utf8(b"NOGAS isolated speed rehearsal"), 0x1::string::utf8(b"Worthless rehearsal token; no investment value"), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0x565bf4d4fe73f46c8ce402ea0b9aaf50fe66d3b60149acfafdef18a3b1d817be, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

