module 0x6d484643b0324cdfeb399662823e69a4c13114bd78aff09c26c9c7b8ea7f7d5c::coin {
    public entry fun mint_1(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint_fixed(arg0, 10000000, arg1);
    }

    public entry fun mint_2(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint_fixed(arg0, 20000000, arg1);
    }

    public entry fun mint_3(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint_fixed(arg0, 30000000, arg1);
    }

    public entry fun mint_batch(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint_fixed(arg0, 10000000, arg1);
        mint_fixed(arg0, 20000000, arg1);
        mint_fixed(arg0, 30000000, arg1);
    }

    fun mint_fixed(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>>(0x2::coin::mint<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

