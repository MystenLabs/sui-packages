module 0xb8335156cd8bd243329b9ead31b1a785cd53d172120a8868d750e5f436480239::alon {
    struct ALON has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: ALON, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALON>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ALON>>(0x2::coin::mint<ALON>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALON>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<ALON>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<ALON>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ALON>>(0x2::coin_registry::finalize<ALON>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<ALON>(v3, arg12);
        };
    }

    fun init(arg0: ALON, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"ALON"), 0x1::string::utf8(b"alon"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/ba86bdc4bdc2fabaf6c11e9324b36784ffb16e00e2400992c9898aa1483bb281.webp"), 0, @0x5ee1, 0, @0x16941cd1ecf567d1fa519edfa39503f4b926f577779779aeaa6af1640318665, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

