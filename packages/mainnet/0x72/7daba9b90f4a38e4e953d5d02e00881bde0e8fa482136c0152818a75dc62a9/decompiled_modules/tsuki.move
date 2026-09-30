module 0x727daba9b90f4a38e4e953d5d02e00881bde0e8fa482136c0152818a75dc62a9::tsuki {
    struct TSUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TSUKI>(arg0, 9, untag(b"STSUKI"), untag(b"NTsuki"), untag(b"D||{\"twitter\":\"https://x.com/TsukiCTO\",\"website\":\"https://www.tsuki.dog/\",\"telegram\":\"https://t.me/tsukiCTO\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreia5g6llhdadsc4jkxvn67cqauh6prcyrtcyr2ive2ufjqf2jr3wwe"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TSUKI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TSUKI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TSUKI>>(0x2::coin::mint<TSUKI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

