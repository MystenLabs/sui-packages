module 0xa722edd90bb57f7874eca090c09f2261f1f0672eebc4286c1cf62aee395c11cc::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: SAT, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAT>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SAT>>(0x2::coin::mint<SAT>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<SAT>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<SAT>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAT>>(0x2::coin_registry::finalize<SAT>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SAT>(v3, arg12);
        };
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"SAT"), 0x1::string::utf8(b"sat"), 0x1::string::utf8(b"sat"), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/99c17ccd24f4f547f23ab51dd21ce5bdab91fc7f9412285639f8afb76e43d0c0.webp"), 0, @0x5ee1, 0, @0x40061c709edb896ad029c500de2aee3ef58a062a4b3bd05235d5ae3df6586d8b, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

