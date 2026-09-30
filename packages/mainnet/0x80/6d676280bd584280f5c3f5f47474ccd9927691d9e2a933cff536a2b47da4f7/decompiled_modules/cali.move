module 0x806d676280bd584280f5c3f5f47474ccd9927691d9e2a933cff536a2b47da4f7::cali {
    struct CALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CALI>(arg0, 9, untag(b"SCALI"), untag(b"NCALI"), untag(b"D||{\"twitter\":\"https://x.com/CaliTheTerrier\",\"telegram\":\"https://t.me/CaliTheTerrier\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicaud62qiui6jcxulg6vpodugeqts4s24cw2ekmzgmbi2t5tfxxyy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CALI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CALI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CALI>>(0x2::coin::mint<CALI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

