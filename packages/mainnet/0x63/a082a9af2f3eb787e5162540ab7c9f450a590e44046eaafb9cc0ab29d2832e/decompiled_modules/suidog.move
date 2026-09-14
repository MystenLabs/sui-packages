module 0x63a082a9af2f3eb787e5162540ab7c9f450a590e44046eaafb9cc0ab29d2832e::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIDOG>(arg0, 9, untag(b"SSUIDOG"), untag(b"NSui Dog"), untag(b"DA token for the SUI-dogs"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeif33yqxdq3bezxodxhmdx25no6o5f423lywfv3lqlkjrdktsdt4eq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUIDOG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUIDOG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOG>>(0x2::coin::mint<SUIDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

