module 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::coin_decimals {
    public fun destroy_coin_decimals(arg0: 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<u64, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::CoinDecimals>(&mut v0, 1, arg0);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

