module 0x52f18ea5c941b276a383add026ab1e1acbad4fb8135440593a547884b47551c8::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"TRUMP2024", b"President Trump", b"the USA President Trump", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SIMPLE_TOKEN>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<SIMPLE_TOKEN>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        set_rules<SIMPLE_TOKEN>(v5, &v3, arg1);
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(&mut v0, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<SIMPLE_TOKEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<SIMPLE_TOKEN>(v4);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

