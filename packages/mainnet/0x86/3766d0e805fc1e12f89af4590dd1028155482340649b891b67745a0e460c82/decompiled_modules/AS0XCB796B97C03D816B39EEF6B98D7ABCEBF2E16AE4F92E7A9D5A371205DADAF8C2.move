module 0x863766d0e805fc1e12f89af4590dd1028155482340649b891b67745a0e460c82::AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2 {
    struct AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, arg1, arg2, arg3);
    }

    public entry fun deny_list_disable_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, arg1, arg2);
    }

    public entry fun deny_list_enable_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, arg1, arg2);
    }

    fun init(arg0: AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, 6, b"fufu", b"ELOOO coin", b"elooo", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2> {
        0x2::coin::mint<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, arg1, arg2)
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AS0XCB796B97C03D816B39EEF6B98D7ABCEBF2E16AE4F92E7A9D5A371205DADAF8C2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

