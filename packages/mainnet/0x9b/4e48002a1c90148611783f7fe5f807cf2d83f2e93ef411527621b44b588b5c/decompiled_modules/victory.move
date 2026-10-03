module 0x9b4e48002a1c90148611783f7fe5f807cf2d83f2e93ef411527621b44b588b5c::victory {
    struct VICTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VICTORY>(arg0, 9, untag(b"SVICTORY"), untag(b"NVictory Token"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreie533yelamuotyy54tzozczqhian45433euxqbgxgyuojxl57a5sm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<VICTORY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<VICTORY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VICTORY>>(0x2::coin::mint<VICTORY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

