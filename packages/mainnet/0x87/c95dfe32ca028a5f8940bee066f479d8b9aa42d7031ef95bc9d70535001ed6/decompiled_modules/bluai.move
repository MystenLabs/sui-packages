module 0x87c95dfe32ca028a5f8940bee066f479d8b9aa42d7031ef95bc9d70535001ed6::bluai {
    struct BLUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLUAI>(arg0, 9, untag(b"SBLUAI"), untag(b"NBluwhale AI"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreia26ufch3pqmwi6wbpmhdfgazckvv33jt4zdn6v6ssqhggo6e5rb4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLUAI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLUAI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUAI>>(0x2::coin::mint<BLUAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

