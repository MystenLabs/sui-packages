module 0x1796d6a0da8ef08b62ff2f81163ee0aff4c73fcf87616d4a1651915431164682::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SDOG>(arg0, 9, untag(b"SSDOG"), untag(b"NStrom Dog"), untag(b"DDOG SS"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiapgdo5y4psinudzvdzajerxl24362cbsi4en7fn2aj5fiog7f64a"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SDOG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SDOG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOG>>(0x2::coin::mint<SDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

