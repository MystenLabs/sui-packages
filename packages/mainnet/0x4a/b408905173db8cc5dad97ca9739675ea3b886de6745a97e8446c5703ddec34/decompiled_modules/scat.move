module 0x4ab408905173db8cc5dad97ca9739675ea3b886de6745a97e8446c5703ddec34::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCAT>(arg0, 9, untag(b"SSCAT"), untag(b"NAnonymous Strom Cat"), untag(b"DThe Cat Stays Anonymous"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiefk5ifwrwn7jt5hsm7xofbnq766abjnm5fkb5tfcvfb4mm4zyms4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SCAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCAT>>(0x2::coin::mint<SCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

