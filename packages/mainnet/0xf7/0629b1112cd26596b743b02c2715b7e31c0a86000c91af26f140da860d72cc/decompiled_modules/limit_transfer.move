module 0xf70629b1112cd26596b743b02c2715b7e31c0a86000c91af26f140da860d72cc::limit_transfer {
    struct LimitTransfer has drop {
        dummy_field: bool,
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::amount<T0>(arg1) <= 100, 100);
        let v0 = LimitTransfer{dummy_field: false};
        0x2::token::add_approval<T0, LimitTransfer>(v0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

