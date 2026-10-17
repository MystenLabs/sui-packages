module 0x29712a23a6815f8afa25913cf05b30684f635c6129c9e246d9baa4b5f517cb6e::aftest {
    struct AFTEST has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: AFTEST, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AFTEST>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AFTEST>>(0x2::coin::mint<AFTEST>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTEST>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<AFTEST>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<AFTEST>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AFTEST>>(0x2::coin_registry::finalize<AFTEST>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<AFTEST>(v3, arg12);
        };
    }

    fun init(arg0: AFTEST, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"AFTEST"), 0x1::string::utf8(b"Aftermath Bond Test"), 0x1::string::utf8(b"TSUI test presale. Open to everyone, no wallet cap, migrates to Aftermath when 1,000 TSUI is raised."), 0x1::string::utf8(b"https://dev.blast.fun/blast-ui/dex/aftermath.svg"), 0, @0x5ee1, 0, @0x612fa27ba229021c5a1c32022fd6341ffbd58a87ac928a0dc32d8d6d1dba9fed, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

