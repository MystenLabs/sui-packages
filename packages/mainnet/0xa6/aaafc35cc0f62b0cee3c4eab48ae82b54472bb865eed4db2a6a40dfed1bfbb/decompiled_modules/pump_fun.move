module 0xa6aaafc35cc0f62b0cee3c4eab48ae82b54472bb865eed4db2a6a40dfed1bfbb::pump_fun {
    struct TokenInfo<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_token<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"MANAGED", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v2 = TokenInfo<T0>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            balance      : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TokenInfo<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

