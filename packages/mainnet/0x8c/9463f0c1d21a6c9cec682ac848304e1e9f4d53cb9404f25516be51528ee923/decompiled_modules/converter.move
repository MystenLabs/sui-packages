module 0x8c9463f0c1d21a6c9cec682ac848304e1e9f4d53cb9404f25516be51528ee923::converter {
    public(friend) fun to_coin<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg0, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg1, v1, arg2);
        v0
    }

    public(friend) fun mint_and_keep<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::keep<T0>(0x2::token::mint<T0>(arg0, arg1, arg2), arg2);
    }

    public(friend) fun mint_token_to_coin<T0>(arg0: u64, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::mint<T0>(arg1, arg0, arg2);
        to_coin<T0>(v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

