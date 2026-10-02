module 0xed557920312fc1dadd461fe2bd474871243077cdad8f3b5b6032d0ea987a9078::treat {
    struct TREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TREAT>(arg0, 9, untag(b"STREAT"), untag(b"NShiba Inu Treat"), untag(b"D||{\"twitter\":\"https://x.com/shibtoken\",\"website\":\"https://shib.io/tokens/treat\",\"telegram\":\"https://t.me/shibariumtechnologies\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigu53ed4rvl2ugvpib7bm3j4rxyuhzz3vv3lbmwl2xopgcrjz6fqa"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TREAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TREAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TREAT>>(0x2::coin::mint<TREAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

