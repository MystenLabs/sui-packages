module 0x699fb285b8ae866ef6b0d898ead3bff7de75b1632f5837022da3c1d53811a56e::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TEST>(arg0, 6, b"test", b"TEST", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TEST>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = &mut v3;
        let v5 = internal_mint_coin(v4, 1000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST> {
        0x2::coin::mint<TEST>(arg0, arg1, arg2)
    }

    public entry fun pull(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TEST>(arg0, arg1, arg2, arg3);
    }

    public entry fun push(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

