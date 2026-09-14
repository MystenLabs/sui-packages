module 0x811abbb610a06bc7712cdc647f3d397a6df8056c95bad185f45c0540a505d0de::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CRAB>(arg0, 9, untag(b"SCRAB"), untag(b"NCRAB"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigxa5gnjkdttzvl5yc3ulgvc2ryqsv7dxto5ykbpel5cvp2sqitny"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CRAB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CRAB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CRAB>>(0x2::coin::mint<CRAB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

