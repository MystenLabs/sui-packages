module 0xc245e273b88dd65174d4e6ab352e7262b8fc16aa27d31fce83534d52a48fcd4a::gpc2 {
    struct GPC2 has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: GPC2, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GPC2>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GPC2>>(0x2::coin::mint<GPC2>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPC2>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<GPC2>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<GPC2>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GPC2>>(0x2::coin_registry::finalize<GPC2>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GPC2>(v3, arg12);
        };
    }

    fun init(arg0: GPC2, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"GPC2"), 0x1::string::utf8(b"Gas Pool Concurrency 2"), 0x1::string::utf8(b"Fake coin sponsorship test"), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0x2b1fae5f281a43cd830ca5f216a1715530ce4269b0a4271a4dc1c6cec7df5db3, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

