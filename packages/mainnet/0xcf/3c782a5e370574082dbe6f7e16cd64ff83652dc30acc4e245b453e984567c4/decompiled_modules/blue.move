module 0xcf3c782a5e370574082dbe6f7e16cd64ff83652dc30acc4e245b453e984567c4::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLUE>(arg0, 9, untag(b"SBLUE"), untag(b"Nblue eyed dog"), untag(b"DBlue eyed puppy"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeighthqp2zvyeayma2grtulbggibocve2x6xief4xqsqb5d7edyb4y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLUE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLUE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUE>>(0x2::coin::mint<BLUE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

