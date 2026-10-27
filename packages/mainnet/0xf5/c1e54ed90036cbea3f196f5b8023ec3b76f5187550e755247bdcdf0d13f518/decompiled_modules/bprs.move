module 0xf5c1e54ed90036cbea3f196f5b8023ec3b76f5187550e755247bdcdf0d13f518::bprs {
    struct BPRS has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: BPRS, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BPRS>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BPRS>>(0x2::coin::mint<BPRS>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPRS>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<BPRS>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<BPRS>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BPRS>>(0x2::coin_registry::finalize<BPRS>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BPRS>(v3, arg12);
        };
    }

    fun init(arg0: BPRS, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"BPRS"), 0x1::string::utf8(b"Blast Presale Test Coin 001 "), 0x1::string::utf8(b"Backend presale launch test for blast.fun on Sui.                 "), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0xc78ddce64e6d20c9950a31afc2bfc1ce8d7fb97cf1b83f7951e35e41032d7d4d, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

