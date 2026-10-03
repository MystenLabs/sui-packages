module 0x1fa8f607fd857ab4834866a942bc47e55f3da7cc018753f6980f752442368ae6::typus {
    struct TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TYPUS>(arg0, 9, untag(b"STYPUS"), untag(b"NTypus"), untag(b"D||{\"twitter\":\"https://twitter.com/TypusFinance\",\"website\":\"https://typus.finance/\",\"telegram\":\"https://t.me/typusfinance\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiczfhzgwdj7rmew7i5v4k7bbwvepnr6q2ytldou2cd5wko24pzo5e"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TYPUS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TYPUS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TYPUS>>(0x2::coin::mint<TYPUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

