module 0x3ebb28124ab111b1bda53603daf152444ebde144c8fbbe5e69514dca8dcfb652::pass_rule {
    struct Pass has drop {
        dummy_field: bool,
    }

    public fun add_rule<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, Pass>(arg0, arg1, 0x1::string::utf8(b"transfer"), arg2);
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::recipient<T0>(arg1);
        let v1 = &v0;
        let v2 = if (0x1::option::is_some<address>(v1)) {
            let v3 = 0x1::option::borrow<address>(v1);
            let v4 = @0x788246363f21790ea08744d7f8e390b192520057cc7aedb362f943b889c6df46;
            if (v3 == &v4) {
                true
            } else {
                let v5 = 0x2::tx_context::sender(arg2);
                v3 == &v5
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v6 = Pass{dummy_field: false};
        0x2::token::add_approval<T0, Pass>(v6, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

