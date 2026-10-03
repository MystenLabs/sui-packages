module 0x8e4a868aa49d821ed1f6cb737641c52ce0c14430da0e2991f3b12149366234e::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DMC>(arg0, 9, untag(b"SDMC"), untag(b"NDeLorean"), untag(b"D||{\"twitter\":\"https://twitter.com/deloreanlabs\",\"website\":\"https://deloreanlabs.com/\",\"telegram\":\"https://t.me/deloreanlabs\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidfu4amc6rhyxmvi7rcfpbwiqsxkdwqsabqswhijvbgr37mewu2z4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DMC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DMC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DMC>>(0x2::coin::mint<DMC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

