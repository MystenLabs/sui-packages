module 0x929b1861535e24d411672663443ad7ef3927ad4f1dd532b60fee0594c751aadf::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WHALE>(arg0, 9, untag(b"SWHALE"), untag(b"NWhale"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiezzyykedux2ye4xxfnhnye7udspzilvwxmia3igjydraaigmleje"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WHALE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WHALE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WHALE>>(0x2::coin::mint<WHALE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

