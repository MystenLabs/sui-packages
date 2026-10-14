module 0x701bacc6e60e875da04b1b10a353d47fb357a5a49ccadb2f6aeb8533b9b47e5d::eman {
    struct EMAN has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: EMAN, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EMAN>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<EMAN>>(0x2::coin::mint<EMAN>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMAN>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<EMAN>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<EMAN>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EMAN>>(0x2::coin_registry::finalize<EMAN>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<EMAN>(v3, arg12);
        };
    }

    fun init(arg0: EMAN, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"EMAN"), 0x1::string::utf8(b"eman"), 0x1::string::utf8(b"eman"), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/91d422cb25b58fbd9673a8b9fc2ac0b7d12aca756ebe82d85c44f71fa5f77cdd.webp"), 0, @0x5ee1, 0, @0x40061c709edb896ad029c500de2aee3ef58a062a4b3bd05235d5ae3df6586d8b, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

