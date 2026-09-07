module 0xd2c87b8d580b69e64bd89d4ce9a5219d84749292bfc314a0f7e6c922afb409b6::neeka {
    struct NEEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NEEKA>(arg0, 9, 0x1::string::utf8(b"NEEKA"), 0x1::string::utf8(b"NEEKA"), 0x1::string::utf8(b"NEE"), 0x1::string::utf8(b"https://gateway.irys.xyz/Bu27kBGDJlJs8cFvs8SCa4HHQ9oAG9HLegoAiPRl7wU"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NEEKA>>(0x2::coin::mint<NEEKA>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<NEEKA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NEEKA>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

