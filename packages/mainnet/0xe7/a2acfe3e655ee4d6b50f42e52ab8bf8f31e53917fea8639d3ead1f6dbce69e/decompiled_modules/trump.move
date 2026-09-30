module 0xe7a2acfe3e655ee4d6b50f42e52ab8bf8f31e53917fea8639d3ead1f6dbce69e::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TRUMP>(arg0, 9, untag(b"STRUMP"), untag(b"NOfficial Trump"), untag(b"D||{\"twitter\":\"https://x.com/realDonaldTrump\",\"website\":\"https://gettrumpmemes.com/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibwwg5wwfiv6vn5zaekehunmup3wytn4y6n37lbce2id6c42cwyv4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TRUMP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TRUMP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP>>(0x2::coin::mint<TRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

