module 0x64ae41f37c9b75dfecfb5a4ac7b5cf0ee9f9190f385493edcf1386a3a5d2bb69::suisaurus {
    struct SUISAURUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAURUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUISAURUS>(arg0, 9, untag(b"SSUISAURUS"), untag(b"NSuiSaurus"), untag(b"DIt's not a pet"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeibcg5cayb2uh3vtartpiup7htm6rrxk3zyvtvp3rylnao7yr4ztme"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUISAURUS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUISAURUS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISAURUS>>(0x2::coin::mint<SUISAURUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

