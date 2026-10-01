module 0xa117d08ca9da99efb16042b595dec34c52f6974ddc57256757a6081ae80a4036::rosa {
    struct ROSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ROSA>(arg0, 9, untag(b"SROSA"), untag(b"NRosa Inu"), untag(b"D||{\"website\":\"https://rosatoken.io/\",\"telegram\":\"https://t.me/RosaInuAnnouncement\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiad4fdkdyhul2m2qbophorasqr56ohkafnj5haq3vn4jg2dpi3eq4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ROSA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ROSA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROSA>>(0x2::coin::mint<ROSA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

