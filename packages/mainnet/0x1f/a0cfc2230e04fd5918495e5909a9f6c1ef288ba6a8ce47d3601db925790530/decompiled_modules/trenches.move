module 0x1fa0cfc2230e04fd5918495e5909a9f6c1ef288ba6a8ce47d3601db925790530::trenches {
    struct TRENCHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TRENCHES>(arg0, 9, untag(b"STRENCHES"), untag(b"NTRENCHES"), untag(b"DTrenches is those who keep dreaming. Trenches is for winners & winners are made in the trenches."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigavbt6dfouognhtl6gds35ezic2axawnno22rg77p4jdzgjupjz4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TRENCHES>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TRENCHES>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRENCHES>>(0x2::coin::mint<TRENCHES>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

