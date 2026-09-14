module 0x1b34ac8c939eee8fbd4ab8a5047fe7e4abd8fb2efc6dfa7d7159d5d13626bdd5::thunder {
    struct THUNDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUNDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<THUNDER>(arg0, 9, untag(b"STHUNDER"), untag(b"NThunderstrom"), untag(x"447374657020696e746f20746865207468756e6465727374726f6d2e0a0a666972737420746f6b656e2077697468205354524f4d2070616972"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeia3pj4fhdgrxvkwzevysh7rctwvdslnefcy5jgszuemnf37dhqbp4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<THUNDER>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<THUNDER>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<THUNDER>>(0x2::coin::mint<THUNDER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

