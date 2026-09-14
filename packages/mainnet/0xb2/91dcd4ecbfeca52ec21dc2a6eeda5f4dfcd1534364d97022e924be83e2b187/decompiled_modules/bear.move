module 0xb291dcd4ecbfeca52ec21dc2a6eeda5f4dfcd1534364d97022e924be83e2b187::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BEAR>(arg0, 9, untag(b"SBEAR"), untag(b"NSuiBear"), untag(x"444f6666696369616c204d6173636f74206f662053756920436861696e20697320537569204265617220f09f90bb"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidzjzvig3aunp3qb3pyrlglhjslf4hmm3hahlp5zhmrjsxnbbx3dq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BEAR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BEAR>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BEAR>>(0x2::coin::mint<BEAR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

