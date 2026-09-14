module 0xc1ba7ba28524c03f9f3482a25fcfeb0efb08194c21e7156ab793a036a3754927::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICAT>(arg0, 9, untag(b"SSUICAT"), untag(b"NSui Cat"), untag(b"DSui moves fast - so does the SuiCat"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeidppffqeeiu6phtse7gf2376ad2fj45czonjni7oun2yvhec4xx3u"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICAT>>(0x2::coin::mint<SUICAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

