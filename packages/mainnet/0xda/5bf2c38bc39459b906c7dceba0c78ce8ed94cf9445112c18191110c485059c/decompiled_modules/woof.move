module 0xda5bf2c38bc39459b906c7dceba0c78ce8ed94cf9445112c18191110c485059c::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WOOF>(arg0, 9, untag(b"SWOOF"), untag(b"NShibinhood"), untag(b"D||{\"twitter\":\"https://x.com/shibinhoodx\",\"website\":\"https://www.shibinhood.com\",\"telegram\":\"https://t.me/Shibinhood\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigznkxvgdqbzz5psewictf2aqmyj7nhpvv5zbgp3ydctj3bf6fjzu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WOOF>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WOOF>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WOOF>>(0x2::coin::mint<WOOF>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

