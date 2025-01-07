module 0x5c638cd49c6bf1aa6a7e2f754ffe52a6e7a417e2a4edccb2640767a1f0e76b77::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    struct NoSellRule has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let (v3, v4) = 0x2::token::new_policy<TARZAN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::add_rule_for_action<TARZAN, NoSellRule>(&mut v6, &v5, 0x1::string::utf8(b"transfer"), arg1);
        0x2::token::share_policy<TARZAN>(v6);
        0x2::transfer::public_freeze_object<0x2::token::TokenPolicyCap<TARZAN>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public fun verify(arg0: &0x2::coin::Coin<TARZAN>, arg1: &0x2::token::TokenPolicy<TARZAN>, arg2: &mut 0x2::token::ActionRequest<TARZAN>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

