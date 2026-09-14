module 0xfb34d639da203dd09b5c3e2204d418fdbe63e4f5e813f6e3f3ab770f732a4e55::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHRIMP>(arg0, 9, untag(b"SSHRIMP"), untag(b"NShrimp"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreihg66l5upqdbentqneffojvw7k6igj3igrrb4hhrovjrqhdkfjk54"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SHRIMP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SHRIMP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHRIMP>>(0x2::coin::mint<SHRIMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

