module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_token_cap {
    struct MemezTokenCap<phantom T0> has store {
        policy: address,
        cap: 0x2::token::TokenPolicyCap<T0>,
    }

    public(friend) fun from_coin<T0>(arg0: &MemezTokenCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(arg1, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg0.cap, v1, arg2);
        v0
    }

    public(friend) fun to_coin<T0>(arg0: &MemezTokenCap<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg1, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg0.cap, v1, arg2);
        v0
    }

    public(friend) fun new<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : MemezTokenCap<T0> {
        let (v0, v1) = 0x2::token::new_policy<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::token::allow<T0>(&mut v3, &v2, 0x2::token::transfer_action(), arg1);
        0x2::token::share_policy<T0>(v3);
        MemezTokenCap<T0>{
            policy : 0x2::object::id_address<0x2::token::TokenPolicy<T0>>(&v3),
            cap    : v2,
        }
    }

    // decompiled from Move bytecode v6
}

