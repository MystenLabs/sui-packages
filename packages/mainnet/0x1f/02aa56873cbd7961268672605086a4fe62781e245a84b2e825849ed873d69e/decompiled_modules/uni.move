module 0x1f02aa56873cbd7961268672605086a4fe62781e245a84b2e825849ed873d69e::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<UNI>(arg0, 9, untag(b"SUNI"), untag(b"NUni"), untag(b"DSui co-founder Evan Cheng's dog"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidaucdhvymmfxho3a3gihrm2e4fbem3rfwr5br5e6uv5kvhosuyxm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<UNI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<UNI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UNI>>(0x2::coin::mint<UNI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

