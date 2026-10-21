module 0xf612c7ea8de84d83bc3addce743c8c101c966937b032d9888c959c0db8cf81de::wl20 {
    struct WL20 has drop {
        dummy_field: bool,
    }

    fun create_and_deliver_currency(arg0: WL20, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: u8, arg9: address, arg10: bool, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 2, 13835058428945039372);
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WL20>(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WL20>>(0x2::coin::mint<WL20>(&mut v2, arg6, arg12), arg7);
        };
        let v4 = &arg8;
        if (*v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WL20>>(v2, arg9);
        } else if (*v4 == 1) {
            0x2::coin_registry::make_supply_fixed_init<WL20>(&mut v3, v2);
        } else {
            0x2::coin_registry::make_supply_burn_only_init<WL20>(&mut v3, v2);
        };
        if (arg10) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WL20>>(0x2::coin_registry::finalize<WL20>(v3, arg12), arg11);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<WL20>(v3, arg12);
        };
    }

    fun init(arg0: WL20, arg1: &mut 0x2::tx_context::TxContext) {
        create_and_deliver_currency(arg0, 9, 0x1::string::utf8(b"WL20"), 0x1::string::utf8(b"Whitelist 20 Test"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0, @0x5ee1, 0, @0x16941cd1ecf567d1fa519edfa39503f4b926f577779779aeaa6af1640318665, false, @0x3e7a, arg1);
    }

    // decompiled from Move bytecode v7
}

