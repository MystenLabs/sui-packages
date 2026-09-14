module 0xe6dbf01bf840161aad5a246d1e2def4b8e5d9f0bb1e01d36e3829c4141aa1463::sduck {
    struct SDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SDUCK>(arg0, 9, untag(b"SSDUCK"), untag(b"NSuiduck"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreihytkwtmqpxahqbwtte7ueoqr75dzzj5hub4lslqogxcacc4bzh54"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SDUCK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SDUCK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDUCK>>(0x2::coin::mint<SDUCK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

