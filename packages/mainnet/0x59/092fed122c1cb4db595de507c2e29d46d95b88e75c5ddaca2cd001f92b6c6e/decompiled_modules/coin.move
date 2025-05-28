module 0x59092fed122c1cb4db595de507c2e29d46d95b88e75c5ddaca2cd001f92b6c6e::coin {
    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>>(0x2::coin::mint<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

