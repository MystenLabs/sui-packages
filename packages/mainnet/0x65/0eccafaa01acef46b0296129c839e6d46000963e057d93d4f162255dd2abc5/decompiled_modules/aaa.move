module 0x650eccafaa01acef46b0296129c839e6d46000963e057d93d4f162255dd2abc5::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AAA>(arg0, 9, untag(b"SAAA"), untag(b"Naaa cat"), untag(b"D||{\"twitter\":\"https://x.com/aaaCatSui\",\"website\":\"https://aaacatsui.com/\",\"telegram\":\"https://t.me/aaaCatSui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiejlc5aatqfuug6ofdxdzu4lbqpskes2gycrxwmebntpypgwfqdsm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AAA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AAA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AAA>>(0x2::coin::mint<AAA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

