module 0x68e744debf7128e2df2c9879ea22d2d4672dbcec61a43b68bceead0a11f6da8b::eligible_fill {
    struct ELIGIBLE_FILL has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: ELIGIBLE_FILL, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ELIGIBLE_FILL>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ELIGIBLE_FILL>>(0x2::coin::mint<ELIGIBLE_FILL>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIGIBLE_FILL>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<ELIGIBLE_FILL>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<ELIGIBLE_FILL>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ELIGIBLE_FILL>>(0x2::coin_registry::finalize<ELIGIBLE_FILL>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<ELIGIBLE_FILL>(v3, arg12);
        };
    }

    fun init(arg0: ELIGIBLE_FILL, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"ELIG"), 0x1::string::utf8(b"Noncanonical SDK90 fixed"), 0x1::string::utf8(b"Worthless SDK regression fixture"), 0x1::string::utf8(b""), 123456789, @0x52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600, 1, @0x7ca9, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

