module 0x8e27ded2f372f1c43d644044a52776df00f99cfcba4045ff014c82505d7577cf::gld {
    struct GLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GLD>(arg0, 9, untag(b"SGLD"), untag(b"NGOLD"), untag(b"DDigital gold"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeifwxyqfllocbfb23w3ws2yajgs2cxvc2xzfs24imgcygahjmyvmoa"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GLD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GLD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GLD>>(0x2::coin::mint<GLD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

