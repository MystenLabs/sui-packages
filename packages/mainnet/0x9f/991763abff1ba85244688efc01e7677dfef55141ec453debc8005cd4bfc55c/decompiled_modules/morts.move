module 0x9f991763abff1ba85244688efc01e7677dfef55141ec453debc8005cd4bfc55c::morts {
    struct MORTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MORTS>(arg0, 9, untag(b"SMORTS"), untag(b"NMORTS"), untag(b"DBackward Strom"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiebz3tlrusuki6npf55ivd4qgch2wsh3u46fxer5iw4qe4r5ryqpa"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MORTS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MORTS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MORTS>>(0x2::coin::mint<MORTS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

