module 0xee4003cb476c02b4c0efd223949c3710b19498c913bbd75f8956405cc2fb3b87::fws {
    struct FWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FWS>(arg0, 9, untag(b"SFWS"), untag(b"NFlaming Walrus"), untag(b"DFlaming Walrus, I'm here to set this market on fire; come with me and accumulate WAL..."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiebvhm6qkmawdcdjxbsoiygf6f3ain6vrmh66uoaxuzfkezkvf6uy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FWS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FWS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FWS>>(0x2::coin::mint<FWS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

