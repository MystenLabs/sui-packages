module 0xde2d2211bdbcc488d1e317e19ac06d03aa93f901fbdac49b8022a16b4c11fe38::ballz {
    struct BALLZ has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: BALLZ, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BALLZ>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BALLZ>>(0x2::coin::mint<BALLZ>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLZ>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<BALLZ>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<BALLZ>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BALLZ>>(0x2::coin_registry::finalize<BALLZ>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BALLZ>(v3, arg12);
        };
    }

    fun init(arg0: BALLZ, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"BALLZ"), 0x1::string::utf8(b"Sugma"), 0x1::string::utf8(b"Read both"), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/a89c04e9de0071dd8838d25d688060f93fb6769a784d086c34f8a90bd9627c49.webp"), 0, @0x5ee1, 0, @0x3ef9b4ab75991701fb503bce6d01bd358caa2dbfa1c2efc81577fd40cfff5fc2, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

