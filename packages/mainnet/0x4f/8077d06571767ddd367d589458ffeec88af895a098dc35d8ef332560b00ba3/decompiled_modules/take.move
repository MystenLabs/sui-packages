module 0x4f8077d06571767ddd367d589458ffeec88af895a098dc35d8ef332560b00ba3::take {
    struct TAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TAKE>(arg0, 9, untag(b"STAKE"), untag(b"NTAKE"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreifgnqkht6zhbjxwxo2raeek7vwrmmdgtg7622wxaqv73yxjmawb3q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TAKE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TAKE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAKE>>(0x2::coin::mint<TAKE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

