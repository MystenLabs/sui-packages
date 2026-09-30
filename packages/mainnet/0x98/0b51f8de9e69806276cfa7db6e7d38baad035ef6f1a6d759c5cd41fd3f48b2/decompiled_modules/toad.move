module 0x980b51f8de9e69806276cfa7db6e7d38baad035ef6f1a6d759c5cd41fd3f48b2::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOAD>(arg0, 9, untag(b"STOAD"), untag(b"NThe Toad Pepe"), untag(b"D||{\"twitter\":\"https://x.com/eltoadpepe\",\"website\":\"https://eltoadpepe.fun/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreic75vgnflpkcff4uh645tud5tjuzaifgfklpzjhse7ifyr3xssvui"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TOAD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TOAD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOAD>>(0x2::coin::mint<TOAD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

