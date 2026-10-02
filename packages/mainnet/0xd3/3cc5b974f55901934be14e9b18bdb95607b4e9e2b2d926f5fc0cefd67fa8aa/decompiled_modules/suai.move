module 0xd33cc5b974f55901934be14e9b18bdb95607b4e9e2b2d926f5fc0cefd67fa8aa::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUAI>(arg0, 9, untag(b"SSUAI"), untag(b"NSuiAI"), untag(b"D||{\"twitter\":\"https://x.com/SuiAIFun\",\"website\":\"https://suiai.fun\",\"telegram\":\"https://t.me/SuiAiGroup\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihxcontpedvl7lf6snxxlxrfkrlzd4fbjhkr6k7icgr3uzgkbx4k4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUAI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUAI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUAI>>(0x2::coin::mint<SUAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

