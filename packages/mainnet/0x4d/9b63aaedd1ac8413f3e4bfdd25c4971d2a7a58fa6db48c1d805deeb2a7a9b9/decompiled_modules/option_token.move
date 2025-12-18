module 0x4d9b63aaedd1ac8413f3e4bfdd25c4971d2a7a58fa6db48c1d805deeb2a7a9b9::option_token {
    struct OPTION_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPTION_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<OPTION_TOKEN>(arg0, 0x2::token::transfer<OPTION_TOKEN>(0x2::token::mint<OPTION_TOKEN>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun transfer(arg0: &mut 0x2::token::TokenPolicy<OPTION_TOKEN>, arg1: &mut 0x2::token::Token<OPTION_TOKEN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request<OPTION_TOKEN>(arg0, 0x2::token::transfer<OPTION_TOKEN>(0x2::token::split<OPTION_TOKEN>(arg1, arg2, arg4), arg3, arg4), arg4);
    }

    fun init(arg0: OPTION_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTION_TOKEN>(arg0, 9, b"OPT", b"Option Token", b"Option Token is a token that represents an option.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.optiontoken.com/favicon.ico"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<OPTION_TOKEN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<OPTION_TOKEN>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        0x2::token::share_policy<OPTION_TOKEN>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPTION_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<OPTION_TOKEN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTION_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

