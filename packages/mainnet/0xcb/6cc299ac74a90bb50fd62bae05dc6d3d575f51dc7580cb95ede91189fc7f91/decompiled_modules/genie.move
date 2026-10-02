module 0xcb6cc299ac74a90bb50fd62bae05dc6d3d575f51dc7580cb95ede91189fc7f91::genie {
    struct GENIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GENIE>(arg0, 9, untag(b"SGENIE"), untag(b"NGENIE AI"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreihqwkovdkety7pzikisf6iwbfuust5nerpn2gzgos4kbk5epon3ze"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GENIE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GENIE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GENIE>>(0x2::coin::mint<GENIE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

