module 0xa76e7134a8626e62f714b3184e240e3226c669d5b8b323651574cdf05ae19e3c::xxvip {
    struct XXVIP has drop {
        dummy_field: bool,
    }

    public fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XXVIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XXVIP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: XXVIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XXVIP>(arg0, 6, 0x1::string::utf8(b"XXVIP"), 0x1::string::utf8(b"XXVIPTOKENPOCKET"), 0x1::string::utf8(b"XXVIP Token (XXVIPTOKENPOCKET)"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XXVIP>>(0x2::coin::mint<XXVIP>(&mut v2, 8899889000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin_registry::make_supply_fixed_init<XXVIP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<XXVIP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXVIP>>(0x2::coin_registry::make_regulated<XXVIP>(&mut v3, false, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XXVIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<XXVIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

