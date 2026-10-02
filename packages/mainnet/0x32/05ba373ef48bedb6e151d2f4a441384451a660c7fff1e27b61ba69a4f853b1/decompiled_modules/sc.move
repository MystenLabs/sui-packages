module 0x3205ba373ef48bedb6e151d2f4a441384451a660c7fff1e27b61ba69a4f853b1::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SC>(arg0, 9, untag(b"SSC"), untag(b"NSuper Cat"), untag(b"D||{\"twitter\":\"https://x.com/SuperCat_RH\",\"website\":\"https://supercatrh.com/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreih5ryklayehif322fooa5nofltspa5e7po24gtc5brooq2pc765ma"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SC>>(0x2::coin::mint<SC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

