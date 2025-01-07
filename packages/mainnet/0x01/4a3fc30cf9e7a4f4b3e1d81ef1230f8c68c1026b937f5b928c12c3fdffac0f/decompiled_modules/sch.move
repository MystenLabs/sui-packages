module 0x14a3fc30cf9e7a4f4b3e1d81ef1230f8c68c1026b937f5b928c12c3fdffac0f::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 9, b"SCH", b"SuiCash", b"$SCH is not just a cryptocurrency, it's a lifestyle for the bold and the trendsetting token for those who dare to dream and live large. Suicash is the epitome of wealth meets swag. Website https://suicash.com Twitter https://twitter.com/suicash_sch Telegram https://t.me/suicash_sch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicash.com/wp-content/uploads/2023/12/suicash.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

