module 0xb213ed6db3d96f6a2a285cc381c993c62d8152669272d02200c3f3c545d6ef3::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WATER>(arg0, 9, untag(b"SWATER"), untag(b"NWater"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreif45qhupwhwf2xrlpdubmsbl2yvfxbfr4tmm7tjr4fubaiovjct34"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WATER>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WATER>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WATER>>(0x2::coin::mint<WATER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

