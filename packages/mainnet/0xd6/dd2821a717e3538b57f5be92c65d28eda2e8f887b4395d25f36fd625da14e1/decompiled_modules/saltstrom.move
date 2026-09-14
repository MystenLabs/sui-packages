module 0xd6dd2821a717e3538b57f5be92c65d28eda2e8f887b4395d25f36fd625da14e1::saltstrom {
    struct SALTSTROM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTSTROM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SALTSTROM>(arg0, 9, untag(b"SSALTSTROM"), untag(b"NSaltstrom"), untag(b"DWorlds strongest maelstrom - Saltstrom"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiddap5mwf2yljw5yhq7xrzxm5vbpe5bptlz2fyuaycuocz2bq5dbi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SALTSTROM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALTSTROM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SALTSTROM>>(0x2::coin::mint<SALTSTROM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

