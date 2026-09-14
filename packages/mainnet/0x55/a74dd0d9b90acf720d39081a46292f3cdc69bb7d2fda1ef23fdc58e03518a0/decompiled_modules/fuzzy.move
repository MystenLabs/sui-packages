module 0x55a74dd0d9b90acf720d39081a46292f3cdc69bb7d2fda1ef23fdc58e03518a0::fuzzy {
    struct FUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FUZZY>(arg0, 9, untag(b"SFUZZY"), untag(b"NFuzzy The Walrus Mascot"), untag(b"DFuzzy walrus mascot"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreibv6wn2ew337mbsjlcplpxxeqxrah4pfp3hyhybh3wldeogo7j6aq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FUZZY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FUZZY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FUZZY>>(0x2::coin::mint<FUZZY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

