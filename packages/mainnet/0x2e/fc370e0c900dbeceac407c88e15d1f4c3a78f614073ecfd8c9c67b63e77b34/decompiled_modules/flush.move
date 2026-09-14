module 0x2efc370e0c900dbeceac407c88e15d1f4c3a78f614073ecfd8c9c67b63e77b34::flush {
    struct FLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FLUSH>(arg0, 9, untag(b"SFLUSH"), untag(b"NFlush"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreicmjglatuekazo6ofsqqp3jqipr7frxplmnlhrupauzz3xrvpy5wu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FLUSH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FLUSH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUSH>>(0x2::coin::mint<FLUSH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

