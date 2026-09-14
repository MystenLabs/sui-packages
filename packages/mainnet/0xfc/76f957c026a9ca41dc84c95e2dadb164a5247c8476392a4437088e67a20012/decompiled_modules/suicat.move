module 0xfc76f957c026a9ca41dc84c95e2dadb164a5247c8476392a4437088e67a20012::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICAT>(arg0, 9, untag(b"SSUICAT"), untag(b"NSuicat"), untag(b"DThe Bald Cat of Sui"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeif4kx2u4oc2xp2gz6g2jcrmt4r7a3nubcsifnqlgr25z3vgcuvf3i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICAT>>(0x2::coin::mint<SUICAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

