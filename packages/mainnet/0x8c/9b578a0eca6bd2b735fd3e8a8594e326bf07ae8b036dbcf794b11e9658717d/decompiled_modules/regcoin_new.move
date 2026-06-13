module 0x8c9b578a0eca6bd2b735fd3e8a8594e326bf07ae8b036dbcf794b11e9658717d::regcoin_new {
    struct REGCOIN_NEW has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN_NEW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGCOIN_NEW>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REGCOIN_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<REGCOIN_NEW>(arg0, 6, 0x1::string::utf8(b"REGCOIN"), 0x1::string::utf8(b"Regulated Coin"), 0x1::string::utf8(b"Currency with DenyList Support"), 0x1::string::utf8(b"https://example.com/regcoin.png"), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN_NEW>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<REGCOIN_NEW>>(0x2::coin_registry::finalize<REGCOIN_NEW>(v2, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGCOIN_NEW>>(0x2::coin_registry::make_regulated<REGCOIN_NEW>(&mut v2, true, arg1), v3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN_NEW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGCOIN_NEW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

