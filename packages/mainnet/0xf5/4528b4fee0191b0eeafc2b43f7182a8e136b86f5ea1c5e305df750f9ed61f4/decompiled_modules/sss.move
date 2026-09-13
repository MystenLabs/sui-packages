module 0xf54528b4fee0191b0eeafc2b43f7182a8e136b86f5ea1c5e305df750f9ed61f4::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSS>(arg0, 9, 0x1::string::utf8(b"SSS"), 0x1::string::utf8(b"SSS"), 0x1::string::utf8(x"5353530d0a535353"), 0x1::string::utf8(b"https://gateway.irys.xyz/Z7UjhN4ezGw-eBi36wkoUBBgvuF5qwkWt6xoBAcvIPY"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SSS>>(0x2::coin::mint<SSS>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SSS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SSS>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

