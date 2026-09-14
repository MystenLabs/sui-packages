module 0x1f6b1e57666f203ae925ccbe986a1d10088b5c20d8bf07a4c215b6e641f518b3::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAM>(arg0, 9, untag(b"SSAM"), untag(b"NSam Blackshear"), untag(b"DTribute to Sam Blackshear"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreic5hrfo2xvfhv3roohrs3j42ke33b7tiyuc55ogojywfb52ksw6gu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SAM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SAM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAM>>(0x2::coin::mint<SAM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

