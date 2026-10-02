module 0xcff5ad25b87dedfe4f996f7e6f9276a57696097e7722464fb20c2877890236ce::bnbcat {
    struct BNBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BNBCAT>(arg0, 9, untag(b"SBNBCAT"), untag(b"NBinance Cat"), untag(b"D||{\"twitter\":\"https://x.com/BinanceCat_x\",\"website\":\"https://binance-cat.com/\",\"telegram\":\"https://t.me/BinanceCat_Portal\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreif34peksbaw2toscsx3elgplysqjsivfezux5cxwep7wfei4ntpgi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BNBCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BNBCAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BNBCAT>>(0x2::coin::mint<BNBCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

