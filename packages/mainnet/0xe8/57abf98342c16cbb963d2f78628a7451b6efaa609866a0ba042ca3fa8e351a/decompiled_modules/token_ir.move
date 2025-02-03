module 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun from_balance<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg1, arg2), arg2);
        let v2 = v1;
        let v3 = &mut v2;
        add_approval<T0>(v3, arg2);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg2);
        v0
    }

    public(friend) fun into_balance<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg1, arg2);
        let v2 = v1;
        let v3 = &mut v2;
        add_approval<T0>(v3, arg2);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg2);
        0x2::coin::into_balance<T0>(v0)
    }

    public(friend) fun take<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::take<T0>(arg1, arg2, arg3), arg3);
        let v2 = v1;
        let v3 = &mut v2;
        add_approval<T0>(v3, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg3);
        v0
    }

    fun add_approval<T0>(arg0: &mut 0x2::token::ActionRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x2::token::add_approval<T0, Witness>(v0, arg0, arg1);
    }

    public(friend) fun to_coin<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg1, arg2);
        let v2 = v1;
        let v3 = &mut v2;
        add_approval<T0>(v3, arg2);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg2);
        v0
    }

    public(friend) fun transfer<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x2::token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<T0>(arg1, arg2, arg3);
        let v1 = &mut v0;
        add_approval<T0>(v1, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v0, arg3);
    }

    public(friend) fun init_token<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::token::TokenPolicy<T0>, 0x2::token::TokenPolicyCap<T0>) {
        let (v0, v1) = 0x2::token::new_policy<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::token::add_rule_for_action<T0, Witness>(&mut v3, &v2, 0x2::token::transfer_action(), arg1);
        0x2::token::add_rule_for_action<T0, Witness>(&mut v3, &v2, 0x2::token::spend_action(), arg1);
        0x2::token::add_rule_for_action<T0, Witness>(&mut v3, &v2, 0x2::token::to_coin_action(), arg1);
        0x2::token::add_rule_for_action<T0, Witness>(&mut v3, &v2, 0x2::token::from_coin_action(), arg1);
        (v3, v2)
    }

    public fun merge<T0>(arg0: vector<0x2::token::Token<T0>>) : 0x2::token::Token<T0> {
        0x1::vector::reverse<0x2::token::Token<T0>>(&mut arg0);
        let v0 = 0x1::vector::pop_back<0x2::token::Token<T0>>(&mut arg0);
        let v1 = 0x1::vector::length<0x2::token::Token<T0>>(&arg0);
        while (v1 > 0) {
            0x2::token::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::token::Token<T0>>(&mut arg0));
            v1 = v1 - 1;
        };
        0x1::vector::destroy_empty<0x2::token::Token<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

