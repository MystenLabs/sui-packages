module 0x90e2c78608ffded94e07d588d0bd4a1f20511de69205bb1450f3b6549a24c4d1::mol {
    struct MOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOL>(arg0, 9, untag(b"SMOL"), untag(b"NMolest"), untag(b"Dasdf asdf"), untag(b"I"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MOL>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MOL>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOL>>(0x2::coin::mint<MOL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

