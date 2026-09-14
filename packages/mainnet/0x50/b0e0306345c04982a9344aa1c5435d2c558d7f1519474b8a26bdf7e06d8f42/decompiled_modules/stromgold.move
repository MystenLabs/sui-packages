module 0x50b0e0306345c04982a9344aa1c5435d2c558d7f1519474b8a26bdf7e06d8f42::stromgold {
    struct STROMGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROMGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROMGOLD>(arg0, 9, untag(b"SSTROMGOLD"), untag(b"NSGOLD"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeidxo7sfpnio7wpxj3y6zjycgqr75wejjg5qra33yd5pl66fcbwsay"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROMGOLD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROMGOLD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROMGOLD>>(0x2::coin::mint<STROMGOLD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

