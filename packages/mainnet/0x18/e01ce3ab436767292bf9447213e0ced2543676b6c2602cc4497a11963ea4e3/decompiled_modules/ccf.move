module 0x18e01ce3ab436767292bf9447213e0ced2543676b6c2602cc4497a11963ea4e3::ccf {
    struct CCF has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: CCF, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CCF>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CCF>>(0x2::coin::mint<CCF>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCF>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<CCF>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<CCF>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CCF>>(0x2::coin_registry::finalize<CCF>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<CCF>(v3, arg12);
        };
    }

    fun init(arg0: CCF, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"CCF"), 0x1::string::utf8(b"cdfd"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0xf5daf28ca00eb4912d5350e7cb9c71560010192f28bcd435ab77e1873e56f8af, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

