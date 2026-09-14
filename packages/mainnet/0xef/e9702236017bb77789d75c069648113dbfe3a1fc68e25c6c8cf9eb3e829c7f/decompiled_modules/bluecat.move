module 0xefe9702236017bb77789d75c069648113dbfe3a1fc68e25c6c8cf9eb3e829c7f::bluecat {
    struct BLUECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLUECAT>(arg0, 9, untag(b"SBLUECAT"), untag(b"NBlue Cat"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreierv2774p4a5dyi3hhs4p6a2jkunqhhom3c36lnip7i2jvpxoxwa4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLUECAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLUECAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUECAT>>(0x2::coin::mint<BLUECAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

