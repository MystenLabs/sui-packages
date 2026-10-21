module 0x57d930d3b2b34660de7e4178e34773971a52843db60d2b7828a2fb6a37432eb6::rhrsl {
    struct RHRSL has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: RHRSL, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RHRSL>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<RHRSL>>(0x2::coin::mint<RHRSL>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHRSL>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<RHRSL>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<RHRSL>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RHRSL>>(0x2::coin_registry::finalize<RHRSL>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<RHRSL>(v3, arg12);
        };
    }

    fun init(arg0: RHRSL, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"RHRSL"), 0x1::string::utf8(b"Rehearsal"), 0x1::string::utf8(b"test"), 0x1::string::utf8(b"https://p7ns5xeckaua4oov.public.blob.vercel-storage.com/create-logos/a89c04e9de0071dd8838d25d688060f93fb6769a784d086c34f8a90bd9627c49.webp"), 0, @0x5ee1, 0, @0xa92824793d4ca0fc722785e323cfd1b5617fc94b5833cf4808f1c05627bfb364, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

