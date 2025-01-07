module 0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::converter {
    public(friend) fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(arg0, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg1, v1, arg2);
        v0
    }

    public(friend) fun to_coin<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg0, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg1, v1, arg2);
        v0
    }

    public(friend) fun transfer<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg1, 0x2::token::transfer<T0>(arg0, arg2, arg3), arg3);
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

