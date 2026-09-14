module 0x42192e7b002017a859447dc3c571af5cb8bd842c4249f40124d26a0db432beaf::stromcat {
    struct STROMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROMCAT>(arg0, 9, untag(b"SSTROMCAT"), untag(b"NMaelstrom cat"), untag(b"Dthe official maelstrom cat on sui"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeib2laciote77hjhl2j4zbo4iswpwmx6avepjii2ro3mdiisnga2se"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROMCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROMCAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROMCAT>>(0x2::coin::mint<STROMCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

