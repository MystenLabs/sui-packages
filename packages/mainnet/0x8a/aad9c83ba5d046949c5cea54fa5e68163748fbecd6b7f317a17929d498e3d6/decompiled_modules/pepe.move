module 0x8aaad9c83ba5d046949c5cea54fa5e68163748fbecd6b7f317a17929d498e3d6::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PEPE>(arg0, 9, untag(b"SPEPE"), untag(b"NPepe"), untag(b"D||{\"twitter\":\"https://x.com/pepecoineth\",\"website\":\"https://www.pepe.vip/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihdfmhad2jgnkmlsrnl5jzk3r2aaqzovnmbdd65eohtnefbgkhrpm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PEPE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PEPE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

