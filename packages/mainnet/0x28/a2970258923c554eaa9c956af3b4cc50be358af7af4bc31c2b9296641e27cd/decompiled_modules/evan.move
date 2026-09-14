module 0x28a2970258923c554eaa9c956af3b4cc50be358af7af4bc31c2b9296641e27cd::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EVAN>(arg0, 9, untag(b"SEVAN"), untag(b"NEvan Cheng"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiehxabedgjaiky2ldi6zrnebm3kdrulwmtgk4ggtm3omhxxpsl4me"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<EVAN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<EVAN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVAN>>(0x2::coin::mint<EVAN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

