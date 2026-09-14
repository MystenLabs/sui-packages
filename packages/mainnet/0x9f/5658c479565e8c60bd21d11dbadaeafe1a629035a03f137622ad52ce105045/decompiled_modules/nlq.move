module 0x9f5658c479565e8c60bd21d11dbadaeafe1a629035a03f137622ad52ce105045::nlq {
    struct NLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NLQ>(arg0, 9, 0x1::string::utf8(b"NLQ"), 0x1::string::utf8(x"6ec3a96f6c69746869717565"), 0x1::string::utf8(b"meme cion cat"), 0x1::string::utf8(b"https://gateway.irys.xyz/g-HTm3R7qMmfTWJ-7Gn33GqcV_TAcdAWH_Z0UlHK5u4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NLQ>>(0x2::coin::mint<NLQ>(&mut v2, 1000000000000000000, arg1), @0xec4338803e4b86138e6054dcc6933eebd6e6f05af60150fa2e063f5f6e4d73d1);
        0x2::coin_registry::make_supply_fixed_init<NLQ>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NLQ>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

