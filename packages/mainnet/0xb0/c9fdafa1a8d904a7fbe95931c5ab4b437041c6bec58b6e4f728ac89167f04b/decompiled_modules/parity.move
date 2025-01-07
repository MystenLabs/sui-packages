module 0xb0c9fdafa1a8d904a7fbe95931c5ab4b437041c6bec58b6e4f728ac89167f04b::parity {
    struct PARITY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PARITY>, arg1: 0x2::coin::Coin<PARITY>) {
        0x2::coin::burn<PARITY>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PARITY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PARITY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PARITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARITY>(arg0, 2, b"PARITY", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARITY>>(v1);
        let (v3, v4) = 0x2::token::new_policy<PARITY>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::add_rule_for_action<PARITY, 0xb0c9fdafa1a8d904a7fbe95931c5ab4b437041c6bec58b6e4f728ac89167f04b::ppptry_rule::ParityRule>(&mut v6, &v5, 0x1::string::utf8(b"from_coin"), arg1);
        0x2::token::share_policy<PARITY>(v6);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<PARITY>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun policy_mint_token(arg0: &mut 0x2::coin::TreasuryCap<PARITY>, arg1: &0x2::token::TokenPolicy<PARITY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<PARITY>(0x2::coin::mint<PARITY>(arg0, arg2, arg3), arg3);
        let v2 = v1;
        0xb0c9fdafa1a8d904a7fbe95931c5ab4b437041c6bec58b6e4f728ac89167f04b::ppptry_rule::verify<PARITY>(arg1, &mut v2, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<PARITY>(arg1, v2, arg3);
        0x2::token::keep<PARITY>(v0, arg3);
    }

    public fun treasure_cap_mint_token(arg0: &mut 0x2::coin::TreasuryCap<PARITY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<PARITY>(0x2::coin::mint<PARITY>(arg0, arg1, arg2), arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<PARITY>(arg0, v1, arg2);
        0x2::token::keep<PARITY>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

