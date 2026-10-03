module 0x156dffd705798c1bc28ab09e8f4034f17ba1e75137a0660c6c0ec66182aa07a3::jackson {
    struct JACKSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JACKSON>(arg0, 9, untag(b"SJACKSON"), untag(b"NJACKSON"), untag(b"D||{\"twitter\":\"https://x.com/jacksonprotocol\",\"website\":\"https://jackson.io\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigwquhe2djhfoxrpd4l2cws4tfdrfnif6s67l5xlhlhxqsxpmlgw4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<JACKSON>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<JACKSON>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<JACKSON>>(0x2::coin::mint<JACKSON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

