module 0x6fb54e384c0a79a68f7b03a4951adf4364f8d046e2d4f097d480e24c4e6bf4df::aic {
    struct AIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AIC>(arg0, 9, untag(b"SAIC"), untag(b"NAI Companions"), untag(b"D||{\"twitter\":\"https://x.com/AIV_Companions\",\"website\":\"https://aivcompanions.com/\",\"telegram\":\"https://t.me/AIV_Companions\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidnsh6oik2flzxjhzsn7nfdidw7hhcse5l3rz4s57txbuim7extj4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AIC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AIC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::mint<AIC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

