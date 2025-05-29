module 0xabf8ce95a5d9e631e2cb304f8efd1b7fa33a61dd2d1e797139289ca6c051fc3f::coin {
    public entry fun batch_mint(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>>(0x2::coin::mint<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2), 0x2::tx_context::sender(arg2));
            v0 = v0 + 1;
        };
    }

    public entry fun mint_usdc(arg0: &mut 0x2::coin::TreasuryCap<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>>(0x2::coin::mint<0x7f0e4d65eb08ff59d73c9abcd4b105cc1e5c9aed9c5b7593c9c489865d71dfe7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

