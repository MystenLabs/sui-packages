module 0x1160402c64f44bf4ebd651c9636bfefcc9026a77afe334cdf7273b8844a3c8f0::csdk {
    struct CSDK has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: CSDK, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CSDK>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CSDK>>(0x2::coin::mint<CSDK>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSDK>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<CSDK>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<CSDK>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CSDK>>(0x2::coin_registry::finalize<CSDK>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<CSDK>(v3, arg12);
        };
    }

    fun init(arg0: CSDK, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"CSDK"), 0x1::string::utf8(b"Cetus SDK Test Meme"), 0x1::string::utf8(b"Blast SDK standalone Cetus vault smoke test with 0.001 SUI liquidity."), 0x1::string::utf8(b""), 1000000000000000, @0x52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600, 1, @0x7ca9, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

