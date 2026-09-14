module 0xf631f902e31d96fa8fcb37a68a0ed6aa6d28ebb4afc5a3178365aff704a1e8bf::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STORM>(arg0, 9, untag(b"SSTORM"), untag(b"NSTORMY"), untag(b"DTAKING OVER THE SUI TRENCHES BY STORM"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigovwokfbow6xjxm4a4ucka6et4rdhzwt7vcmkj26sj47ngsql6ga"), arg1);
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

