module 0xf52b95276fa5ed52e866bec36d06dadfd4fc612d893953623208d9bd96653405::pump_fun {
    struct TokenInfo<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_token<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x2::url::Url>(), arg5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v2 = TokenInfo<T0>{
            id           : 0x2::object::new(arg5),
            treasury_cap : v0,
            balance      : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TokenInfo<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

