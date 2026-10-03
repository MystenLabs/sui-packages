module 0xe1e13c167b5212c2ca33c45e5fa838e59375aa68e7cc7b9ba2793dc2b7c9ef8c::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZERO>(arg0, 9, untag(b"SZERO"), untag(b"NZero"), untag(b"D||{\"twitter\":\"https://x.com/Zerodotsui\",\"telegram\":\"https://t.me/zerodotsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiboasn7cmwsnyc3yetdkyemnjjrmxlol5yg4p4y7zluspmnp7rbj4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ZERO>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ZERO>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZERO>>(0x2::coin::mint<ZERO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

