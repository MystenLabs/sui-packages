module 0x5dd9311f2d55403a25eac21d2853c8999d11485a1230562ea8be7613792d1d64::jean {
    struct JEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JEAN>(arg0, 9, untag(b"SJEAN"), untag(b"NJean sui"), untag(b"D||{\"twitter\":\"https://x.com/saksidasaksi/status/2102720678638023104\",\"website\":\"https://jeansui.xyz/\",\"telegram\":\"https://t.me/jeansui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiaipnu22n5yztfjfbe2wc76tnxdqmqrragraylfle52wdnxmrg534"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<JEAN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<JEAN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<JEAN>>(0x2::coin::mint<JEAN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

