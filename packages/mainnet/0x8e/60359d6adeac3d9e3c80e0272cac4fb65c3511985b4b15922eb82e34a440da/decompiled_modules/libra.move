module 0x8e60359d6adeac3d9e3c80e0272cac4fb65c3511985b4b15922eb82e34a440da::libra {
    struct LIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LIBRA>(arg0, 9, untag(b"SLIBRA"), untag(b"NLibra"), untag(b"DThe Sui blockchain was built from scratch by Mysten Labs and did not simply inherit a previous name, but its core creators and technology trace their origins back to Meta's (Facebook) abandoned Diem project, which was originally named Libra."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidbsz2auvxm6wo4nyu4p6ezsljqni2uq6um6ugjf4nzt62l2656di"), arg1);
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

