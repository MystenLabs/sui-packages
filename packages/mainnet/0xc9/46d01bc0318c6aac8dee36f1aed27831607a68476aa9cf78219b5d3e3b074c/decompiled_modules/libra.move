module 0xc946d01bc0318c6aac8dee36f1aed27831607a68476aa9cf78219b5d3e3b074c::libra {
    struct LIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LIBRA>(arg0, 9, untag(b"SLIBRA"), untag(b"NLibra"), untag(b"DThe Sui blockchain was built from scratch by Mysten Labs and did not simply inherit a previous name, but its core creators and technology trace their origins back to Meta's (Facebook) abandoned Diem project, which was originally named Libra."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigf7goamgshivdjqsqxoicvtabkfgstdkpy7ckktj52axn3ijuckm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LIBRA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LIBRA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIBRA>>(0x2::coin::mint<LIBRA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

