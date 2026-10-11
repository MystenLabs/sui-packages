module 0xb8e3e3fb844d7fcb57c84552419a445618af49bd5d261516cdd2777c3ec0eb0e::gpc3 {
    struct GPC3 has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: GPC3, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GPC3>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GPC3>>(0x2::coin::mint<GPC3>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPC3>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<GPC3>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<GPC3>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GPC3>>(0x2::coin_registry::finalize<GPC3>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GPC3>(v3, arg12);
        };
    }

    fun init(arg0: GPC3, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"GPC3"), 0x1::string::utf8(b"Gas Pool Concurrency 3"), 0x1::string::utf8(b"Fake coin sponsorship test"), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0xc0e66be2df30455c3b5e4bfa9e648e13bd35acbd1e4040c42f9a599edd6b2be7, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

