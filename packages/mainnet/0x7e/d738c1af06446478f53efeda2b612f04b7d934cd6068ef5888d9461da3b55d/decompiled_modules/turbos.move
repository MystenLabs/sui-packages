module 0x7ed738c1af06446478f53efeda2b612f04b7d934cd6068ef5888d9461da3b55d::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TURBOS>(arg0, 9, untag(b"STURBOS"), untag(b"NTurbos"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreiadajdarelhz4orlg2hcmp4thu44mcsimx7euxdjt2plzqj62dp5a"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TURBOS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TURBOS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TURBOS>>(0x2::coin::mint<TURBOS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

