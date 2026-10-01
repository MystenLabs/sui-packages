module 0x69e25cf11405941214f377ec8affe85d98e0d90072ffb5603cfc04017be68c66::fair3 {
    struct FAIR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIR3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FAIR3>(arg0, 9, untag(b"SFAIR3"), untag(b"NFair and Free"), untag(b"D||{\"twitter\":\"https://x.com/Fair3_community\",\"website\":\"https://x.com/Fair3_community\",\"telegram\":\"https://t.me/FAIR3_Community\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig5mjnmmrjwd5tfahievbosljat2hvcvwzksk6oxxhwkillfqxew4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<FAIR3>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<FAIR3>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAIR3>>(0x2::coin::mint<FAIR3>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

