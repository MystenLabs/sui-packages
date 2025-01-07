module 0xb0c9fdafa1a8d904a7fbe95931c5ab4b437041c6bec58b6e4f728ac89167f04b::ppptry_rule {
    struct ParityRule has drop {
        dummy_field: bool,
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::amount<T0>(arg1) % 2 == 1, 0);
        let v0 = ParityRule{dummy_field: false};
        0x2::token::add_approval<T0, ParityRule>(v0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

