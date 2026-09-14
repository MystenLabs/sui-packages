module 0x4a6b3e8456adf0de3775869863e8167b16d9f0b9a20bc4cfa581fa774479635a::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STORM>(arg0, 9, untag(b"SSTORM"), untag(b"NSTORM"), untag(b"DCalm down before the $STORM coming!"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeigglwfbhpyt6vlpeeketqpmzbntz6d52fuilwmpf73isinryo3miy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STORM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STORM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STORM>>(0x2::coin::mint<STORM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

